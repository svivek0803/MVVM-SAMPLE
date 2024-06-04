//
//  UserFeedbackModel.swift
//  ExpatLand
//
//  Created by Neeraja Mohandas on 17/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation

//MARK: - User feedback
struct UserFeedbackModel: Codable {
    let message: String?
    enum CodingKeys: String, CodingKey{
        case message = "message"
    }
}
