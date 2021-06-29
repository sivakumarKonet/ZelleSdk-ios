//
//  LocationHandler.swift
//  BridgeSDK
//
//  Created by omar.ata on 5/26/21.
//

import Foundation
import WebKit

class LocationHandler: NSObject, WKScriptMessageHandler {
    var bridgeView: BridgeView
    init(bridgeView: BridgeView) {
        self.bridgeView = bridgeView
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case "getLocation": getLocation()
        default:
            return
        }
    }

    func getLocation() {
        

        self.bridgeView.evaluate(JS: "callbackLocation(location:\(""))")
        
    }
}
