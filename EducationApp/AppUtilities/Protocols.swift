//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import UIKit

/// To reload more list data into the list
protocol ReloadMoreListData {
    
    /// To used this method for reloading the data
    func reloadMoreListData(index: Int, expandable: Bool, actionForPost: enumForActionOnPost)
}

/// To reload api data from the selected filter wise
protocol FilterWiseListData {
    
    /// To used this method for reloading the data and call the api
    func filterWiseListData(filter: String)
}

/// To reload api data from the posts
protocol ReloadPostsData {
    
    /// To used this method for reloading the data and call the api
    func reloadPostsListData(object: json?, forPost: enumForPost)
}

/// To used this method for the move to selected controller
protocol MoveToSelectedController {
    
    /// To used this method for move to controller the data
    func moveToController(postObj: json, actionForPost: enumForActionOnPost)
}

/// To used this method for the move to comment controller
protocol MoveToCommentViewController {
    
    /// To used this method for move to controller the data
    func moveToController(parentId: Int, forPost: enumForPost)
}

/// To reload api data from the welcome checklist
protocol ReloadWelcomeCheckListData {
    
    /// To used this method for reloading the data and call the api
    func reloadWelcomeCheckListData()
}

/// To used this for update webview cell height
public protocol WebViewCellDelegate: NSObjectProtocol {
    
    /// To update the heights
    func heightChangeObserve(in cell: UITableViewCell, contentHeight: CGFloat)
}

/// To manage quiz list data into the list
protocol ManageQuizListData {
    
    /// To used this method for manage the data
    func manageQuizListData(index: Int, jsonArray: [json]?)
    
    /// To used for submit quiz data to server
    func submitQuizListData()
}

/// To reload api data from the selected filter wise
protocol SessionDurationWiseListData {
    
    /// To store session duration wise list data
    func sessionDurationWiseListData(durationObject: json)
}

/// To reload api data from the selected filter wise
protocol BookSessionData {
    
    /// To store session duration wise list data
    func bookSessionData(bookSession: enumForBookSession)
}

/// To reload api data from the selected filter wise
protocol RedirectSessionListScreen {
    
    /// To redirect session list screen
    func redirectSessionListScreen(sessionMessage: String, calendlyLinkURL: String, object: json?)
}
