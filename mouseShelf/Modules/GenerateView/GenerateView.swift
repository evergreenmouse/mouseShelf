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
    
        createRootFolders()
    }
    
    func createRootFolders() {
        let path = "\(DataStorageService.instanse.fetchUserRootCatalog()!)/" + "\(textField.stringValue)/"
        createSingleFolder(atPath: path)
        for folder in DataStorageService.instanse.foldersStructure.folders {
            createSubfolders(for: folder, path: path)
        }
    }
    
    func createSubfolders(for folder: Folder, path: String) {
        let newPath = path + "\(folder.title!)/"
        createSingleFolder(atPath: newPath)
        for subFolder in folder.items {
            createSubfolders(for: subFolder, path: newPath)
        }
    }
    
    func createSingleFolder(atPath: String) {
        do {
            try FileManager.default.createDirectory(atPath: atPath, withIntermediateDirectories: false, attributes: nil)
        } catch {
            print(error.localizedDescription);
        }
    }

}

extension GenerateView: NSTextFieldDelegate {
    
}
