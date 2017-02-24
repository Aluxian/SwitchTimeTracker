//
//  AppDelegate.swift
//  Switch
//
//  Created by Alexandru Rosianu on 24/02/2017.
//  Copyright © 2017 Aluxian. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusItem: NSStatusItem!
    var popover: NSPopover!
    var eventMonitor: EventMonitor!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // create the menu bar icon
        statusItem = NSStatusBar.system().statusItem(withLength: -2)
        if let button = statusItem.button {
            button.image = NSImage(named: "MenuBarIcon")
            button.action = #selector(togglePopover(_:))
        }
        
        // create the popover
        let mainViewController = NSStoryboard(name: "Main", bundle: nil)
            .instantiateController(withIdentifier: "ViewControllerId") as! ViewController
        popover = NSPopover()
        popover.contentViewController = mainViewController
        
        // listen for clicks outside the popover (to close it)
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [unowned self] event in
            if self.popover.isShown {
                self.closePopover(event)
            }
        }
        eventMonitor.start()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func togglePopover(_ sender: AnyObject?) {
        if popover.isShown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
    
    func showPopover(_ sender: AnyObject?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
        eventMonitor.start()
    }
    
    func closePopover(_ sender: AnyObject?) {
        popover.performClose(sender)
        eventMonitor.stop()
    }
    
}

