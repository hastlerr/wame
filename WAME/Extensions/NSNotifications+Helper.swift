//
//  NSNotifications+Helper.swift
//  WAME
//
//  Created by Avaz Abdrasulov on 2/16/20.
//  Copyright © 2020 HASL LLC. All rights reserved.
//

import Foundation

enum Notifications {
    
    static let sceneDidBecomeActive = Notification.Name("sceneDidBecomeActive")
    
}

extension NSNotification.Name {
    
    /// Registers `NotificationCenter` observer for this `Notification.Name`.
    func addObserver(_ observer: Any, selector: Selector, object: Any? = nil) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: self, object: object)
    }
    
    /// Posts this `Notification.Name` with optional `object` and `userInfo` dictionary.
    func post(with object: Any? = nil, userInfo: [AnyHashable: Any]? = nil, async: Bool = false) {
        
        func postNotification() {
            NotificationCenter.default.post(name: self, object: object, userInfo: userInfo)
        }
        
        if async {
            DispatchQueue.main.async(execute: postNotification)
        } else {
            postNotification()
        }
    }
    
}
