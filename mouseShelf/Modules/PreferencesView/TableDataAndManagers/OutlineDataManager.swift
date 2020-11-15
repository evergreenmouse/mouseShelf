//
//  OutletDataManager.swift
//  mouseShelf
//
//  Created by Александр Ополовников on 13.11.2020.
//

import Cocoa

protocol OutlineDataManagerDelegate: class { }

class OutlineDataManager: NSObject {
    
    let dataService = DataStorageService.instanse
    
    weak var outlineView: NSOutlineView?
    
    weak var delegate: OutlineDataManagerDelegate?
    
    func createFolder(withTitle title: String, inFolder folder: Folder?) {
        dataService.createFolder(withTitle: title, inFolder: folder)
    }
    
    func remove(folder: Folder, fromFolder: Folder?) {
        dataService.remove(folder: folder, fromFolder: fromFolder)
    }
    
}

extension OutlineDataManager: NSOutlineViewDataSource {
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if let item = item as? Folder {
            return item.totalItems
        }
        return dataService.foldersStructure.totalFolders
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if let item = item as? Folder {
            return item.items[index]
        }
        return dataService.foldersStructure.folders[index]
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        if let item = item as? Folder {
            return item.items.count > 0
        }
        
        return false
    }
    
    func outlineView(_ outlineView: NSOutlineView, objectValueFor tableColumn: NSTableColumn?, byItem item: Any?) -> Any? {
        return nil
    }
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        if let item = item as? Folder {
            let cell = OutlineTableCell()
            cell.configure(with: item)
            cell.outlineView = outlineView
            return cell
        }
       
        return nil
    }
}

extension OutlineDataManager: NSOutlineViewDelegate {
    
}
