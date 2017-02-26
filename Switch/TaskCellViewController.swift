//
//  TaskCellViewController.swift
//  Switch
//
//  Created by Alexandru Rosianu on 26/02/2017.
//  Copyright © 2017 Aluxian. All rights reserved.
//

import Cocoa

class TaskCellViewController: NSViewController {
    
    var log: Log?
    var timer: Timer?
    var activity: Activity?
    var cellView: TaskCellView?
    
    override func viewDidLoad() {
        cellView = self.view as? TaskCellView
        cellView?.taskDurationField.alphaValue = 0
    }
    
    override func viewWillDisappear() {
        disable()
    }
    
    func enable(log: Log, activity: Activity) {
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(onTick),
                                     userInfo: nil,
                                     repeats: true)
        onTick()
        cellView?.show(name: activity.name)
    }
    
    func disable() {
        timer?.invalidate()
        timer = nil
        
        activity = nil
        log = nil
        
        cellView?.hide()
    }
    
    func onTick() {
        if log != nil {
            cellView?.updateDuration(startedAt: log!.startedAt)
        }
    }
    
}
