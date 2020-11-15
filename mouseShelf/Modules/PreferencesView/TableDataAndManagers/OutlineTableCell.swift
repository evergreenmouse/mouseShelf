//
//  OutlineTableCell.swift
//  mouseShelf
//
//  Created by Александр Ополовников on 13.11.2020.
//

import Cocoa
import SnapKit

class OutlineTableCell: NSTableCellView {
    
    weak var outlineView: NSOutlineView?
    
    private lazy var cellLabel: NSTextField = {
        let label = NSTextField()
        label.isEditable = true
        label.isBordered = false
        label.backgroundColor = .clear
        return label
    }()
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(cellLabel)
        cellLabel.delegate = self
        cellLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(with model: Folder) {
        cellLabel.stringValue = model.title ?? "New"
    }
}

extension OutlineTableCell: NSTextFieldDelegate {
    func control(_ control: NSControl, textShouldEndEditing fieldEditor: NSText) -> Bool {
        guard let outlineView = outlineView else { return true }
        guard let folder = outlineView.item(atRow: outlineView.selectedRow) as? Folder else { return false }
        folder.title = control.stringValue
        return true
    }
}
