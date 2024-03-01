//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit
import QuickLook

class ChapterListTableDataSources: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Variable Declaration
    var bookURL: URL?
    
    /// chapterListArray stores array of chapter list data.
    var chapterListArray: [json]? {
        didSet{
            self.TableView?.reloadData()
            
            if chapterListArray?.count == 0 {
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
        return chapterListArray?.count ?? 0
    }
    
    /// Asks the data source for a cell to insert in a particular location of the table view.
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: An index path locating a row in tableView.
    /// - Returns: returns UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "CoursesTableViewCell", for: indexPath) as! CoursesTableViewCell
        
        let chapterObject = chapterListArray?[indexPath.row]
        tableViewCell.titleImageView?.getImage(url: chapterObject?.string(key: "image_url") ?? "", placeHolderImage: enumForPlaceHolderImage.defaultImage.rawValue)
        tableViewCell.titleLabel?.text = chapterObject?.string(key: "chapterName")
    
        return tableViewCell
    }
    
    /// Tells the delegate a row is selected.
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: An index path locating a row in tableView.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chapterObject = chapterListArray?[indexPath.row]
        bookURL = nil
        
        let previewController = QLPreviewController()
        previewController.dataSource = self
        bookURL = URL(string: chapterObject?.string(key: "book_url") ?? "")
        
        tableView.parentViewController?.present(previewController, animated: true, completion: nil)
    }
}

extension ChapterListTableDataSources: QLPreviewControllerDataSource {
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return bookURL != nil ? 1 : 0
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return bookURL! as QLPreviewItem
    }
}
