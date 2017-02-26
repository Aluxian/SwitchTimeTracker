//
//  TaskCellViewController.swift
//  Switch
//
//  Created by Alexandru Rosianu on 26/02/2017.
//  Copyright © 2017 Aluxian. All rights reserved.
//

import Cocoa

class TaskCellViewController: NSViewController {
    
    @IBOutlet weak var taskNameField: NSTextField!
    @IBOutlet weak var taskDurationField: NSTextField!
    
    private var log: Log?
    private var timer: Timer?
    
    override func viewDidLoad() {
        taskDurationField.alphaValue = 0
    }
    
    override func viewWillDisappear() {
        disable()
    }
    
    func enable(log: Log) {
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
        log = nil
        taskNameField.font = NSFont.systemFont(ofSize: taskNameField.font?.pointSize ?? 0)
        NSAnimationContext.runAnimationGroup({ (context) -> Void in
            taskDurationField.animator().alphaValue = 0
        }, completionHandler: {})
    }
    
    func onTick() {
        if log != nil {
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .abbreviated
            formatter.zeroFormattingBehavior = .dropLeading
            let duration = -log!.startedAt.timeIntervalSinceNow
            taskDurationField.stringValue = formatter.string(from: duration) ?? "--:--"
        }
    }
    
}
