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
    
    func preferencesViewDidPressedAddFolderButton(_ view: PreferencesView, selectedFolder: Folder?)
    func preferencesViewDidPressedDeleteFolderButton(_ view: PreferencesView, selectedFolder: Folder?, fromFolder: Folder?)
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
        pathControl.allowedTypes = ["public.folder"]
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
    
    private lazy var scrollView: NSScrollView = {
        let scrollView = NSScrollView()
        scrollView.borderType = .grooveBorder
        scrollView.documentView = outlineView
        return scrollView
    }()
    
    private lazy var outlineLabel: NSTextField = {
        let label = NSTextField()
        label.isEditable = false
        label.isBordered = false
        label.backgroundColor = .clear
        label.stringValue = "Настройте структуру проекта"
        return label
    }()
    
    lazy var outlineView: NSOutlineView = {
        let outlineView = NSOutlineView(frame: .zero)
        outlineView.headerView = nil
        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "column"))
        outlineView.addTableColumn(column)
        column.isEditable = true
        outlineView.isEnabled = true
        return outlineView
    }()
    
    private lazy var addFolderButton: NSButton = {
        guard let addImageName = NSImage(named: NSImage.addTemplateName) else { return NSButton() }
        let button = NSButton(image: addImageName, target: self, action: #selector(addFolderButtonWasPressed(_:)))
        return button
    }()
    
    private lazy var deleteFolderButton: NSButton = {
        guard let deleteImageName = NSImage(named: NSImage.removeTemplateName) else { return NSButton() }
        let button = NSButton(image: deleteImageName, target: self, action: #selector(deleteFolderButtonWasPressed(_:)))
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
        addSubview(outlineLabel)
        addSubview(scrollView)

        addSubview(addFolderButton)
        addSubview(deleteFolderButton)
        
        addSubview(rootCatalogLabel)
        addSubview(rootCatalogPathControl)
        addSubview(horizontalLine)
        addSubview(cancelButton)
        addSubview(saveButton)
        
        outlineLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(16)
        }
        
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(240)
            make.top.equalTo(outlineLabel.snp.bottom).offset(8)
        }
        
        addFolderButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(scrollView.snp.bottom).offset(4)
        }
        
        deleteFolderButton.snp.makeConstraints { make in
            make.leading.equalTo(addFolderButton.snp.trailing).offset(4)
            make.centerY.equalTo(addFolderButton.snp.centerY)
        }
        
        rootCatalogLabel.snp.makeConstraints { make in
            make.top.equalTo(addFolderButton.snp.bottom).offset(8)
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
    
    @objc private func addFolderButtonWasPressed(_ sender: NSButton) {
        let selectedFolder = outlineView.item(atRow: outlineView.selectedRow) as? Folder
        delegate?.preferencesViewDidPressedAddFolderButton(self, selectedFolder: selectedFolder)
        outlineView.reloadData()
        outlineView.expandItem(selectedFolder)
    }
    
    @objc private func deleteFolderButtonWasPressed(_ sender: NSButton) {
        guard let selectedFolder = outlineView.item(atRow: outlineView.selectedRow) as? Folder else { return }
        let parentFolder = outlineView.parent(forItem: selectedFolder) as? Folder
        delegate?.preferencesViewDidPressedDeleteFolderButton(self, selectedFolder: selectedFolder, fromFolder: parentFolder)
        outlineView.reloadData()
    }
}

extension PreferencesView: NSPathControlDelegate {
    func pathControl(_ pathControl: NSPathControl, willPopUp menu: NSMenu) {
        while menu.items.count >= 4 {
            menu.items.remove(at: 3)
        }
    }
}

extension PreferencesView: NSOpenSavePanelDelegate {
    func panelSelectionDidChange(_ sender: Any?) {
        print("qq")
    }
}
