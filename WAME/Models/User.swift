//
//  User.swift
//  WAME
//
//  Created by Avaz Abdrasulov on 2/13/20.
//  Copyright © 2020 HASL LLC. All rights reserved.
//

import RealmSwift

class User: Object {
    
    var openedChats = 0
    var activatedDate = Date()

    var showNumberPrefix = true
    var showPlaseholder = true
    var showFlag = true
        
}
