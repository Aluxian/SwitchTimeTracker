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
    
    var window: NSWindow!
    var statusItem: NSStatusItem!
    var outsideClickEventMonitor: EventMonitor!
    
    var shown = false
    let mainViewController = NSStoryboard(name: "Main", bundle: nil)
        .instantiateController(withIdentifier: "WinCtrl") as! NSWindowController
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // create the menu bar icon
        statusItem = NSStatusBar.system().statusItem(withLength: -2)
        statusItem.button?.image = NSImage(named: "MenuBarIcon")
        statusItem.button?.action = #selector(togglePopover(_:))
        
        // listen for clicks outside the popover (to close it)
        outsideClickEventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [unowned self] event in
            if self.shown {
                self.closePopover(event)
            }
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func togglePopover(_ sender: AnyObject?) {
        if shown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
    
    func showPopover(_ sender: AnyObject?) {
        mainViewController.showWindow(self)
        outsideClickEventMonitor.start()
        shown = true
    }
    
    func closePopover(_ sender: AnyObject?) {
        mainViewController.close()
        outsideClickEventMonitor.stop()
        shown = false
    }
    
}

