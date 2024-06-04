//
//  NetworkError.swift
//  ExpatLand
//
//  Created by User on 03/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation

enum NetworkError: Error, Equatable  {
    /// Unknown error occurred.
    case unknown
    /// Url is invalid error.
    case badURL
    /// Address entered is invalid error.
    case invalidLocation
    /// Address doesn't exist.
    case locationNotFound
    /// Timeout error.
    case timeout
    /// No Internet connection.
    case noInternetConnectivity
    /// Unauthorised reqest
    case unauthorize // 401
    /// validation error
    case validationError // 422
    /// requestForbidden error
    case requestForbidden // 403
    /// server error
    case serverError // 404
    /// data  not available
    case dataNotAvailable // 405
    /// user not exist
    case userNotExist // 402
    /// invalid data
    case invalidData // 406
    /// email verification  pending
    case emailVerificationPending //202
    /// email verification  pending
    case invalidCredentials //201
}

extension NetworkError: LocalizedError {
    /// A localized message describing what error occurred.
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return "Sorry, an unexpected error has occurred."
        case .badURL:
            return "Unauthorised reqest"
        case .invalidLocation:
            return "Invalid Location provided"
        case .locationNotFound:
            return "Location is not available."
        case .timeout:
            return "Request timeout"
        case .noInternetConnectivity:
            return "No Internet Connection."
        case .unauthorize:
            return "Registration permission is pending"
        case .validationError:
            return "Invalid login details"
           // return "Validation error"
        case .requestForbidden:
            return "Request forbidden error"
        case .serverError:
            return "Server Error"
        case .dataNotAvailable:
            return "Data  not availabler"
        case .userNotExist:
            return "User not exist"
        case .invalidData:
            return "Invalid data"
        case .emailVerificationPending:
            return "Email verification pending"
        case .invalidCredentials:
            return "Invalid login details"
        }
    }
}
