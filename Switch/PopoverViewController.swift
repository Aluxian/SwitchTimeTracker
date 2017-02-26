//
//  PopoverViewController.swift
//  Switch
//
//  Created by Alexandru Rosianu on 24/02/2017.
//  Copyright © 2017 Aluxian. All rights reserved.
//

import Cocoa

class PopoverViewController: NSViewController {
    
    @IBOutlet weak var tasksTableView: NSTableView!
    @IBOutlet weak var headerAddTaskBtn: NSButton!
    
    var prevSelectedRow: Int = 0
    var currSelectedRow: Int = 0
    var isInAddTaskMode: Bool = false
    var dataSource: DataSource = DataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // link the table view
        tasksTableView.delegate = self
        tasksTableView.dataSource = dataSource
        
        // bind header buttons
        headerAddTaskBtn.action = #selector(onHeaderAddTaskClick(sender:))
        
        // ensure the table view is focused first
        headerAddTaskBtn.refusesFirstResponder = true
        
        // register custom cell views
        tasksTableView.register(NSNib(nibNamed: "TaskCell", bundle: nil), forIdentifier: "TaskCell")
        tasksTableView.register(NSNib(nibNamed: "NewTaskCell", bundle: nil), forIdentifier: "NewTaskCell")
    }
    
    func createNewTask(name: String) {
        isInAddTaskMode = false
        dataSource.numRowsOffset -= 1
        headerAddTaskBtn.isEnabled = true
        dataSource.activities.append(Activity(name: name))
        tasksTableView.reloadData()
    }
    
    func handleSwipeAction(action: NSTableViewRowAction, index: Int) {
        // delete
        if action.title == "Delete" {
            tasksTableView.removeRows(at: IndexSet([index]), withAnimation: [.slideUp, .effectFade])
            dataSource.activities.remove(at: index)
        }
    }
    
    func onHeaderAddTaskClick(sender: Any) {
        isInAddTaskMode = true;
        dataSource.numRowsOffset += 1
        headerAddTaskBtn.isEnabled = false
        tasksTableView.reloadData()
    }
    
}

extension PopoverViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        // set the NewTaskCell view
        if isInAddTaskMode && row == dataSource.activities.count {
            if let cellView = tableView.make(withIdentifier: "NewTaskCell", owner: nil) {
//                cellView.
//                newTaskCellView.addTaskCallback = createNewTask
                return cellView
            }
        }
        
        // set the TaskCell view
        if let cellView = tableView.make(withIdentifier: "TaskCell", owner: nil) {
//            taskCellView.taskNameField.stringValue = activities[row].name
//            taskCellView.startedAt = NSDate()
//            taskCellView.selected = row == currSelectedRow
            return cellView
        }
        
        return nil
    }
    
    func tableView(_ tableView: NSTableView, rowActionsForRow row: Int, edge: NSTableRowActionEdge) -> [NSTableViewRowAction] {
        // add item swipe actions
        var items = [NSTableViewRowAction]()
        
        if row > 0 {
            items.append(NSTableViewRowAction(style: NSTableViewRowActionStyle.destructive,
                                              title: "Delete",
                                              handler: handleSwipeAction))
        }
        
        return items
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        // store the new index
        prevSelectedRow = currSelectedRow
        currSelectedRow = row
        print("should sel indeX: " + String(row))
        return true
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        // transition selection between the two rows
        if let tableView = notification.object as? NSTableView {
            tableView.reloadData(forRowIndexes: IndexSet([prevSelectedRow, currSelectedRow]),
                                 columnIndexes: IndexSet([0]))
        }
    }
    
}
