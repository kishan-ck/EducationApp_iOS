//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit

class FacultiesTableDataSources: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Variable Declaration
    
    /// facultiesArray stores array of faculties list data.
    var facultiesArray : [json]? {
        didSet{
            self.TableView?.reloadData()
            
            if facultiesArray?.count == 0 {
                TableView?.isScrollEnabled = false
                KAPPDELEGATE.noDataFoundView(subView: self.TableView!)
            } else {
                TableView?.isScrollEnabled = true
                KAPPDELEGATE.removeNoDataFoundView(subView: self.TableView!)
            }
        }
    }
    
    /// Asks the data source to return the number of sections in the table view.
    /// - Parameter tableView: UITableView
    /// - Returns: returns numer of sections in Int
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    /// Tells the data source to return the number of rows in a given section of a table view.
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - section: An index number identifying a section in tableView.
    /// - Returns: returns total numer of rows in Int
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.facultiesArray?.count ?? 0
    }
    
    /// Asks the data source for a cell to insert in a particular location of the table view.
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: An index path locating a row in tableView.
    /// - Returns: returns UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "FacultiesTableViewCell", for: indexPath) as! FacultiesTableViewCell
        
        let facultiesObject = self.facultiesArray?[indexPath.row]
        
        tableViewCell.facultieImageView?.getImage(url: facultiesObject?.string(key: "profileImage") ?? "", placeHolderImage: enumForPlaceHolderImage.commonCoursesBackgroundImage.rawValue)
        tableViewCell.facultieNameLabel?.text = (facultiesObject?.string(key: "name") ?? "")
        
        if let degreeArray = facultiesObject?.array(key: "degree") {
            tableViewCell.facultieDegreeLabelView?.isHidden = false
            tableViewCell.facultieDegreeLabel?.text = degreeArray.map{$0.stringValue}.joined(separator: ", ")
        }
        
        if facultiesObject?.string(key: "email") != "" {
            tableViewCell.facultieEmailLabelView?.isHidden = false
            tableViewCell.facultieEmailLabel?.text = (facultiesObject?.string(key: "email") ?? "")
        }
        
        if facultiesObject?.string(key: "experience") != "" {
            tableViewCell.facultieExperienceLabelView?.isHidden = false
            tableViewCell.facultieExperienceLabel?.text = "EXPERIENCE".localized.uppercased() + ": " + (facultiesObject?.string(key: "experience") ?? "")
        }
        return tableViewCell
    }
    
    /// Tells the delegate a row is selected.
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: An index path locating a row in tableView.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (facultiesArray?.count ?? 0) > 0 {
            let facultiesObject = self.facultiesArray?[indexPath.row]
            let viewController = FacultieDetailsViewController(nibName: "FacultieDetailsViewController", bundle: nil)
            viewController.facultiesObj = facultiesObject
            viewController.hidesBottomBarWhenPushed = true
            tableView.parentViewController?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
