//
//  GroupListModel.swift
//  ExpatLand
//
//  Created by User on 04/01/22.
//  Copyright © 2022 cypress. All rights reserved.
//

import Foundation

// MARK: - GroupListModel
struct GroupListModel: Codable {
    let id: Int?
    var groups: [Group]?
}

// MARK: - Group
struct Group: Codable {
    let id, type, unseenCount: Int?
    let lastConversation: LastConversation?
    let users: [UserModel]?
    let name: String?
   

    enum CodingKeys: String, CodingKey {
        case id, type
        case unseenCount = "unseen_count"
        case lastConversation = "last_conversation"
        case users,name
    }
}

// MARK: - LastConversation
struct LastConversation: Codable {
    let id, userID, groupID: Int?
    let message: String?
    let type: Int?
    let createdAt: String?
    let lastStatus: LastStatus?
    let lastConversationUserData: LastConversationUserData?
    let fileOriginalName:String?


    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case groupID = "group_id"
        case message, type
        case createdAt = "created_at"
        case lastStatus = "last_status"
        case lastConversationUserData = "last_conversation_user_data"
        case fileOriginalName = "file_original_name"
        
    }
}

// MARK: - LastStatus
struct LastStatus: Codable {
    let conversationID, status: Int?

    enum CodingKeys: String, CodingKey {
        case conversationID = "conversation_id"
        case status
    }
}

// MARK: - LastConversationUserData
struct LastConversationUserData: Codable {
    var id: Int?
    var firstName, lastName: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}







// MARK: - MappableProtocol Implementation
extension GroupListModel: MappableProtocol{

    func mapToPersistenceObject() -> RealmGroupList {
        let model = RealmGroupList()
        model.id = 0
        model.groups.append(objectsIn: groups?.map{ $0.mapToPersistenceObject() } ?? [])
        return model
    }

    static func mapFromPersistenceObject(_ object: RealmGroupList?) -> GroupListModel {
        return GroupListModel(id: object?.id , groups: object?.groups.map{ Group.mapFromPersistenceObject($0)})
    }

}


// MARK: - MappableProtocol Implementation
extension Group: MappableProtocol{

    func mapToPersistenceObject() -> RealmGroup {
        let model = RealmGroup()
        model.id = id ?? 0
        model.type = type ?? 0
        model.unseenCount = unseenCount ?? 0
        model.name = name ?? ""
        model.lastConversation = lastConversation?.mapToPersistenceObject()
        model.users.append(objectsIn: users?.map{ $0.mapToPersistenceObject() } ?? [])
        return model
    }

    static func mapFromPersistenceObject(_ object: RealmGroup?) -> Group {
        return Group(id: object?.id ,type: object?.type, unseenCount: object?.unseenCount, lastConversation: LastConversation.mapFromPersistenceObject(object?.lastConversation) ,users: object?.users.map{ UserModel.mapFromPersistenceObject($0)},name: object?.name)
    }

}


// MARK: - MappableProtocol Implementation
extension LastConversation: MappableProtocol{

    func mapToPersistenceObject() -> RealmLastConversation {
        let model = RealmLastConversation()
        model.id = id ?? 0
        model.userID = userID ?? 0
        model.type = type ?? 0
        model.groupID = groupID ?? 0
        model.message = message ?? ""
        model.createdAt = createdAt ?? ""
        model.fileOriginalName = fileOriginalName ?? ""
        model.lastStatus = lastStatus?.mapToPersistenceObject()
        model.lastConversationUserData = lastConversationUserData?.mapToPersistenceObject()
        return model
    }

    static func mapFromPersistenceObject(_ object: RealmLastConversation?) -> LastConversation {
        return LastConversation(id: object?.id , userID: object?.userID, groupID: object?.groupID , message:object?.message, type: object?.type, createdAt: object?.createdAt , lastStatus: LastStatus.mapFromPersistenceObject(object?.lastStatus), lastConversationUserData: LastConversationUserData.mapFromPersistenceObject(object?.lastConversationUserData), fileOriginalName: object?.fileOriginalName )
    }

}



// MARK: - MappableProtocol Implementation
extension LastStatus: MappableProtocol{
    
    func mapToPersistenceObject() -> RealmLastStatus {
        let model = RealmLastStatus()
        model.conversationID = conversationID ?? 0
        model.status = status ?? 0
        return model
    }

    static func mapFromPersistenceObject(_ object: RealmLastStatus?) -> LastStatus {
        return LastStatus(conversationID: object?.conversationID  , status: object?.status)
    }

}

// MARK: - MappableProtocol Implementation
extension LastConversationUserData: MappableProtocol{

    func mapToPersistenceObject() -> RealmLastConversationUserData {
        let model = RealmLastConversationUserData()
        model.id = id ?? 0
        model.firstName = firstName ?? ""
        model.lastName = lastName ?? ""
        return model
    }

    static func mapFromPersistenceObject(_ object: RealmLastConversationUserData?) -> LastConversationUserData {
        return LastConversationUserData(id: object?.id , firstName: object?.firstName,lastName: object?.lastName)
    }

}
