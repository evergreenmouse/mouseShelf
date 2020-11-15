//
//  DataStorage.swift
//  mouseShelf
//
//  Created by Александр Ополовников on 12.11.2020.
//

import Foundation

final class DataStorageService {
    
    static let instanse = DataStorageService()
    
    var foldersStructure = Model()
    
    func createFolder(withTitle title: String, inFolder folder: Folder?) {
        let newFolder = Folder(withTitle: title, id: foldersStructure.getFolderID())
        if let folder = folder {
            folder.items.append(newFolder)
        } else {
            foldersStructure.folders.append(newFolder)
        }
    }
    
    func remove(folder: Folder, fromFolder: Folder?) {
        if let fromFolder = fromFolder {
            fromFolder.remove(item: folder)
        } else {
            foldersStructure.folders.removeAll { $0 == folder }
        }
    }
    
    func fetchUserRootCatalog() -> URL? {
        guard let userRootCatalog = UserDefaults.standard.string(forKey: "com.user.rootCatalog") else {
            return nil
        }
        return URL(string: userRootCatalog)
    }
    
    func fetchUserFolderStructure() -> Model? {
        if let savedStructure = UserDefaults.standard.object(forKey: "com.user.folderStructure") as? Data {
            let decoder = JSONDecoder()
            if let loadedStructure = try? decoder.decode(Model.self, from: savedStructure) {
                    return loadedStructure
                }
        }
        return nil
    }
    
    func setUserRootCatalog(with url: URL) {
        UserDefaults.standard.set(url, forKey: "com.user.rootCatalog")
    }
    
    func setUserFolderStructure(with structure: Model?) {
        let encoder = JSONEncoder()
        if let encodedStructure = try? encoder.encode(structure) {
            UserDefaults.standard.set(encodedStructure, forKey: "com.user.folderStructure")
        }
    }
}
