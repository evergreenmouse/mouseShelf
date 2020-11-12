//
//  GenerateViewConfigurator.swift
//  mouseShelf
//
//  Created by Александр Ополовников on 12.11.2020.
//

import Cocoa

final class GenerateViewConfigurator {
    
    func configureGenerateView() -> GenerateView {
        let generateView = GenerateView(frame: NSRect(x: 0.0, y: 0.0, width: 276, height: 93))
        return generateView
    }
}
