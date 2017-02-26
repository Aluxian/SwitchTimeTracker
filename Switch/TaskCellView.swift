//
//  TaskCellView.swift
//  Switch
//
//  Created by Alexandru Rosianu on 25/02/2017.
//  Copyright © 2017 Aluxian. All rights reserved.
//

import Cocoa

class TaskCellView: NSTableCellView {
    
    @IBOutlet weak var taskNameField: NSTextField!
    @IBOutlet weak var taskDurationField: NSTextField!
    
    func show(name: String) {
        taskNameField.stringValue = name
        taskNameField.font = NSFont.boldSystemFont(ofSize: taskNameField.font?.pointSize ?? 0)
        if taskDurationField.alphaValue == 1 {
            return
        }
        NSAnimationContext.runAnimationGroup({ (context) -> Void in
            taskDurationField.animator().alphaValue = 1
        }, completionHandler: {})
    }
    
    func hide(name: String) {
        taskNameField.stringValue = name
        taskNameField.font = NSFont.systemFont(ofSize: taskNameField.font?.pointSize ?? 0)
        if taskDurationField.alphaValue == 0 {
            return
        }
        NSAnimationContext.runAnimationGroup({ (context) -> Void in
            taskDurationField.animator().alphaValue = 0
        }, completionHandler: {})
    }
    
    func updateDuration(startedAt: Date) {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropLeading
        
        let duration = -startedAt.timeIntervalSinceNow
        taskDurationField.stringValue = formatter.string(from: duration) ?? "--:--"
    }
    
}
