//
//  ReachabilityService.swift
//  NewsTestApp
//
//  Created by MacBook Pro on 02.08.22.
//

import Foundation
import Reachability


class ReachabilityService: NSObject {
    
    
    static let sharedInstance = ReachabilityService()
    var reachability = try! Reachability()
    var bindNetworkStatusChanged : (() -> ()) = {}
    
    override init() {
        super.init()
        // Initialise reachability
        // Register an observer for the network status
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged(_:)),
            name: .reachabilityChanged,
            object: reachability
        )
        do {
            // Start the network status notifier
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        let reachability = notification.object as! Reachability
        bindNetworkStatusChanged()
        switch reachability.connection {
          case .wifi:
              print("Reachable via WiFi")
          case .cellular:
              print("Reachable via Cellular")
          case .unavailable:
            print("Network not reachable")
          case .none:
              break
          }
    }
    
    func isReachable(completed: @escaping () -> Void) {
        if reachability.connection != .unavailable {
            completed()
        }
    }
    
    func isUnreachable(completed: @escaping () -> Void) {
        if reachability.connection == .unavailable {
            completed()
        }
    }
}

