//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import UIKit
import MobileCoreServices

/// DocumentPickerService class for opening UIDocumentPickerViewController to get image from gallery.
class DocumentPickerService: NSObject {
    
    //MARK: - IBOutlet Declaration
    
    /// UIDocumentPickerViewController setup
    private lazy var picker: UIDocumentPickerViewController = {
        let picker = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF), String(kUTTypeJPEG), String(kUTTypePNG), String(kUTTypeRTF), String(kUTTypeText), String(kUTTypeVideo), String(kUTTypeMovie)], in: .import)
        picker.delegate = self
        picker.modalPresentationStyle = .overFullScreen
        return picker
    }()
    
    /// completionBlock clousure
    var completionBlock: CompletionObject<UIImage?, URL?>?
}

//MARK: - UI Functions
extension DocumentPickerService {
    
    /// Pick image from UIDocumentPickerViewController gallery.
    /// - Parameters:
    ///   - viewController: presents UIDocumentPickerViewController
    ///   - completion: completionBlock
    func pickDocument(from viewController: UIViewController, completion: CompletionObject<UIImage?, URL?>?) {
        completionBlock = completion
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popoverController = picker.popoverPresentationController {
                popoverController.sourceView = viewController.view
                popoverController.sourceRect = CGRect(x: viewController.view.center.x, y: viewController.view.frame.size.height / 2, width: 0, height: 0)
            }
        }
        viewController.present(picker, animated: true, completion: nil)
    }
}

//MARK: - UIImagePickerController Delegate
extension DocumentPickerService: UIDocumentPickerDelegate {
    
    /// To attach document (like pdf , txt , etc...)
    ///
    /// - Parameters:
    ///   - controller: passing UIDocumentPickerViewController
    ///   - url: pick doucment path.
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        self.completionBlock?(nil, url)
    }
    
    /// Document picker cancel
    ///
    /// - Parameter controller: passing document picker controller
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
