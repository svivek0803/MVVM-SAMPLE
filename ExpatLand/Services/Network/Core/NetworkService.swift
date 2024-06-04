//
//  NetworkService.swift
//  ExpatLand
//
//  Created by User on 03/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

extension URLEncoding {
    public func queryParameters(_ parameters: [String: Any]) -> [(String, String)] {
        var components: [(String, String)] = []
        
        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }
        return components
    }
}

protocol NetworkServiceProtocol {
    
    func request<T: Decodable>(with resource: Resource, parameters: [String: Any]?) -> Promise <T>
    func requestWithPath<T: Decodable>(with resource: Resource, parameters: [String: Any]?,path:String) -> Promise <T>
    func requestWithBody<T: Decodable>(with resource: Resource, parameters: [String: Any]?) -> Promise <T>
    func requestWithURLEncoding<T: Decodable>(with resource: Resource, parameters: [String: Any]?) -> Promise <T>
    func requestWithFormData<T: Decodable>(with resource: Resource, parameters: [String: Any]?,profileImage:UIImage?) -> Promise <T>
    func requestFormDataWithPath<T: Decodable>(with resource: Resource,
                                               parameters: [String: Any]? , onProgress: @escaping (Double)-> (),path:String) -> Promise <T>
}

final class WebService: NetworkServiceProtocol {
    
    func requestWithFormData<T>(with resource: Resource, parameters: [String:Any]?,profileImage:UIImage?) -> Promise<T> where T : Decodable{
        return Promise{seal in
            
            guard Connectivity.isConnectedToInternet else {
                seal.reject(self.resolveStatusCodeError(statusCode: 1008))
                return }
            
            let url = "\(Constants.APIEndpoint.baseUrl.rawValue)\(resource.resource.endPoint)"
           
            let img = profileImage ?? nil
            let imgData1 = img?.jpegData(compressionQuality: 0.10)
            AF.upload(multipartFormData: { (multipartFormData) in
               
                for (key, value) in parameters! {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                        
                if let data = imgData1{
                    multipartFormData.append(data, withName: "profile_image", fileName: "file.png", mimeType: "image/png/jpg/jpeg")
                }
            }, to: url, usingThreshold: UInt64.init(), method: .post, headers: HTTPHeaders(getFormDataHeader())).responseDecodable(of: T.self){(response) in
                switch response.result{
                case .success(let data):
                    print(data)
                    if  response.response?.statusCode == 200 {
                        seal.fulfill(data)
                    }
                    else if response.response?.statusCode == 422 {
                        seal.fulfill(data)
                    }
                    else {
                        seal.reject(self.resolveStatusCodeError(statusCode: response.response?.statusCode ?? 500))
                    }
                case .failure(let error):
                    if let httpStatusCode = response.response?.statusCode {
                        seal.reject(self.resolveStatusCodeError(statusCode: httpStatusCode))
                    }
                    else {
                        seal.reject(self.actualError(error: error))
                    }
                }
            }

        }
    }
    
    func requestWithBody<T>(with resource: Resource, parameters: [String : Any]?) -> Promise<T> where T : Decodable {
        return Promise { seal in
            guard Connectivity.isConnectedToInternet else {
                seal.reject(self.resolveStatusCodeError(statusCode: 1008))
                return }
            
            let url = "\(Constants.APIEndpoint.baseUrl.rawValue)\(resource.resource.endPoint)"
            
            AF.request(url,method: resource.resource.method, parameters: parameters, encoding: JSONEncoding.default,headers: HTTPHeaders(getHeaderData())).responseDecodable(of: T.self) { (response) in
                switch response.result{
                case .success(let data):
                    
                    if  response.response?.statusCode == 200 {
                        seal.fulfill(data)
                    }
                    else if  response.response?.statusCode == 409 {
                        seal.fulfill(data)
                    }
                    else if response.response?.statusCode == 422 {
                        seal.fulfill(data)
                    }
                    else {
                        seal.reject(self.resolveStatusCodeError(statusCode: response.response?.statusCode ?? 500))
                    }
                    
                    
                case .failure(let error):
                    
                    if let httpStatusCode = response.response?.statusCode {
                        seal.reject(self.resolveStatusCodeError(statusCode: httpStatusCode))
                    }
                    else {
                        seal.reject(self.actualError(error: error))
                    }
                }
                self.logRequest(response: response, param: parameters)
                self.logResponse(data: response.data)
            }
        }
    }
    
    func requestWithURLEncoding<T>(with resource: Resource, parameters: [String : Any]?) -> Promise<T> where T : Decodable {
        return Promise { seal in
            
            guard Connectivity.isConnectedToInternet else {
                seal.reject(self.resolveStatusCodeError(statusCode: 1008))
                return }
            
            let url = "\(Constants.APIEndpoint.baseUrl.rawValue)\(resource.resource.endPoint)\(queryStringParamsToString(parameters ?? [:]))"
            
            
            AF.request(url,method: resource.resource.method, parameters: nil,headers: HTTPHeaders(getHeaderData())).responseDecodable(of: T.self) { (response) in
                switch response.result{
                case .success(let data):
                    
                    if  response.response?.statusCode == 200 {
                        seal.fulfill(data)
                    }
                    else if response.response?.statusCode == 422 {
                        seal.fulfill(data)
                    }
                    else {
                        seal.reject(self.resolveStatusCodeError(statusCode: response.response?.statusCode ?? 500))
                    }
                    
                    
                case .failure(let error):
                    
                    if let httpStatusCode = response.response?.statusCode {
                        seal.reject(self.resolveStatusCodeError(statusCode: httpStatusCode))
                    }
                    else {
                        seal.reject(self.actualError(error: error))
                    }
                }
                self.logRequest(response: response, param: parameters)
                self.logResponse(data: response.data)
            }
        }
    }
    
    func request<T>(with resource: Resource, parameters: [String : Any]?) -> Promise<T> where T : Decodable {
        
        return Promise { seal in
            
            guard Connectivity.isConnectedToInternet else {
                seal.reject(self.resolveStatusCodeError(statusCode: 1008))
                return }
            
            let url = "\(Constants.APIEndpoint.baseUrl.rawValue)\(resource.resource.endPoint)"
            
            AF.request(url,method: resource.resource.method, parameters: parameters, headers: HTTPHeaders(getHeaderData())).responseDecodable(of: T.self) { (response) in
                switch response.result{
                case .success(let data):
                    
                    if  response.response?.statusCode == 200 {
                        seal.fulfill(data)
                    }
                    else {
                        seal.reject(self.resolveStatusCodeError(statusCode: response.response?.statusCode ?? 500))
                    }
                    
                    
                case .failure(let error):
                    
                    if let httpStatusCode = response.response?.statusCode {
                        seal.reject(self.resolveStatusCodeError(statusCode: httpStatusCode))
                    }
                    else {
                        seal.reject(self.actualError(error: error))
                    }
                }
                self.logRequest(response: response, param: parameters)
                self.logResponse(data: response.data)
            }
        }
        
    }
    
    
    func requestWithPath<T>(with resource: Resource, parameters: [String : Any]? , path:String) -> Promise<T> where T : Decodable {
        
        return Promise { seal in
            
            guard Connectivity.isConnectedToInternet else {
                seal.reject(self.resolveStatusCodeError(statusCode: 1008))
                return }
            
            let url = "\(Constants.APIEndpoint.baseUrl.rawValue)\(resource.resource.endPoint)/\(path)"
            
            AF.request(url,method: resource.resource.method, parameters: parameters, headers: HTTPHeaders(getHeaderData())).responseDecodable(of: T.self) { (response) in
                switch response.result{
                case .success(let data):
                    
                    if  response.response?.statusCode == 200 {
                        seal.fulfill(data)
                    }
                    else {
                        seal.reject(self.resolveStatusCodeError(statusCode: response.response?.statusCode ?? 500))
                    }
                    
                    
                case .failure(let error):
                    
                    if let httpStatusCode = response.response?.statusCode {
                        seal.reject(self.resolveStatusCodeError(statusCode: httpStatusCode))
                    }
                    else {
                        seal.reject(self.actualError(error: error))
                    }
                }
                self.logRequest(response: response, param: parameters)
                self.logResponse(data: response.data)
            }
        }
        
    }
    
    
    func requestFormDataWithPath<T: Decodable>(with resource: Resource,
                                               parameters: [String: Any]? , onProgress: @escaping (Double)-> (),path:String) -> Promise <T>
    {
        return Promise { seal in
            guard Connectivity.isConnectedToInternet else {
                seal.reject(self.resolveStatusCodeError(statusCode: 1008))
                return }
            
            let url = "\(Constants.APIEndpoint.baseUrl.rawValue)\(resource.resource.endPoint)/\(path)"
            
            AF.upload(multipartFormData: { multiPart in
                guard let params = parameters else{return}
                for (key, value) in params {
                    if let allMedia = value as? [MultiPart]{
                        let allkeys = allMedia.map({$0.serverKey})
                        let unique = Array(Set(allkeys))
                        for serverKey in unique{
                            let uploadFile = allMedia.filter({$0.serverKey == serverKey})
                            if uploadFile.count > 1 {
                                for media in uploadFile{
                                    multiPart.append(media.data, withName: "\(media.serverKey)[]", fileName: media.fileNameWithExt, mimeType: media.mimeType.rawValue)
                                }
                            }else{
                                if let media = uploadFile.first{
                                    multiPart.append(media.data, withName: media.serverKey, fileName: media.fileNameWithExt, mimeType: media.mimeType.rawValue)
                                }
                            }
                        }
                    }else if let media = value as? MultiPart{
                        multiPart.append(media.data, withName: media.serverKey, fileName: media.fileNameWithExt, mimeType: media.mimeType.rawValue)
                    }else if let data = "\(value)".data(using: .utf8) {
                        multiPart.append(data, withName: key)
                    }
                    
                }
            },to: url, method: resource.resource.method, headers: HTTPHeaders(getFormDataHeader()))
            .uploadProgress(queue: .main, closure: { progress in
                onProgress(progress.fractionCompleted)
            })
            .responseDecodable(of: T.self) { (response) in
                switch response.result{
                case .success(let data):
                    
                    if  response.response?.statusCode == 200 {
                        seal.fulfill(data)
                    }
                    else {
                        seal.reject(self.resolveStatusCodeError(statusCode: response.response?.statusCode ?? 500))
                    }
                case .failure(let error):
                    if let httpStatusCode = response.response?.statusCode {
                        seal.reject(self.resolveStatusCodeError(statusCode: httpStatusCode))
                    }
                    else {
                        seal.reject(self.actualError(error: error))
                    }
                }
                self.logRequest(response: response, param: parameters)
                self.logResponse(data: response.data)
                
            }
            
            
        }
    }
    
    
    func queryStringParamsToString(_ dictionary: [String: Any]) -> String {
        return dictionary
            .map({(key, value) in "\(key)=\(value)"})
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        
    }
    
    func getHeaderData() -> [String: String]{
        
        var headers = [String: String]()
        headers["Accept"] = "application/json"

        
        if !Constants.userDefaults.getAccessToken().isEmpty {
            headers = [
                "Authorization": "\(Constants.userDefaults.getTokenType()) \(Constants.userDefaults.getAccessToken())"
            ]
        }
        print(Constants.userDefaults.getAccessToken())
        return headers
    }
    
    func getFormDataHeader()->[String:String]{
        var headers = [String: String]()
        headers["Accept"]       = "application/json"
        headers["Content-Type"] = "multipart/form-data"
       
    
        if !Constants.userDefaults.getAccessToken().isEmpty {
            headers["Authorization"] = "\(Constants.userDefaults.getTokenType()) \(Constants.userDefaults.getAccessToken())"
        
    }
        return headers
    }
    
    func actualError(error: AFError) -> NetworkError{
        if let underlyingError = error.underlyingError {
            if let urlError = underlyingError as? URLError {
                switch urlError.code {
                case .notConnectedToInternet:
                    return .noInternetConnectivity
                case .networkConnectionLost:
                    return .noInternetConnectivity
                default:
                    //Do something
                    return .unknown
                }
            }
        }
        return .unknown
    }
    
    
    
    
    private func resolveStatusCodeError(statusCode : Int) -> NetworkError {
        
        switch statusCode {
        case 401:
            return .unauthorize
        case 402:
            return .unauthorize
        case 403:
            return .requestForbidden
        case 404:
            return .serverError
        case 405:
            return .dataNotAvailable
        case 406:
            return .invalidData
        case 422:
            return .validationError
        case 201:
            return .invalidCredentials
        case 202:
            return .emailVerificationPending
        case 500:
            return .serverError
        case 1008:
            return .noInternetConnectivity
        default:
            return .unknown
        }
        
    }
    
    
    
    
    func logResponse(data:Data?) {
        guard let dataValue = data else {
            return
        }
        
        if let json = try? JSONSerialization.jsonObject(with: dataValue, options: .allowFragments) as? [String:Any] {
            Console.log(WebService.prettyPrintDict(with: json))
        }
        else {
            Console.log(String(data: dataValue, encoding: .utf8))
        }
    }
    
    func logRequest<T>(response: DataResponse<T, AFError>, param: [String: Any]?) {
        let url = response.request?.url
        let httpMethod = response.request?.httpMethod
        let code = response.response?.statusCode
        let header = response.response?.headers
        Console.log("URL:- \(String(describing: url))")
        Console.log("HttpMethod:- \(String(describing: httpMethod))")
        Console.log("Code:- \(String(describing: code))")
        Console.log("Param:- \(String(describing: param))")
        Console.log("header:- \(String(describing: header))")
    }
    
    class func prettyPrintDict(with json: [String : Any]) -> String{
        do{
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let string = String(data: data, encoding: String.Encoding.utf8)
            if let string  = string{
                
                return string
            }
        }catch{
            Console.log(error.localizedDescription)
            
        }
        return ""
    }
    
    struct Connectivity {
      static let sharedInstance = NetworkReachabilityManager()!
      static var isConnectedToInternet:Bool {
          return self.sharedInstance.isReachable
        }
    }
}
