//
//  PreferencesView.swift
//  mouseShelf
//
//  Created by Александр Ополовников on 12.11.2020.
//

import Cocoa

protocol PreferencesViewDelegate: class {
    func preferencesViewDidPressedRootCatalogButton(_ view: PreferencesView)
}

class PreferencesView: NSView {
    
    weak var delegate: PreferencesViewDelegate?
    
    private lazy var rootCatalogLabel: NSTextField = {
        let label = NSTextField()
        label.isEditable = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.stringValue = "Выберите корневую папку для создания проектов"
        return label
    }()
    
    private lazy var rootCatalogButton: NSButton = {
        let button = NSButton()
        button.title = "Выбрать"
        button.action = #selector(rootCatalogButtonWasPressed(_:))
        return button
    }()
    
    private lazy var rootCatalogPathControl: NSPathControl = {
        let pathControl = NSPathControl()
        return pathControl
    }()
    
    private lazy var horizontalLine: NSBox = {
        let line = NSBox()
        line.boxType = .separator
        return line
    }()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        autoresizingMask = [.width, .height]
        addSubview(rootCatalogLabel)
        NSLayoutConstraint.activate([rootCatalogLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
                                     rootCatalogLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
                                     rootCatalogLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
                                     rootCatalogLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)])
    }
    
    @objc private func rootCatalogButtonWasPressed(_ sender: NSButton) {
        
    }
    
}
