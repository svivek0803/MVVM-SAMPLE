//
//  MessageModel.swift
//  ExpatLand
//
//  Created by User on 05/01/22.
//  Copyright © 2022 cypress. All rights reserved.
//

import Foundation

// MARK: - MessageModel
struct MessageModel: Codable {
    let id: Int?
    let message: String?
    let fileOriginalName:String?
    let type, userID, groupID: Int?
    var createdAt, updatedAt: String?
    let user: UserModel?
    var date: String?
    let isInformationMessage : Bool?

    enum CodingKeys: String, CodingKey {
        case id, message, type
        case userID = "user_id"
        case groupID = "group_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case user , date , isInformationMessage
        case fileOriginalName = "file_original_name"
    }
}

// MARK: - MappableProtocol Implementation
extension MessageModel: MappableProtocol{

    func mapToPersistenceObject() -> RealmMessage {
        let model = RealmMessage()
        model.id = id ?? 0
        model.message = message ?? ""
        model.type = type ?? 0
        model.userID = userID ?? 0
        model.fileOriginalName = fileOriginalName ?? ""
        model.groupID = groupID ?? 0
        model.createdAt = createdAt ?? ""
        model.updatedAt = updatedAt ?? ""
        model.user = user?.mapToPersistenceObject()
        model.isInformationMessage = isInformationMessage ?? false
        return model
    }

    static func mapFromPersistenceObject(_ object: RealmMessage?) -> MessageModel {
        return MessageModel(id: object?.id ,message: object?.message, fileOriginalName: object?.fileOriginalName ,type: object?.type, userID: object?.userID , groupID:object?.groupID ,createdAt: object?.createdAt, updatedAt: object?.updatedAt ,user: UserModel.mapFromPersistenceObject(object?.user) ,isInformationMessage: object?.isInformationMessage )
    }

}
