//
//  PreferencesView.swift
//  mouseShelf
//
//  Created by Александр Ополовников on 12.11.2020.
//

import Cocoa
import SnapKit

protocol PreferencesViewDelegate: class {
    func preferencesViewDidPressedCancelButton(_ view: PreferencesView)
    func preferencesViewDidPressedSaveButton(_ view: PreferencesView, withNewRootCatalog url: URL)
}

class PreferencesView: NSView {
    
    weak var delegate: PreferencesViewDelegate?
    
    private lazy var rootCatalogLabel: NSTextField = {
        let label = NSTextField()
        label.isEditable = false
        label.isBordered = false
        label.backgroundColor = .clear
        label.stringValue = "Выберите корневую папку для создания проектов"
        return label
    }()
    
    lazy var rootCatalogPathControl: NSPathControl = {
        let pathControl = NSPathControl()
        pathControl.pathStyle = .popUp
        pathControl.delegate = self
        return pathControl
    }()
    
    private lazy var horizontalLine: NSBox = {
        let line = NSBox()
        line.boxType = .separator
        return line
    }()
    
    private lazy var cancelButton: NSButton = {
        let button = NSButton(title: "Cancel", target: self, action: #selector(cancelButtonWasPressed(_:)))
        return button
    }()
    
    private lazy var saveButton: NSButton = {
        let button = NSButton(title: "Save", target: self, action: #selector(saveButtonWasPressed(_:)))
        return button
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
        addSubview(rootCatalogPathControl)
        addSubview(horizontalLine)
        addSubview(cancelButton)
        addSubview(saveButton)
        
        rootCatalogLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(95)
        }
        
        rootCatalogPathControl.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(rootCatalogLabel.snp.bottom).offset(16)
        }
        
        horizontalLine.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview()
            make.top.equalTo(rootCatalogPathControl.snp.bottom).offset(8)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(horizontalLine.snp.bottom).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.centerY.equalTo(saveButton.snp.centerY)
            make.trailing.equalTo(saveButton.snp.leading)
        }
        
    }
    
    @objc private func cancelButtonWasPressed(_ sender: NSButton) {
        delegate?.preferencesViewDidPressedCancelButton(self)
    }
    
    @objc private func saveButtonWasPressed(_ sender: NSButton) {
        guard let url = rootCatalogPathControl.url else { return }
        delegate?.preferencesViewDidPressedSaveButton(self, withNewRootCatalog: url)
    }
}

extension PreferencesView: NSPathControlDelegate {
    func pathControl(_ pathControl: NSPathControl, willPopUp menu: NSMenu) {
        while menu.items.count >= 4 {
            menu.items.remove(at: 3)
        }
    }
    
}

