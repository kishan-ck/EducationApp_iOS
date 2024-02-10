//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import Photos

/// ImagePickerService class for opening UIImagePickerController to get image from gallery.
class ImagePickerService: NSObject {
    
    //MARK: - IBOutlet Declaration
    
    /// UIImagePickerController setup
    private lazy var picker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        return picker
    }()
    
    /// completionBlock clousure
    var completionBlock: CompletionObject<UIImage?, URL?>?
}

//MARK: - UI Functions
extension ImagePickerService {
    
    /// Pick image from UIImagePickerController gallery.
    /// - Parameters:
    ///   - viewController: presents UIImagePickerController
    ///   - allowEditing: picker.allowsEditing
    ///   - source: UIImagePickerController.SourceType?
    ///   - completion: completionBlock
    func pickImage(from viewController: UIViewController, allowEditing: Bool = false, source: UIImagePickerController.SourceType? = nil, pickerMediaTypes: [String] = ["public.image"], completion: CompletionObject<UIImage?, URL?>?) {
        completionBlock = completion
        picker.allowsEditing = allowEditing
        
        guard let source = source else {
            let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            sheet.view.tintColor = UIColor(named: "ThemeYellow - #E2A12D")
            
            let cameraAction = UIAlertAction(title: "CAMERA".localized, style: .default) {[weak self] _ in
                guard let weakSelf = self else { return }
                weakSelf.picker.sourceType = .camera
                weakSelf.picker.mediaTypes = pickerMediaTypes
                viewController.present(weakSelf.picker, animated: true, completion: nil)
            }
            
            let photoAction = UIAlertAction(title: "PHOTO_LIBRARY".localized, style: .default) {[weak self] _ in
                guard let weakSelf = self else { return }
                weakSelf.picker.sourceType = .photoLibrary
                weakSelf.picker.mediaTypes = pickerMediaTypes
                viewController.present(weakSelf.picker, animated: true, completion: nil)
            }
            
            let cancelAction = UIAlertAction(title: "CANCEL".localized, style: .cancel, handler: nil)
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                sheet.addAction(cameraAction)
            }
            
            sheet.addAction(photoAction)
            sheet.addAction(cancelAction)
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                if let popoverController = sheet.popoverPresentationController {
                    popoverController.sourceView = viewController.view
                    popoverController.sourceRect = CGRect(x: viewController.view.center.x, y: viewController.view.frame.size.height / 2, width: 0, height: 0)
                }
            }
            
            viewController.present(sheet, animated: true, completion: nil)
            return
        }
        picker.sourceType = source
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
extension ImagePickerService: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /// Called after media or image is selected from UIImagePickerController.
    /// - Parameters:
    ///   - picker: UIImagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String {
                if mediaType  == "public.image" {
                    print("Image Selected")
                    if let image = info[.editedImage] as? UIImage {
                        self.completionBlock?(image.fixOrientation(), nil)
                        return
                    }
                    
                    if let image = info[.originalImage] as? UIImage {
                        self.completionBlock?(image.fixOrientation(), nil)
                    }
                }

                if mediaType == "public.movie" {
                    print("Video Selected")
                    if let url = info[.mediaURL] as? URL {
                        self.completionBlock?(nil, url)
                    }
                }
            }
        }
    }
}
