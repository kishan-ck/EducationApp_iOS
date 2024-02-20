//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit

class CoursesCollectionDataSource: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - Variable Declaration
    
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
        return 8
    }
    
    /// Asks the DataSource for a cell to insert in a particular location of the collection view.
    /// - Parameters:
    ///   - collectionView: UICollectionView
    ///   - indexPath: An index path locating a row in collectionView.
    /// - Returns: returns UICollectionViewCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        guard let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoursesCollectionViewCell", for: indexPath) as? CoursesCollectionViewCell  else { fatalError("Bad cell type.") }
        
        collectionViewCell.titleImageView?.image = UIImage(named: "ic_forgot_password")
        collectionViewCell.courseNameLabel?.text = "B.E"
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
    }
}
