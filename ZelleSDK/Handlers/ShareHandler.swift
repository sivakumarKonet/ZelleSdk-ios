//
//  ShareHandler.swift
//  BridgeSDK
//
//  Created by omar.ata on 5/26/21.
//

import Foundation
import WebKit

class ShareHandler: NSObject, WKScriptMessageHandler {
    var bridgeView: BridgeView
    init(bridgeView: BridgeView) {
        self.bridgeView = bridgeView
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case "sharePhoto": sharePhoto()
        case "shareText": shareText()
        default:
            return
        }
    }

    func sharePhoto() {}
    func shareText() {}
}
