//
//  Fiserv
//
//  Created by omar.ata on 4/9/21.
//

import UIKit
import WebKit
import Contacts
import ContactsUI

class ContactsHandler: NSObject, WKScriptMessageHandler, CNContactPickerDelegate {
    var bridgeView: BridgeView
    var viewController: UIViewController?
    init(bridgeView: BridgeView, viewController: UIViewController?) {
        self.bridgeView = bridgeView
        self.viewController = viewController
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
        
       /* let store = CNContactStore()
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
        } */
                
        self.bridgeView.evaluate(JS: "callbackContacts({contacts :' \("All contacts feature is in progress, Available Soon")'})")
        
    }
    
    func getOneContact() {
        
        let contactPicker = CNContactPickerViewController()
        
        contactPicker.delegate = self
        viewController?.present(contactPicker, animated: true, completion: nil)
        
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
    }
    
    // Delegate methods
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
                
        var firstName = contact.givenName
        var lastName = contact.familyName
        var name = firstName + " " + lastName
        var phoneNumber = contact.phoneNumbers.first?.value.stringValue ?? ""
        viewController?.dismiss(animated: true, completion: nil)
        self.bridgeView.evaluate(JS: "callbackOneContact({contact :' \(name + "," + phoneNumber)'})")
        print("Contact Selected")

    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        
        self.bridgeView.evaluate(JS: "callbackOneContact({contact :' \("User cancelled the request")'})")
    }
    
    
    
    
}
