//
//  Fiserv
//
//  Created by omar.ata on 4/9/21.
//

import UIKit
import WebKit
import Contacts
import ContactsUI

class ContactsHandler: NSObject, WKScriptMessageHandler {
    var bridgeView: BridgeView
    init(bridgeView: BridgeView) {
        self.bridgeView = bridgeView
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case "getContacts": getContacts()
        case "getOneContact": getOneContact()
        default:
            return
        }
    }
    
    func getContacts() {
        let store = CNContactStore()
        do {
            let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey] as [CNKeyDescriptor]
            let fetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch)
            var count = 0
            try store.enumerateContacts(with: fetchRequest) { (contact, _) in
                count += 1
                for number in contact.phoneNumbers {
                    //do something with the phone numbers
                }
                for email in contact.emailAddresses {
                    //do something with the phone emails
                }
            }
            
            self.bridgeView.evaluate(JS: "contactCount(\(count))")
        } catch {
            print("Failed to fetch contact, error: \(error)")
        }
    }
    
    func getOneContact() {
        
//        let store = CNContactStore()
//        store.requestAccess(for: .contacts) { (granted, error) in
//            if let error = error {
//                print("failed to request access", error)
//                return
//            }
//            if granted {
//
//                do {
//                    let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey] as [CNKeyDescriptor]
//                    let fetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch)
//                    var count = 0
//                    try store.enumerateContacts(with: fetchRequest) { (contact, _) in
//                        count += 1
//                        for number in contact.phoneNumbers {
//                            //do something with the phone numbers
//                        }
//                        for email in contact.emailAddresses {
//                            //do something with the phone emails
//                        }
//                    }
//                    DispatchQueue.main.async {
//                        self.bridgeView.evaluate(JS: "contactCount(\(count))")
//                    }
//
//                } catch {
//                    print("Failed to fetch contact, error: \(error)")
//                }
//
//            } else {
//                print("Permission denied")
//            }
//        }
        
        let contactPicker = CNContactPickerViewController()
        bridgeView.viewController.present(contactPicker, animated: true, completion: nil)
    }
    
    
    
    
}
