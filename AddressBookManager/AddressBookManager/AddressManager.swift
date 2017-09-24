//
//  AddRes.swift
//  AddressBookManager
//
//  Created by Cocoa on 2017/9/23.
//  Copyright © 2017年 Cocoa. All rights reserved.
//

import Foundation

import AddressBookUI
import AddressBook

import Contacts

enum AddressListType {
    case all
    case sameName
    case sameNum
}

class AddressManager {
    static let shared: AddressManager = AddressManager()
    fileprivate let contactsStore = CNContactStore()
//    fileprivate var addressBook: ABAddressBook?
    fileprivate let keys = [CNContactGivenNameKey, CNContactDatesKey, CNContactTypeKey, CNContactPhoneNumbersKey, CNContactMiddleNameKey, CNContactFamilyNameKey] as [CNKeyDescriptor]
    func fetchAddressList(_ type: AddressListType = .all) -> [Any]? {
        let r = fetchAllList()
        return r
    
    }
    func fetchAllList() -> [CNContact] {
        var contacts: [CNContact] = [CNContact]()
       
        let req = CNContactFetchRequest(keysToFetch: keys)
        do {
            try contactsStore.enumerateContacts(with: req) { (contact, obj) in
                contacts.append(contact)
                print("givenName \(contact.givenName) familyname \(contact.familyName) num \(contact.phoneNumbers.first?.value.stringValue ?? "")")
            }    
            
        }catch _ {            
        }
        return contacts
    }
    func fetchSameNumberList() -> [String : [CNContact]] {
        var map = [String : [CNContact]]()
        let req = CNContactFetchRequest(keysToFetch: keys)
        do {
            try contactsStore.enumerateContacts(with: req) { (contact, obj) in
                contact.phoneNumbers.forEach { (value) in
                    let key = value.value.stringValue
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
                print("givenName \(contact.givenName) familyname \(contact.familyName) num \(contact.phoneNumbers.first?.value.stringValue ?? "")")
            }    
            
        }catch _ {            
        }
        return map
    }
    func t8/ -> [..0-9- : [CNContact]] {
        var map = [String : [CNContact]]()

        return map
    }
    
}
