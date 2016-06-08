

import UIKit
import MobileCoreServices

class OtherViewController: UIViewController {
    
    let desiredType = kUTTypePlainText as String
    
    var s : String?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let items = self.extensionContext!.inputItems
        // open the envelopes
        guard let extensionItem = items[0] as? NSExtensionItem,
            let provider = extensionItem.attachments?[0] as? NSItemProvider
            where provider.hasItemConformingToTypeIdentifier(self.desiredType)
            else {
                return
        }
        provider.loadItem(forTypeIdentifier: self.desiredType) {
            (item:NSSecureCoding?, err:NSError!) -> () in
            dispatch_async(dispatch_get_main_queue()) {
                self.s = item as? String
            }
        }
    }
    
    @IBAction func doButton(_ sender: AnyObject) {
        self.extensionContext!.completeRequest(returningItems:[])
    }

}
