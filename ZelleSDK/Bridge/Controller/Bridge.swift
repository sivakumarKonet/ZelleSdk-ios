//
//  Bridge.swift
//  BridgeSDK
//
//  Created by omar.ata on 5/26/21.
//

import UIKit

protocol BridgeDelegate {
    var config: BridgeConfig { get set }
    var viewController: UIViewController { get set }
}

public class Bridge: BridgeDelegate {
    var config: BridgeConfig
    var viewController: UIViewController
    
    public init(config: BridgeConfig, viewController: UIViewController) {
        self.config = config
        self.viewController = viewController
    }
    
    public func view(frame: CGRect) -> BridgeView {
        return BridgeView(frame: frame, config: config, viewController: viewController)
    }
    
    public func popup(anchor: UIView) -> BridgePopup {
        return BridgePopup(anchor: anchor, config: config, viewController: viewController)
    }
}
