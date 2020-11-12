//
//  EmptySettingsView.swift
//  mouseShelf
//
//  Created by Александр Ополовников on 12.11.2020.
//

import Cocoa

class EmptySettingsView: NSView, CommonView {
    
    @IBOutlet weak var errorLabel: NSTextField!
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        _ = load(fromNIBNamed: "EmptySettingsView")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

