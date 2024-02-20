//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit

class SubjectCollectionViewDataSource: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
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
        return 5
    }
    
    /// Asks the DataSource for a cell to insert in a particular location of the collection view.
    /// - Parameters:
    ///   - collectionView: UICollectionView
    ///   - indexPath: An index path locating a row in collectionView.
    /// - Returns: returns UICollectionViewCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        guard let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SemesterCollectionViewCell", for: indexPath) as? SemesterCollectionViewCell  else { fatalError("Bad cell type.") }
        
        
        
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
        let convenientHeight = heightPer(per: 18.99)
        return CGSize(width: convenientWidth, height: convenientHeight)
    }
    
    ///  Tells the delegate an item is selected.
    /// - Parameters:
    ///   - collectionView: UICollectionView
    ///   - indexPath: An index path locating a row in collectionView.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = ChapterListViewController(nibName: "ChapterListViewController", bundle: nil)
        collectionView.parentViewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
