//
//  Fiserv
//
//  Created by omar.ata on 4/9/21.
//

import UIKit
import WebKit
import QRCodeReader

class QRCodeHandler: NSObject, WKScriptMessageHandler, QRCodeReaderViewControllerDelegate {

    var bridgeView: BridgeView
    var viewController: UIViewController?
    init(bridgeView: BridgeView, viewController: UIViewController?) {
        self.bridgeView = bridgeView
        self.viewController = viewController
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case "scanQRCode": scanCode()
        case "selectQRCodeFromPhotos": selectQRCodeFromPhotos()
        default:
            return
        }
    }
    
    func scanCode() {
        
        self.bridgeView.evaluate(JS: "callbackQRCode({qrCode: 'scanning ...'})")

        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            $0.showTorchButton        = true
            $0.showSwitchCameraButton = true
            $0.showCancelButton       = true
            $0.showOverlayView        = true
            $0.rectOfInterest         = CGRect(x: 0.2, y: 0.3, width: 0.6, height: 0.4)
        }
        
        let reader = QRCodeReaderViewController(builder: builder)
        reader.delegate = self
        viewController?.present(reader, animated: true, completion: nil)
    }
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        self.bridgeView.evaluate(JS: "callbackQRCode({qrCode: '\(result.value)'})")
        reader.stopScanning()
        reader.dismiss(animated: true, completion: nil)
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        self.bridgeView.evaluate(JS: "callbackQRCode({qrCode: 'no code!', error: 'canceled'})")
        reader.stopScanning()
        reader.dismiss(animated: true, completion: nil)
    }
    
    
    func selectQRCodeFromPhotos() {}
}
