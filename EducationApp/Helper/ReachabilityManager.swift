//
// Copyright (c) 2024 Education App All rights reserved.
//

import UIKit

/// To used for connection manager singlton class
class ReachabilityManager {
    
    /// To used shared instance static object
    static let sharedInstance = ReachabilityManager()
    
    /// To used reachability object
    private var reachability : Reachability!
    
    /// To used observe rechability method
    func observeReachability(){
        self.reachability = Reachability()
        NotificationCenter.default.addObserver(self, selector:#selector(self.reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
        do {
            try self.reachability.startNotifier()
        }
        catch(let error) {
            print("Error occured while starting reachability notifications : \(error.localizedDescription)")
        }
    }
    
    /// To used reachability changed events.
    ///
    /// - Parameter note: getting note notifications object.
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .cellular:
            print("Network available via cellular data.")
            //KAPPDELEGATE.dismissLostInternet()
            break
        case .wifi:
            print("Network available via wifi.")
            //KAPPDELEGATE.dismissLostInternet()
            break
        case .none:
            print("Network is not available.")
            //KAPPDELEGATE.lostInternet()
            break
        }
    }
}
