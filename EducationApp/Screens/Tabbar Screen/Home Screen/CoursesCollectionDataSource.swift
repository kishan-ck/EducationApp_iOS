//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import QuickLook

class CoursesCollectionDataSource: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - Variable Declaration
    var bookURL: URL?
    
    /// coursesArray stores array of course list data.
    var coursesArray : [json]? {
        didSet{
            self.CollectionView?.reloadData()
        }
    }
    
    /// Asks the DataSource to return the number of sections in the collection view.
    /// - Parameter tableView: UICollectionView
    /// - Returns: returns numer of sections in Int
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    
    /// Tells the DataSource to return the number of items in a given section of a collection view.
    /// - Parameters:
    ///   - tableView: UICollectionView
    ///   - section: An index number identifying a number of items in a section in collectionView.
    /// - Returns: returns total numer of items in Int
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.coursesArray?.count ?? 0
    }
    
    /// Asks the DataSource for a cell to insert in a particular location of the collection view.
    /// - Parameters:
    ///   - collectionView: UICollectionView
    ///   - indexPath: An index path locating a row in collectionView.
    /// - Returns: returns UICollectionViewCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        guard let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoursesCollectionViewCell", for: indexPath) as? CoursesCollectionViewCell  else { fatalError("Bad cell type.") }
        
        let courseObject = self.coursesArray?[indexPath.row]
        
        collectionViewCell.titleImageView?.getImage(url: courseObject?.string(key: "courseImage") ?? "", placeHolderImage: enumForPlaceHolderImage.defaultImage.rawValue)
        collectionViewCell.courseNameLabel?.text = courseObject?.string(key: "courseName").trim()
        
        collectionViewCell.isLikeImageBackView?.isHidden = true
        collectionViewCell.subjectNameLabelView?.isHidden = true
        collectionViewCell.semesterLabelView?.isHidden = true
        
        collectionViewCell.subjectNameLabel?.text = "Advanced mathematics 3"
        collectionViewCell.semesterLabel?.text = "CSE Sem 5"
        
        collectionViewCell.isLikeButton?.block_setAction(block: { sender in
            if sender.isSelected == false {
                collectionViewCell.isLikeImageView?.image = UIImage(named: "ic_filled_like")
                sender.isSelected = true
        
            } else {
                collectionViewCell.isLikeImageView?.image = UIImage(named: "ic_empty_like")
                sender.isSelected = false
            }
        })
        
        return collectionViewCell
    }
    
    /// Asks the delegate for the size of the specified item’s cell.
    /// - Parameters:
    ///   - collectionView: UICollectionView
    ///   - collectionViewLayout: An abstract base class for generating layout information for a collection view.
    ///   - indexPath: An index path locating an item in collectionView.
    /// - Returns: The width and height of the specified item. Both values must be greater than 0.
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let convenientWidth = widthPer(per: 81)
        let convenientHeight = (collectionView.frame.size.height)
        return CGSize(width: convenientWidth, height: convenientHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top : 0, left : widthPer(per: 2.32), bottom : 0, right : widthPer(per: 2.32))
    }
    
    ///  Tells the delegate an item is selected.
    /// - Parameters:
    ///   - collectionView: UICollectionView
    ///   - indexPath: An index path locating a row in collectionView.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (coursesArray?.count ?? 0) > 0 {
            let courseObject = self.coursesArray?[indexPath.row]
            bookURL = nil
            
            let previewController = QLPreviewController()
            previewController.dataSource = self
            bookURL = URL(string: courseObject?.string(key: "courseBook") ?? "")
            collectionView.parentViewController?.present(previewController, animated: true, completion: nil)
        }
    }
}

extension CoursesCollectionDataSource: QLPreviewControllerDataSource {
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return bookURL != nil ? 1 : 0
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return bookURL! as QLPreviewItem
    }
}
