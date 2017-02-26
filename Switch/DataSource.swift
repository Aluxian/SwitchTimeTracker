//
//  DataSource.swift
//  Switch
//
//  Created by Alexandru Rosianu on 26/02/2017.
//  Copyright © 2017 Aluxian. All rights reserved.
//

import Cocoa

class DataSource: NSObject, NSTableViewDataSource {
    
    var activities = [
        Activity(name: "Nothing"),
        Activity(name: "Programming"),
        Activity(name: "Studying"),
        Activity(name: "Reading")
    ]
    
    var logs = [
        Log(activityId: 0, startedAt: Date())
    ]
    
    var numRowsOffset = 0
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return activities.count + numRowsOffset
    }
    
}
