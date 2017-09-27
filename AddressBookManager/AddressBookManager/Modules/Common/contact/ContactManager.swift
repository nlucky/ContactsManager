//
//  AddRes.swift
//  AddressBookManager
//
//  Created by Cocoa on 2017/9/23.
//  Copyright © 2017年 Cocoa. All rights reserved.
//

import Foundation
import Contacts
import ContactsUI

enum ContactListType {
    case all
    case sameName
    case sameNum
}
// "#1296db"

class ContactManager {
    static let shared: ContactManager = ContactManager()
    fileprivate let contactsStore = CNContactStore()
    fileprivate let keys = [CNContactGivenNameKey, CNContactDatesKey, CNContactTypeKey, CNContactPhoneNumbersKey, CNContactMiddleNameKey, CNContactFamilyNameKey, CNContactImageDataKey] as [CNKeyDescriptor]
    fileprivate lazy var req = CNContactFetchRequest(keysToFetch: keys)

    public func fetchAll() -> [CNContact] {
        var contacts: [CNContact] = [CNContact]()
        let req = CNContactFetchRequest(keysToFetch: keys)
        do {
            try contactsStore.enumerateContacts(with: req) { (contact, obj) in
                contacts.append(contact)
            }
        }catch _ {
        }
        return contacts
    }
    public func fetch(withType type: ContactListType) -> [String : [CNContact]] {
        var map = [String : [CNContact]]()

        func addMap(withKey key: String, contact: CNContact) {
            if map.keys.contains(key) {
                var tempContacts = map[key]
                let sameContacts = tempContacts?.filter({ (r) -> Bool in
                    return r.identifier == contact.identifier
                })
                if sameContacts == nil && sameContacts?.count == 0 {
                    tempContacts?.append(contact)
                    map[key] = tempContacts
                }
            } else{
                map[key] = [contact]
            }
        }
        
        do {
            try contactsStore.enumerateContacts(with: req) { (contact, obj) in
                if type == .sameNum {
                    contact.phoneNumbers.forEach { (value) in
                        let key = value.value.stringValue
                        addMap(withKey: key, contact: contact)
                    }
                } else if type == .sameName {
                    let key = contact.familyName + contact.middleName + contact.givenName
                    addMap(withKey: key, contact: contact)
                }
            }
        }catch let error {
            print(error)
        }
        return map
    }
    
    public func delete(contact: CNContact) {
        guard let deleteContact = contact.mutableCopy() as? CNMutableContact else { return }
        let deletRequest = CNSaveRequest()
        deletRequest.delete(deleteContact)
        do {
            try contactsStore.execute(deletRequest)
        } catch _ {
        }
    }
    
    public func delete(contacts: [CNContact]) {
        contacts.forEach { delete(contact: $0) }
    }
    
}
