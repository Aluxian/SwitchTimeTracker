//
//  ViewController.swift
//  Switch
//
//  Created by Alexandru Rosianu on 24/02/2017.
//  Copyright © 2017 Aluxian. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var tableView: NSTableView!
    
    var prevSelIndex = -1
    var currentSelIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // link the table view
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.frame = CGRect(x: 0, y: 0, width: 320, height: 30 + 8 * 51 - 1)
        tableView.frame = CGRect(x: 0, y: 0, width: 320, height: 8 * 51)
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
}

extension ViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 8
    }
    
}

extension ViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let boxView = tableView.make(withIdentifier: "TaskNameLabel", owner: nil) as? NSBox {
            (boxView.subviews[0].subviews[0] as! NSTextField).stringValue = "Studying"
            if tableView.selectedRow == row {
                (boxView.subviews[0].subviews[1] as! NSTextField).stringValue = "0:00"
//                setTimeout(delay: 1) {
//                    var delta: CGFloat = 30
//                    
//                    if self.currentSelIndex > self.prevSelIndex {
//                        delta = -30
//                    }
//                    
//                    (boxView.subviews[0].subviews[1] as! NSTextField).stringValue = "0:00"
//                    let tv = boxView.subviews[0].subviews[1]
//                    tv.frame = CGRect(x: tv.frame.origin.x, y: tv.frame.origin.y - delta,
//                                      width: tv.frame.width, height: tv.frame.height)
//                    tv.alphaValue = 0
//                    
//                    NSAnimationContext.runAnimationGroup({ (context) -> Void in
//                        context.duration = 1
//                        let tv = boxView.subviews[0].subviews[1].animator()
//                        tv.frame = CGRect(x: tv.frame.origin.x, y: tv.frame.origin.y + delta,
//                                          width: tv.frame.width, height: tv.frame.height)
//                        tv.alphaValue = 1
//                    }, completionHandler: {})
//                }
            } else {
                (boxView.subviews[0].subviews[1] as! NSTextField).stringValue = ""
//                var delta: CGFloat = 30
//                
//                if currentSelIndex > prevSelIndex {
//                    delta = -30
//                }
//                
//                NSAnimationContext.runAnimationGroup({ (context) -> Void in
//                    context.duration = 0.5
//                    let tv = boxView.subviews[0].subviews[1].animator()
//                    tv.frame = CGRect(x: tv.frame.origin.x, y: tv.frame.origin.y + delta,
//                                      width: tv.frame.width, height: tv.frame.height)
//                    tv.alphaValue = 0
//                }, completionHandler: {
//                    (boxView.subviews[0].subviews[1] as! NSTextField).stringValue = ""
//                    let tv = boxView.subviews[0].subviews[1]
//                    tv.frame = CGRect(x: tv.frame.origin.x, y: tv.frame.origin.y - delta,
//                                      width: tv.frame.width, height: tv.frame.height)
//                    tv.alphaValue = 1
//                })
            }
            return boxView
        }
        
        return nil
    }
    
    func setTimeout(delay:TimeInterval, block: @escaping ()->Void) {
        Timer.scheduledTimer(timeInterval: delay, target: BlockOperation(block: block), selector: #selector(Operation.main), userInfo: nil, repeats: false)
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        let tableView = notification.object as! NSTableView
        prevSelIndex = currentSelIndex
        currentSelIndex = tableView.selectedRow
        tableView.reloadData(forRowIndexes: IndexSet([currentSelIndex]),
                             columnIndexes: IndexSet([0]))
        if prevSelIndex != -1 {
            tableView.reloadData(forRowIndexes: IndexSet([prevSelIndex]),
                                 columnIndexes: IndexSet([0]))
        }
    }
    
}
