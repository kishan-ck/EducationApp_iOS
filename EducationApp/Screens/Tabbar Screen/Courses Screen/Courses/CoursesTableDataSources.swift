//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit

class CoursesTableDataSources: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Variable Declaration
    
    /// coursesArray stores array of course list data.
    var coursesArray: [json]? {
        didSet{
            self.TableView?.reloadData()
            
            if coursesArray?.count == 0 {
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
        return self.coursesArray?.count ?? 0
    }
    
    /// Asks the data source for a cell to insert in a particular location of the table view.
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: An index path locating a row in tableView.
    /// - Returns: returns UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "CoursesTableViewCell", for: indexPath) as! CoursesTableViewCell
    
        let courseObject = self.coursesArray?[indexPath.row]
        
        let courseName = courseObject?.string(key: "coursename").trim()
        tableViewCell.titleImageView?.getImage(url: courseObject?.string(key: "image_url") ?? "")
        tableViewCell.titleLabel?.text = courseName
        
        if (courseName?.lowercased().contains("gujarati") ?? false) {
            tableViewCell.descriptionLabel?.text = "Internal Gujarati Medium"
        } else {
            tableViewCell.descriptionLabel?.text = "Internal English Medium"
        }
        
        return tableViewCell
    }
    
    /// Tells the delegate a row is selected.
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: An index path locating a row in tableView.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (coursesArray?.count ?? 0) > 0 {
            let courseObject = self.coursesArray?[indexPath.row]
            let viewController = SemesterListViewController(nibName: "SemesterListViewController", bundle: nil)
            viewController.courseObj = courseObject
            viewController.hidesBottomBarWhenPushed = true
            tableView.parentViewController?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
