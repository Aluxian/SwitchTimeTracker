//
//  NewTaskCellView.swift
//  Switch
//
//  Created by Alexandru Rosianu on 25/02/2017.
//  Copyright © 2017 Aluxian. All rights reserved.
//

import Cocoa

class TaskCellView: NSTableCellView {
    
    @IBOutlet weak var taskNameField: NSTextField!
    @IBOutlet weak var taskDurationField: NSTextField!
    @IBOutlet weak var taskColorBox: NSBox!
    
    var startedAt: NSDate?
    var timer: Timer?
    var selected: Bool = false {
        willSet(newSelected) {
            if newSelected != selected {
                // update new state
                if newSelected {
                    enable()
                } else {
                    disable()
                }
            }
        }
    }
    
    // used to calculate the delta for animations
    var selectionHintDelta: CGFloat = -10
    var deselectionHintDelta: CGFloat = 10
    
    func enable() {
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(onTick),
                                     userInfo: nil,
                                     repeats: true)
        onTick()
        taskNameField.font = NSFont.boldSystemFont(ofSize: taskNameField.font?.pointSize ?? 0)
        NSAnimationContext.runAnimationGroup({ (context) -> Void in
            taskDurationField.animator().alphaValue = 1
        }, completionHandler: {})
    }
    
    func disable() {
        timer?.invalidate()
        timer = nil
        startedAt = nil
        taskNameField.font = NSFont.systemFont(ofSize: taskNameField.font?.pointSize ?? 0)
        NSAnimationContext.runAnimationGroup({ (context) -> Void in
            taskDurationField.animator().alphaValue = 0
        }, completionHandler: {})
    }
    
    override func prepareForReuse() {
        disable()
        super.prepareForReuse()
    }
    
    func onTick() {
        if startedAt != nil {
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .abbreviated
            formatter.zeroFormattingBehavior = .dropLeading
            let duration = -startedAt!.timeIntervalSinceNow
            taskDurationField.stringValue = formatter.string(from: duration) ?? "--:--"
        }
    }
    
}
