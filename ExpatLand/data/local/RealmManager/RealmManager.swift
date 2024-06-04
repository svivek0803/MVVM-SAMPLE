//
//  RealmManager.swift
//  ExpatLand
//
//  Created by User on 03/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import Foundation
import RealmSwift



//MARK: - Storable Protocol
public protocol Storable {
    
}


enum RealmError: Error {
    case eitherRealmIsNilOrNotRealmSpecificModel
    case objectMissing
}

extension RealmError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .eitherRealmIsNilOrNotRealmSpecificModel:
            return NSLocalizedString("eitherRealmIsNilOrNotRealmSpecificModel", comment: "eitherRealmIsNilOrNotRealmSpecificModel")
        case .objectMissing:
            return NSLocalizedString("objectMissing", comment: "Realm Object is missing")
        }
    }
}


protocol RealmManagerDataSource {
    func writeObjects<T: Storable>(with objects: [T])
    func writeObject(with object: Storable)
    func fetchObject<T: Storable>(with object: T.Type,completion:@escaping ([T]) -> Void)
    func updateObjectsWith<T: Object>(with objects: [T])
    func updateObjectWith<T: Object>(with object: T)
    func removeObjects(objects: [Storable])
    func removeObject(object: Storable)
    func removeAll()
    }
    


class RealmManager: RealmManagerDataSource {
    
    //MARK: - Stored Properties
    private let realm: Realm?
    
    init(_ realm: Realm?) {
        self.realm = realm
    }
    
    
    func writeObjects<T>(with objects: [T])  where T : Storable {
        guard let realm = realm, let objects = objects as? [Object] else { return }
        do {
            try realm.write {
                realm.add(objects, update: .modified)
            }
        }
        catch(let error) {
            print("DB  error: \(error.localizedDescription)")
        }
    }
    
    
    func writeObject(with object: Storable)  {
        guard let realm = realm, let object = object as? Object else { return }
        do {
            try realm.write {
                realm.add(object,update: .modified)
            }
        }
        catch(let error) {
            print("DB  error: \(error.localizedDescription)")
        }
    }
    
    func fetchObject<T>(with object: T.Type, completion: @escaping ([T]) -> Void) where T : Storable {
        guard let realm = realm, let object = object as? Object.Type else { return }
        let objects = realm.objects(object)
        completion(objects.compactMap { $0 as? T })
    }
    
    func updateObjectWith<T>(with object: T) where T : Object {
        guard let realm = realm else { return }
        do {
            let result = realm.object(ofType: T.self, forPrimaryKey: object.value(forKeyPath: T.primaryKey()!) as AnyObject)
            
            if let object = result {
                try realm.write {
                    realm.add(object, update: .modified)
                }
            }
        }
        catch(let error) {
            print("DB  error: \(error.localizedDescription)")
        }
    }
    
    func updateObjectsWith<T>(with objects: [T])  where T : Object {
        guard let realm = realm else { return }
        do {
            let primaryKeys = objects.map({ element -> Any in
                return element.value(forKey: T.primaryKey()!) as Any
            })
            
            let response = realm.objects(T.self).filter("%@ IN %@", T.primaryKey()!, primaryKeys)
            
            if response.count != objects.count {
                throw  RealmError.objectMissing
            }
            
            try realm.write {
                realm.add(objects, update: .modified)
            }
        }
        catch(let error) {
            print("DB  error: \(error.localizedDescription)")
        }
    }
    
    func removeObjects(objects: [Storable])  {
        guard let realm = realm, let object = objects as? [Object] else {  return }
        do {
            try realm.write {
                realm.delete(object)
            }
        }
        catch(let error) {
            print("DB  error: \(error.localizedDescription)")
        }
    }
    
    func removeObject(object: Storable)  {
        guard let realm = realm, let object = object as? Object else { return }
        do {
            try realm.write {
                realm.delete(object)
            }
        }
        catch(let error) {
            print("DB  error: \(error.localizedDescription)")
        }
        
    }
    
    func removeAll()  {
        do {
            try self.realm?.write {
                self.realm?.deleteAll()
            }
        }
        catch(let error) {
            print("DB  error: \(error.localizedDescription)")
        }
    }
    
}
