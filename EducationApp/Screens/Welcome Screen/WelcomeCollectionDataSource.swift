//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit

class WelcomeCollectionDataSource: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - Variable Declaration
    
    var welcomeArray : [JSONStringDictionary] = [
        ["title":"ONLINE_LEARNING", "description":"ONLINE_LEARNING_DESC", "image":"ic_into_1", "id":"1"],
        ["title":"EASY_LEARNING", "description":"EASY_LEARNING_DESC", "image":"ic_into_2", "id":"2"],
        ["title":"GET_ONLINE_QUESTION_PAPER", "description":"GET_QUESTION_PAPER_DESC", "image":"ic_into_3", "id":"3"]
    ]

    var welcomeViewDelegate: WelcomeViewDelegate?
    
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
        return welcomeArray.count
    }
    
    /// Asks the DataSource for a cell to insert in a particular location of the collection view.
    /// - Parameters:
    ///   - collectionView: UICollectionView
    ///   - indexPath: An index path locating a row in collectionView.
    /// - Returns: returns UICollectionViewCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        guard let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WelcomeCollectionViewCell", for: indexPath) as? WelcomeCollectionViewCell  else { fatalError("Bad cell type.") }
        
        let welcomeObject = welcomeArray[indexPath.row]
        
        collectionViewCell.titleLabel?.text = welcomeObject.valueForKeyString("title").localized
        collectionViewCell.descriptionLabel?.text = welcomeObject.valueForKeyString("description").localized
        collectionViewCell.topImageView?.image = UIImage(named: welcomeObject.valueForKeyString("image"))
        
        if welcomeObject.valueForKeyString("id") == "3" {
            collectionViewCell.getStartedButton?.isHidden = false
        } else {
            collectionViewCell.getStartedButton?.isHidden = true
        }
        
        collectionViewCell.getStartedButton?.block_setAction(block: { sender in
            USER_DEFAULTS_STANDARD.set(1, forKey: WELCOME_COMPLETE)
            USER_DEFAULTS_STANDARD.synchronize()
            
            let viewController = LoginViewController.init(nibName: "LoginViewController", bundle: nil)
            self.CollectionView?.parentViewController?.navigationController?.pushViewController(viewController, animated: true)
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
        let convenientWidth = (collectionView.frame.size.width)
        let convenientHeight = (collectionView.frame.size.height)
        return CGSize(width: convenientWidth, height: convenientHeight)
    }
}

//MARK: - WelcomeCollectionDataSource Scroll View Setup
extension WelcomeCollectionDataSource {
    
    /// Tells the delegate that the scroll view ended decelerating the scrolling movement.
    /// - Parameter scrollView: The scroll-view object that’s decelerating the scrolling of the content view.
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        let currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        welcomeViewDelegate?.collectionViewIndexPath(pageIndex: currentPage)
    }
}
