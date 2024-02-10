//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import UIKit

//MARK: - UITableView setup
extension UITableView{
    
    /// Set datasource and delegate with cell registration for UITableView.
    func setDataSourceDelegate (datasourceAndDelegate : NSObject , tableCell: String? = ""){
        datasourceAndDelegate.TableView = self
        if let datasource = datasourceAndDelegate as? UITableViewDataSource{
            self.dataSource = datasource
        }
        
        if let delegate = datasourceAndDelegate as? UITableViewDelegate{
            self.delegate = delegate
        }
        
        if tableCell != "" {
            self.register(UINib(nibName: tableCell!, bundle: nil), forCellReuseIdentifier: tableCell!)
        }
    }
    
    /// Gets datasource and delegate with cell registration for UITableView.
    func getDataSourceandDelegate() -> NSObject{
        return self.dataSource as! NSObject
    }
}

extension UITableView {
    
    /// To reload the data when data append
    /// - Parameter completion: return completion block
    public func reloadData(_ completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion:{ _ in
            completion()
        })
    }
    
    /// To scroll to top or bottom according criteria wise.
    /// - Parameters:
    ///   - to: passing scrollsTo enum.
    ///   - animated: passing boolean value
    func scroll(to: scrollsTo, animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            let numberOfSections = self.numberOfSections
            let numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
            switch to{
            case .top:
                if numberOfRows > 0 {
                     let indexPath = IndexPath(row: 0, section: 0)
                     self.scrollToRow(at: indexPath, at: .top, animated: animated)
                }
                break
            case .bottom:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                    self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
                }
                break
            }
        }
    }

    enum scrollsTo {
        case top, bottom
    }
}

/// To used for header activity indicator for table view
extension UITableView {
    
    /// To show indicator view into the table view
    ///
    /// - Returns: return ui activity indicator view
    func indicatorHeaderView() -> UIActivityIndicatorView {
        var activityIndicatorView = UIActivityIndicatorView()
        if(self.tableHeaderView == nil){
            let indicatorFrame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 50)
            activityIndicatorView = UIActivityIndicatorView(frame: indicatorFrame)
            activityIndicatorView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
            if #available(iOS 13.0, *) {
                activityIndicatorView.style = .medium
            } else {
                activityIndicatorView.style = .medium
            }
            activityIndicatorView.color = UIColor(named: "Light Text Color - #7C7F86")
            activityIndicatorView.hidesWhenStopped = true
            self.tableHeaderView = activityIndicatorView
            return activityIndicatorView
        }else{
            return activityIndicatorView
        }
    }
    
    /// To add loading indicator into tableview
    func addHeaderLoading(){
        self.indicatorHeaderView().startAnimating()
    }
    
    /// To stop loading indicator into tableview
    func stopHeaderLoading() {
        if(self.tableHeaderView != nil){
            self.indicatorHeaderView().stopAnimating()
            self.tableHeaderView = nil
        }else {
            self.tableHeaderView = nil
        }
    }
}

/// To used for footer activity indicator for table view
extension UITableView {
    
    /// To show indicator view into the table view
    ///
    /// - Returns: return ui activity indicator view
    func indicatorFooterView() -> UIActivityIndicatorView {
        var activityIndicatorView = UIActivityIndicatorView()
        if(self.tableFooterView == nil){
            let indicatorFrame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 50)
            activityIndicatorView = UIActivityIndicatorView(frame: indicatorFrame)
            activityIndicatorView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
            if #available(iOS 13.0, *) {
                activityIndicatorView.style = .medium
            } else {
                activityIndicatorView.style = .medium
            }
            activityIndicatorView.color = UIColor(named: "Light Text Color - #7C7F86")
            activityIndicatorView.hidesWhenStopped = true
            self.tableFooterView = activityIndicatorView
            return activityIndicatorView
        }else{
            return activityIndicatorView
        }
    }
    
    /// To add loading indicator into tableview
    func addFooterLoading(){
        self.indicatorFooterView().startAnimating()
    }
    
    /// To stop loading indicator into tableview
    func stopFooterLoading() {
        if(self.tableFooterView != nil){
            self.indicatorFooterView().stopAnimating()
            self.tableFooterView = nil
        }else {
            self.tableFooterView = nil
        }
    }
}

/*/// To used table view dynamic height
extension UITableView {
    
    /// Intrinsic content size of table view
    public override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return contentSize
    }
    
    /// Content size of table view
    public override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
}*/
