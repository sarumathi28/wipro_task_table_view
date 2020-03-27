//
//  ReachabilityManager.swift
//  TableViewTest
//
//  Created by Sdrops_mac on 26/03/20.
//  Copyright © 2020 Guest User. All rights reserved.
//

import Foundation
import UIKit
import ReachabilitySwift

class ReachabilityManager: NSObject {
   static  let shared = ReachabilityManager()  // 2. Shared instance
    // 3. Boolean to track network reachability
    var isNetworkAvailable : Bool {
      return reachabilityStatus != .notReachable
    }
    // 4. Tracks current NetworkStatus (notReachable, reachableViaWiFi, reachableViaWWAN)
    var reachabilityStatus: Reachability.NetworkStatus = .notReachable
    // 5. Reachability instance for Network status monitoring
    let reachability = Reachability()!
    
    
    @objc func reachabilityChanged(notification: Notification) {
       let reachability = notification.object as! Reachability
       switch reachability.currentReachabilityStatus {
       case .notReachable:
        debugPrint("Network became unreachable")
       case .reachableViaWiFi:
            debugPrint("Network reachable through WiFi")
       case .reachableViaWWAN:
            debugPrint("Network reachable through Cellular Data")
     }
    }
        
    func startMonitoring() {
       NotificationCenter.default.addObserver(self,
                 selector: #selector(self.reachabilityChanged),
                     name: ReachabilityChangedNotification,
                   object: reachability)
      do{
        try reachability.startNotifier()
      } catch {
        debugPrint("Could not start reachability notifier")
      }
    }
    
    func stopMonitoring(){
       reachability.stopNotifier()
       NotificationCenter.default.removeObserver(self,
                     name: ReachabilityChangedNotification,
                   object: reachability)
    }
}
