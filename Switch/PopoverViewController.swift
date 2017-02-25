//
//  ViewController.swift
//  Switch
//
//  Created by Alexandru Rosianu on 24/02/2017.
//  Copyright © 2017 Aluxian. All rights reserved.
//

import Cocoa

class Entry {
    var name: String
    var startedAt: NSDate
    var color: NSColor
    
    init(name: String, startedAt: NSDate, color: NSColor) {
        self.name = name
        self.startedAt = startedAt
        self.color = color
    }
}

class PopoverViewController: NSViewController {
    
    @IBOutlet weak var tasksTableView: NSTableView!
    @IBOutlet weak var headerAddTaskBtn: NSButton!
    
    let popoverTopOffset: CGFloat = 31
    let popoverItemHeight: CGFloat = 51
    
    var prevSelectedRow: Int = -1
    var isInAddTaskMode: Bool = false
    
    var entries = [
        Entry(name: "Nothing", startedAt: NSDate(), color: NSColor(red: 0.58, green: 0.72, blue: 0.75, alpha: 1)),
        Entry(name: "Programming", startedAt: NSDate(), color: NSColor(red: 0.58, green: 0.72, blue: 0.75, alpha: 1)),
        Entry(name: "Studying", startedAt: NSDate(), color: NSColor(red: 0.57, green: 0.77, blue: 0.64, alpha: 1)),
        Entry(name: "Reading", startedAt: NSDate(), color: NSColor(red: 0.54, green: 0.41, blue: 0.53, alpha: 1))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // link the table view
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        
        // resize the popover window
//        self.view.setFrameSize(NSSize(width: self.view.frame.width,
//                                      height: popoverTopOffset + CGFloat(entries.count) * popoverItemHeight))
        
        // bind header buttons
        headerAddTaskBtn.action = #selector(onHeaderAddTaskClick(sender:))
        
        // ensure the table view is focused first
        headerAddTaskBtn.refusesFirstResponder = true
        
        // register custom cell views
        tasksTableView.register(NSNib(nibNamed: "TaskCell", bundle: nil), forIdentifier: "TaskCell")
        tasksTableView.register(NSNib(nibNamed: "NewTaskCell", bundle: nil), forIdentifier: "NewTaskCell")
    }
    
    func deleteEntryAt(index: Int) {
        print("deleted" + String(index))
    }
    
    func createNewTask(name: String) {
        isInAddTaskMode = false
        headerAddTaskBtn.isEnabled = true
        tasksTableView.reloadData()
        entries.append(Entry(name: name, startedAt: NSDate(), color: NSColor(white: 0.5, alpha: 1)))
        tasksTableView.reloadData()
//        self.view.setFrameSize(NSSize(width: self.view.frame.width,
//                                      height: popoverTopOffset + CGFloat(entries.count) * popoverItemHeight))
    }
    
    func handleSwipeAction(action: NSTableViewRowAction, index: Int) {
        if action.title == "Delete" {
            deleteEntryAt(index: index)
        }
    }
    
    func onHeaderAddTaskClick(sender: Any) {
        isInAddTaskMode = true;
        headerAddTaskBtn.isEnabled = false
        tasksTableView.reloadData()
//        self.view.setFrameSize(NSSize(width: self.view.frame.width,
//                                      height: self.view.frame.height + popoverItemHeight))
    }
    
}

extension PopoverViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        if isInAddTaskMode {
            return entries.count + 1
        }
        return entries.count
    }
    
}

extension PopoverViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        // set the NewTaskCell view
        if isInAddTaskMode && row == entries.count {
            if let newTaskCellView = tableView.make(withIdentifier: "NewTaskCell", owner: nil) as? NewTaskCellView {
                newTaskCellView.addTaskAction = createNewTask
                return newTaskCellView
            }
        }
        
        // set the TaskCell view
        if let taskCellView = tableView.make(withIdentifier: "TaskCell", owner: nil) as? TaskCellView {
            taskCellView.taskDurationField.alphaValue = 0
            taskCellView.taskNameField.stringValue = entries[row].name
            taskCellView.taskColorBox.fillColor = entries[row].color
            taskCellView.startedAt = NSDate()
            taskCellView.selected = row == tableView.selectedRow
            return taskCellView
        }
        
        return nil
    }
    
    func tableView(_ tableView: NSTableView, rowActionsForRow row: Int, edge: NSTableRowActionEdge) -> [NSTableViewRowAction] {
        // add item swipe actions
        return [
            NSTableViewRowAction(style: NSTableViewRowActionStyle.destructive, title: "Delete", handler: handleSwipeAction)
        ]
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        // store this so its row can be unselected
        prevSelectedRow = tableView.selectedRow
        return true
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        // transition selection between two rows
        if let tableView = notification.object as? NSTableView {
            tableView.reloadData(forRowIndexes: IndexSet([prevSelectedRow, tableView.selectedRow]),
                                 columnIndexes: IndexSet([0]))
        }
    }
    
}
