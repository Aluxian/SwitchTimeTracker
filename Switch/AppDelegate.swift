//
//  MyAppDelegate.swift
//  Switch
//
//  Created by Alexandru Rosianu on 25/02/2017.
//  Copyright © 2017 Aluxian. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var popover: NSPopover!
    var statusItem: NSStatusItem!
    var outsideClickEventMonitor: EventMonitor!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // create the menu bar icon
        statusItem = NSStatusBar.system().statusItem(withLength: -2)
        statusItem.button?.image = NSImage(named: "MenuBarIcon")
        statusItem.button?.action = #selector(togglePopover(_:))
        
        // create the popover
        popover = NSPopover()
        popover.contentViewController = NSStoryboard(name: "Main", bundle: nil)
            .instantiateController(withIdentifier: "PopoverID") as! ViewController

        
        
        // listen for clicks outside the popover (to close it)
        outsideClickEventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [unowned self] event in
            if self.popover.isShown {
                self.closePopover(event)
            }
        }
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
            NSRunningApplication.current().activate(options: NSApplicationActivationOptions.activateIgnoringOtherApps)
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            popover.becomeFirstResponder()
        }
        outsideClickEventMonitor.start()
    }
    
    func closePopover(_ sender: AnyObject?) {
        popover.performClose(sender)
        outsideClickEventMonitor.stop()
    }
    
}
