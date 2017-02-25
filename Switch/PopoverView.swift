//
//  PopoverController.swift
//  Switch
//
//  Created by Alexandru Rosianu on 25/02/2017.
//  Copyright © 2017 Aluxian. All rights reserved.
//

import Cocoa

class PopoverView: NSView {
    
    override func viewDidMoveToWindow() {
        guard let frameView = window?.contentView?.superview else {
            return
        }
        
        // make the background completely white
        let backgroundView = NSView(frame: frameView.bounds)
        backgroundView.wantsLayer = true
        backgroundView.layer?.backgroundColor = CGColor(gray: 0.97, alpha: 1)
        backgroundView.autoresizingMask = [.viewWidthSizable, .viewHeightSizable]
        frameView.addSubview(backgroundView, positioned: .below, relativeTo: frameView)
    }
    
}
