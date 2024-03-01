//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit

class FacultiesCollectionDataSource: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - Variable Declaration
    
    /// facultiesArray stores array of faculties list data.
    var facultiesArray : [json]? {
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
        return self.facultiesArray?.count ?? 0
    }
    
    /// Asks the DataSource for a cell to insert in a particular location of the collection view.
    /// - Parameters:
    ///   - collectionView: UICollectionView
    ///   - indexPath: An index path locating a row in collectionView.
    /// - Returns: returns UICollectionViewCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        guard let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacultiesCollectionViewCell", for: indexPath) as? FacultiesCollectionViewCell  else { fatalError("Bad cell type.") }

        let facultiesObject = self.facultiesArray?[indexPath.row]
        collectionViewCell.facultieImageView?.getImage(url: facultiesObject?.string(key: "profile_Image") ?? "", placeHolderImage: enumForPlaceHolderImage.defaultImage.rawValue)
        collectionViewCell.facultieNameLabel?.text = (facultiesObject?.string(key: "name") ?? "")
        collectionViewCell.facultieFieldLabel?.text = (facultiesObject?.string(key: "lecture") ?? "")
        
        return collectionViewCell
    }
    
    /// Asks the delegate for the size of the specified item’s cell.
    /// - Parameters:
    ///   - collectionView: UICollectionView
    ///   - collectionViewLayout: An abstract base class for generating layout information for a collection view.
    ///   - indexPath: An index path locating an item in collectionView.
    /// - Returns: The width and height of the specified item. Both values must be greater than 0.
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let convenientWidth = (collectionView.frame.size.width) / 2
        let convenientHeight = (collectionView.frame.size.height)
        return CGSize(width: convenientWidth, height: convenientHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top : 0, left : widthPer(per: 2.32), bottom : 0, right : 0)
    }
    
    ///  Tells the delegate an item is selected.
    /// - Parameters:
    ///   - collectionView: UICollectionView
    ///   - indexPath: An index path locating a row in collectionView.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (facultiesArray?.count ?? 0) > 0 {
            let facultiesObject = self.facultiesArray?[indexPath.row]
            let viewController = FacultieDetailsViewController(nibName: "FacultieDetailsViewController", bundle: nil)
            viewController.facultiesObj = facultiesObject
            viewController.hidesBottomBarWhenPushed = true
            collectionView.parentViewController?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
