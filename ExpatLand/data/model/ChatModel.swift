//
//  ChatModel.swift
//  ExpatLand
//
//  Created by User on 05/01/22.
//  Copyright © 2022 cypress. All rights reserved.
//

import Foundation


// MARK: - ChatModel
struct ChatModel: Codable {
    var conversations: Conversations?
    var groupData: GroupData?

    enum CodingKeys: String, CodingKey {
        case conversations
        case groupData = "group_data"
    }
}

// MARK: - Conversations
struct Conversations: Codable {
    let currentPage: Int?
    var data: [MessageModel]?
    let firstPageURL: String?
    let from, lastPage: Int?
    let lastPageURL: String?
    let links: [Link]?
    let nextPageURL: String?
    let path: String?
    let perPage: Int?
    let prevPageURL: String?
    let to, total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case links
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
    
}

// MARK: - Link
struct Link: Codable {
    let url: String?
    let label: String?
    let active: Bool?
}

// MARK: - GroupUser
struct GroupData: Codable {
    let id, type,createdBy: Int?
    let users: [UserModel]?
    var name : String?
    
    enum CodingKeys: String, CodingKey {
        case createdBy = "created_by"
        case id, type ,users , name
    }
}






// MARK: - MappableProtocol Implementation
extension ChatModel: MappableProtocol{
    
    func mapToPersistenceObject() -> RealmChat {
        let model = RealmChat()
        model.id = groupData?.id ?? 0
        model.conversations = conversations?.mapToPersistenceObject()
        model.groupData = groupData?.mapToPersistenceObject()
        return model
    }
    
    static func mapFromPersistenceObject(_ object: RealmChat?) -> ChatModel {
        return ChatModel(conversations: Conversations.mapFromPersistenceObject(object?.conversations) ,groupData: GroupData.mapFromPersistenceObject(object?.groupData))
    }
    
}


// MARK: - MappableProtocol Implementation
extension Conversations: MappableProtocol{
    
    func mapToPersistenceObject() -> RealmConversation {
        let model = RealmConversation()
        model.id = path ?? "0"
        model.currentPage = currentPage ?? 0
        model.data.append(objectsIn: data?.map{ $0.mapToPersistenceObject() } ?? [])
        model.firstPageURL = firstPageURL ?? ""
        model.from = from ?? 0
        model.lastPage = lastPage ?? 0
        model.lastPageURL = lastPageURL ?? ""
        model.nextPageURL = nextPageURL ?? ""
        model.path = path ?? ""
        model.perPage = perPage ?? 0
        model.prevPageURL = prevPageURL ?? ""
        model.to = to ?? 0
        model.total = total ?? 0
        return model
        
    }
    
    static func mapFromPersistenceObject(_ object: RealmConversation?) -> Conversations {
        return Conversations(currentPage: object?.currentPage ,data: object?.data.map{ MessageModel.mapFromPersistenceObject($0)},firstPageURL:object?.firstPageURL,from:object?.from,lastPage: object?.lastPage,lastPageURL: object?.lastPageURL, links: [],nextPageURL:object?.nextPageURL,path:object?.path,perPage:object?.perPage,prevPageURL:object?.prevPageURL,to:object?.to,total:object?.total)
    }
    
}



// MARK: - MappableProtocol Implementation
extension GroupData: MappableProtocol{
    
    func mapToPersistenceObject() -> RealmGroupData {
        let model = RealmGroupData()
        model.id = id ?? 0
        model.type = type ?? 0
        model.createdBy = createdBy ?? 0
        model.name = name ?? ""
        model.users.append(objectsIn: users?.map{ $0.mapToPersistenceObject() } ?? [])
        return model
    }
    
    static func mapFromPersistenceObject(_ object: RealmGroupData?) -> GroupData {
        return GroupData(id: object?.id ,type: object?.type,createdBy: object?.createdBy ,users: object?.users.map{ UserModel.mapFromPersistenceObject($0)}, name: object?.name )
    }
    
}



