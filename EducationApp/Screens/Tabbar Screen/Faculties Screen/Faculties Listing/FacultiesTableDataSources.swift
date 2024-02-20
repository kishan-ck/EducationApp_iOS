//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit

class FacultiesTableDataSources: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Variable Declaration
    
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
        return 5
    }
    
    /// Asks the data source for a cell to insert in a particular location of the table view.
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: An index path locating a row in tableView.
    /// - Returns: returns UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "FacultiesTableViewCell", for: indexPath) as! FacultiesTableViewCell
        
        tableViewCell.facultieImageView?.image = UIImage(named: "ic_courses_background")
        tableViewCell.facultieNameLabel?.text = "Dhruv Jariwala"
        tableViewCell.facultieDegreeLabel?.text = "B.E(CSE)"
        tableViewCell.facultieEmailLabel?.text = "dhruv.coderkube@gmail.com"
        tableViewCell.facultieExperienceLabel?.text = "EXPERIENCE".localized.uppercased() + ": " + "3"
    
        return tableViewCell
    }
    
    /// Tells the delegate a row is selected.
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: An index path locating a row in tableView.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = FacultieDetailsViewController(nibName: "FacultieDetailsViewController", bundle: nil)
        viewController.hidesBottomBarWhenPushed = true
        tableView.parentViewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
