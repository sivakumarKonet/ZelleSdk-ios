//
//  PermissionsHandler.swift
//  BridgeSDK
//
//  Created by omar.ata on 5/26/21.
//

import Foundation
import WebKit

class PermissionsHandler: NSObject, WKScriptMessageHandler {
    var bridgeView: BridgeView
    init(bridgeView: BridgeView) {
        self.bridgeView = bridgeView
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case "checkPermissions": checkPermissions()
        default:
            return
        }
    }

    func checkPermissions() {
        
        self.bridgeView.evaluate(JS: "callbackPermissions({permission: '\("Check permissions feature is in progress, Available Soon")'})")
        
    }
}
