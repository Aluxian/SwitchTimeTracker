//
//  Log.swift
//  Switch
//
//  Created by Alexandru Rosianu on 26/02/2017.
//  Copyright © 2017 Aluxian. All rights reserved.
//

import Cocoa

class Log {
    var activityId: Int
    var startedAt: Date
    
    init(activityId: Int, startedAt: Date) {
        self.activityId = activityId
        self.startedAt = startedAt
    }
}
