//
//  NewTaskCellViewController.swift
//  Switch
//
//  Created by Alexandru Rosianu on 26/02/2017.
//  Copyright © 2017 Aluxian. All rights reserved.
//

import Cocoa


class NewTaskCellViewController: NSViewController {
    
    @IBOutlet weak var taskTextField: NSTextField!
    @IBOutlet weak var addTaskBtn: NSButton!
    
    var addTaskCallback: ((String) -> Void)?
    
    @IBAction func addTaskBtnClicked(_ sender: Any) {
        addTaskCallback?(taskTextField.stringValue)
        taskTextField.stringValue = ""
    }
    
    override func viewWillDisappear() {
        addTaskCallback = nil
    }
    
}
