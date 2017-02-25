//
//  NewTaskCellView.swift
//  Switch
//
//  Created by Alexandru Rosianu on 25/02/2017.
//  Copyright © 2017 Aluxian. All rights reserved.
//

import Cocoa

class NewTaskCellView: NSTableCellView {
    
    @IBOutlet weak var taskTextField: NSTextField!
    @IBOutlet weak var addTaskBtn: NSButton!
    
    var addTaskAction: ((String) -> Void)?
    
    @IBAction func addTaskBtnClicked(_ sender: Any) {
        addTaskAction?(taskTextField.stringValue)
        taskTextField.stringValue = ""
    }
    
}
