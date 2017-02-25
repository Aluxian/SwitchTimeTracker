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
        
        let backgroundView = NSView(frame: frameView.bounds)
        backgroundView.wantsLayer = true
        backgroundView.layer?.backgroundColor = .white // colour of your choice
        backgroundView.autoresizingMask = [.viewWidthSizable, .viewHeightSizable]
        
        frameView.addSubview(backgroundView, positioned: .below, relativeTo: frameView)
    }
    
}
