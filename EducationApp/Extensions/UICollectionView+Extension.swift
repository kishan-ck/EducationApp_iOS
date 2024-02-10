//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit

//MARK: - UICollectionView setup
extension UICollectionView {
    
    /// Set datasource and delegate with cell registration for UICollectionView.
    func setDataSourceDelegate (datasourceAndDelegate : NSObject , collectionCell: String? = ""){
        datasourceAndDelegate.CollectionView = self
        if let datasource = datasourceAndDelegate as? UICollectionViewDataSource{
            self.dataSource = datasource
        }
        
        if let delegate = datasourceAndDelegate as? UICollectionViewDelegate{
            self.delegate = delegate
        }
        
        if collectionCell != "" {
            self.register(UINib(nibName: collectionCell!, bundle: nil), forCellWithReuseIdentifier: collectionCell!)
        }
    }
    
    /// Gets datasource and delegate with cell registration for UICollectionView.
    func getDataSourceandDelegate() -> NSObject{
        return self.dataSource as! NSObject
    }
}
