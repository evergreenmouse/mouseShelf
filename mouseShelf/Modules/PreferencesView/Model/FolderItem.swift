//
//  FolderItem.swift
//  mouseShelf
//
//  Created by Александр Ополовников on 13.11.2020.
//

import Foundation

struct Model: Codable {
    var folders = [Folder]()
    var totalFolders: Int { get { return folders.count} }
    private var nextFolderID = 1
    
    mutating func getFolderID() -> Int {
        nextFolderID += 1
        return nextFolderID - 1
    }
}

class Folder: Equatable, Codable {
    var id: Int?
    var title: String?
    var items = [Folder]()
    var totalItems: Int { get { return items.count }}
    
    init(withTitle title: String, id: Int) {
        self.title = title
        self.id = id
    }
    
    static func == (lhs: Folder, rhs: Folder) -> Bool {
        return lhs.id == rhs.id
    }
    
    func remove<T>(item: T) {
        if T.self == Folder.self {
            (item as! Folder).items.removeAll()
        }
        
        // Find the given item in the items array and remove it.
        for (index, currentItem) in items.enumerated() {
            guard type(of: currentItem) == T.self, currentItem as? T.Type == item as? T.Type else { continue }
            items.remove(at: index)
            break
        }
    }
}
