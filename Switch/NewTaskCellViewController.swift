//
//  NewTaskCellViewController.swift
//  Switch
//
//  Created by Alexandru Rosianu on 26/02/2017.
//  Copyright © 2017 Aluxian. All rights reserved.
//

import Cocoa


class NewTaskCellViewController: NSViewController {
    
    var addTaskCallback: ((String) -> Void)?
    var cellView: NewTaskCellView?
    
    override func viewDidLoad() {
        cellView = self.view as? NewTaskCellView
        cellView!.addTaskCallback = addTaskCallback
//        cellView!.addTaskBtn.action = #selector(onAddTaskClick(sender:))
    }
    
    override func viewWillDisappear() {
        addTaskCallback = nil
    }
    
    func onAddTaskClick(sender: Any) {
        cellView = self.view as? NewTaskCellView
        print("onAddTaskClick")
        addTaskCallback?(cellView?.taskTextField.stringValue ?? "")
        cellView?.taskTextField.stringValue = ""
    }
    
}
