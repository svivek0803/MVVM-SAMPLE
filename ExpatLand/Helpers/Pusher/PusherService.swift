//
//  PusherService.swift
//  ExpatLand
//
//  Created by User on 08/01/22.
//  Copyright © 2022 cypress. All rights reserved.
//

import Foundation
import PusherSwift
import PushNotifications


protocol PusherServiceProtocol {
    func subscribeToChannel(groupId:String ,completion:@escaping (Result<MessageModel>) -> Void)
    func disconnect()
    func authorisePusherBeamUser()
    func clearState()
    func registerDeviceToken()
}

final class PusherService:PusherServiceProtocol ,  PusherDelegate {
    
    var pusher : Pusher!
    let beamsClient = PushNotifications.shared
    
    func subscribeToChannel(groupId:String ,completion:@escaping (Result<MessageModel>) -> Void)
    {
        
        let nameOfChannel = "private-groups.\(groupId)"
        let options = PusherClientOptions( authMethod: AuthMethod.authRequestBuilder(authRequestBuilder: AuthRequestBuilder()),host: .cluster(PusherConfig.cluster))
        pusher = Pusher(key: PusherConfig.apiKey, options: options )
        pusher.delegate = self
        pusher.subscribe(channelName: nameOfChannel).bind(eventName: PusherConfig.newMessageEvent, eventCallback: { (event: PusherEvent) in
            
            guard let json: String = event.data,
                  let jsonData: Data = json.data(using: .utf8)
            else {
                completion(.failure(error: NetworkError.dataNotAvailable))
                return
            }
            let decodedMessage = try? JSONDecoder().decode(MessageModel.self, from: jsonData)
            guard let message = decodedMessage else {
                completion(.failure(error: NetworkError.dataNotAvailable))
                return
            }
            completion(.success(value: message))
           
        })
        pusher.connect()
        
    }
    
    
    func disconnect() {
        guard pusher != nil else { return }
        pusher.disconnect()
    }
    
    
    // PusherDelegate methods
    func changedConnectionState(from old: ConnectionState, to new: ConnectionState) {
        // print the old and new connection states
        print("old: \(old.stringValue()) -> new: \(new.stringValue())")
    }
    
    func subscribedToChannel(name: String) {
        print("Subscribed to \(name)")
    }
    
    func debugLog(message: String) {
        print("error pusher" , message)
    }
    
    func receivedError(error: PusherError) {
        if let code = error.code {
            print("Received error: (\(code)) \(error.message)")
        } else {
            print("Received error: \(error.message)")
        }
    }
    
    func authorisePusherBeamUser()
    {
        guard Constants.userDefaults.getNotificationStatus() == 1 else { return }
        
        let url = "\(Constants.APIEndpoint.baseUrl.rawValue)\(Constants.APIEndpoint.beamsAuthUrl.rawValue)"
        let tokenProvider = BeamsTokenProvider(authURL: url) { () -> AuthData in
            
            let headers = ["Authorization": "\(Constants.userDefaults.getTokenType()) \(Constants.userDefaults.getAccessToken())"] // Headers your auth endpoint needs
            let queryParams: [String: String] = [:] // URL query params your auth endpoint needs
            return AuthData(headers: headers, queryParams: queryParams)
        }
        self.beamsClient.setUserId(Constants.userDefaults.getUserId().toString(), tokenProvider: tokenProvider, completion: { error in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            
            print("Successfully authenticated with Pusher Beams")
        })
    }
    
    func clearState()
    {
        self.beamsClient.clearAllState {
          print("Successfully cleared all state")
        }
    }
    
    func registerDeviceToken()
    {
        if let token = Constants.userDefaults.getDeviceToken() {
            self.beamsClient.registerDeviceToken(token)
        }
    }
    
}

class AuthRequestBuilder: AuthRequestBuilderProtocol {
    func requestFor(socketID: String, channelName: String) -> URLRequest? {
        let url = "\(Constants.APIEndpoint.baseUrl.rawValue)\(Constants.APIEndpoint.broadCasting.rawValue)"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.httpBody = "socket_id=\(socketID)&channel_name=\(channelName)".data(using: String.Encoding.utf8)
        request.setValue( "\(Constants.userDefaults.getTokenType()) \(Constants.userDefaults.getAccessToken())", forHTTPHeaderField: "Authorization")
        return request
        
    }
}
