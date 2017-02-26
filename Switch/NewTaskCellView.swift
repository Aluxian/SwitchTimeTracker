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
    
    @IBAction func onAddClick(_ sender: Any) {
        Swift.print("on IBACTION")
        addTaskCallback!(taskTextField.stringValue)
        taskTextField.stringValue = ""
    }
    
    var addTaskCallback: ((String) -> Void)?
    
}
