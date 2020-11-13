//
//  GenerateView.swift
//  mouseShelf
//
//  Created by Александр Ополовников on 12.11.2020.
//

import Cocoa

class GenerateView: NSView, CommonView {
    
    
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var generateButton: NSButton!
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        _ = load(fromNIBNamed: "GenerateView")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func generateButtonPressed(_ sender: Any) {
        print(textField.stringValue)
    }
}
