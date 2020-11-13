//
//  OutletDataManager.swift
//  mouseShelf
//
//  Created by Александр Ополовников on 13.11.2020.
//

import Cocoa

protocol OutlineDataManagerDelegate: class { }

class OutlineDataManager: NSObject {
    
    let foldersStructure = [FolderItem]()
    
    weak var delegate: OutlineDataManagerDelegate?
    
}

extension OutlineDataManager: NSOutlineViewDataSource {
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        return 2
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        return NSView()
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        return true
    }
}

extension OutlineDataManager: NSOutlineViewDelegate {
    
}
