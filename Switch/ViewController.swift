//
//  ViewController.swift
//  Switch
//
//  Created by Alexandru Rosianu on 24/02/2017.
//  Copyright © 2017 Aluxian. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var taskInput: NSTextField!
    @IBOutlet weak var timeLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func submitBtn(_ sender: NSButton) {
        print("task:", taskInput.stringValue)
    }
    
}
