//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import QuickLook

class ChapterListTableDataSources: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Variable Declaration
    var localURL: URL?
    
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
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "CoursesTableViewCell", for: indexPath) as! CoursesTableViewCell
    
        return tableViewCell
    }
    
    /// Tells the delegate a row is selected.
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: An index path locating a row in tableView.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let previewController = QLPreviewController()
        previewController.dataSource = self
        self.localURL = nil
        let pdfURL = URL(string: "")
        
        if (pdfURL?.lastPathComponent ?? "").contains(".pdf") {
        }
        tableView.parentViewController?.present(previewController, animated: true, completion: nil)
    }
}

extension ChapterListTableDataSources: QLPreviewControllerDataSource {
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return localURL != nil ? 1 : 0
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return localURL! as QLPreviewItem
    }
}
