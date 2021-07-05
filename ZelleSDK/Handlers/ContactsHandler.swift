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
    var counter : Int = 0
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
        
//        requestAccess { (true) in
//
//            self.fetchAllContacts()
//        }
        
        self.bridgeView.evaluate(JS: "callbackContacts({contacts :' \("All contacts feature is in progress, Available Soon")'})")
                        
    }
    func requestAccess(completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            print("Permission Allowed 1")
            completionHandler(true)
        case .denied:
            
            print("Permission denied 1")
            print("Counter 1 \(self.counter)")
            if self.counter > 0 {
                showSettingsAlert(completionHandler)
            }
            counter += 1
           //
        case .restricted, .notDetermined:
            let store = CNContactStore()
            store.requestAccess(for: .contacts) { granted, error in
                if granted {
                    print("Permission Allowed 2")
                    completionHandler(true)
                } else {
                    DispatchQueue.main.async {
                        print("Counter 2 \(self.counter)")
                        print("Permission denied 2")
                        if self.counter > 0 {
                            self.showSettingsAlert(completionHandler)
                        }
                        self.counter += 1
                    }
                }
            }
        }
    }
    
//    private func fetchAllContacts() {
//        //1.
//        let store = CNContactStore()
//        // 2.
//        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
//        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
//        do {
//            // 3.
//            try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
//                Contact(firstName: contact.givenName, lastName: contact.familyName, phoneNumber: [contact.phoneNumbers.first?.value.stringValue ?? ""])
//            })
//
//        } catch let error {
//            print("Failed to enumerate contact", error)
//        }
//
////        DispatchQueue.main.async {
////
////            self.bridgeView.evaluate(JS: "callbackContacts({contacts :' \("All contacts feature is in progress, Available Soon")'})")
////        }
//    }
    
    private func showSettingsAlert(_ completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        let alert = UIAlertController(title: nil, message: "This app requires access to Contacts to proceed. Go to Settings to grant access.", preferredStyle: .alert)
        if
            let settings = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(settings) {
                alert.addAction(UIAlertAction(title: "Open Settings", style: .default) { action in
                    completionHandler(false)
                    UIApplication.shared.open(settings)
                })
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { action in
            completionHandler(false)
        })
        viewController?.present(alert, animated: true)
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
    
//    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
//        viewController?.dismiss(animated: true, completion: nil)
//    }
    
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {

        var firstName = contact.givenName
        var lastName = contact.familyName
        var name = firstName + " " + lastName
        
        let contactPhoneNumbers = contact.phoneNumbers.map {
            $0.value.stringValue }
        
        let contactEmailAddresses = contact.emailAddresses.map { $0.value as String }
        
        var contact = Contact(name: name, phoneNumber: contactPhoneNumbers, emailAddress: contactEmailAddresses)
        
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(contact)
        let json = String(data: jsonData, encoding: String.Encoding.utf8)
        
        print("My JSON Object \(json!)")
        
//        for num in contactPhoneNumbers {
//            print("My Contact \(num)")
//        }
//
//        for email in contactEmailAddress {
//            print("My Email \(email)")
//        }
//        contact.phoneNumbers.map {  phoneNumber.append($0.value.stringValue)
//        }
//
//        for mycontact in phoneNumber {
//
//            print("My Contact \(mycontact)")
//        }
        
        viewController?.dismiss(animated: true, completion: nil)
        self.bridgeView.evaluate(JS: "callbackOneContact({contact :' \(String(describing: json!))'})")
        print("Contact Selected")

    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        
        self.bridgeView.evaluate(JS: "callbackOneContact({contact :' \("User cancelled the request")'})")
    }
    
    
    
    
}
