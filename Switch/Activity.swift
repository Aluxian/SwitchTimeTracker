//
//  Activity.swift
//  Switch
//
//  Created by Alexandru Rosianu on 26/02/2017.
//  Copyright © 2017 Aluxian. All rights reserved.
//

import Cocoa

class Activity {
    var name: String
    var deleted: Bool
    
    init(name: String) {
        self.name = name
        self.deleted = false
    }
}
