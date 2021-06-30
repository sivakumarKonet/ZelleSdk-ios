//
//  PhotosHandler.swift
//  BridgeSDK
//
//  Created by omar.ata on 5/26/21.
//

import Foundation
import WebKit

class PhotosHandler: NSObject, WKScriptMessageHandler {
    var bridgeView: BridgeView
    init(bridgeView: BridgeView) {
        self.bridgeView = bridgeView
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case "takePhoto": takePhoto()
        case "selectFromPhotos": selectFromPhotos()
        default:
            return
        }
    }

    func takePhoto() {
        
        self.bridgeView.evaluate(JS: "callbackPhoto({photo: '\("Photo feature is in progress, Available Soon")'})")
        
    }
    func selectFromPhotos() {
        
        self.bridgeView.evaluate(JS: "callbackPhoto({photo: '\("Photo feature is in progress, Available Soon")'})")
    }
}
