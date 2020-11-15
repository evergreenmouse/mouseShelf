//
//  PreferencesViewController.swift
//  mouseShelf
//
//  Created by Александр Ополовников on 12.11.2020.
//

import Cocoa

class PreferencesViewController: NSViewController {
    
    var presenter: PreferencesViewOutput?
    
    private lazy var preferencesView: PreferencesView = {
        let view = PreferencesView()
        view.delegate = self
        return view
    }()
    
    override func loadView() {
        view = preferencesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        PreferencesConfigurator().configure(viewController: self)
        setupOutlineView()
        presenter?.viewIsReady(self)
    }
    
    private func setupOutlineView() {
        preferencesView.outlineView.delegate = presenter?.outlineManager
        preferencesView.outlineView.dataSource = presenter?.outlineManager
        presenter?.outlineManager?.outlineView = preferencesView.outlineView
    }
    
}

extension PreferencesViewController: PreferencesViewInput {
    func reloadSettingsData() {
        preferencesView.outlineView.reloadData()
    }
    
    func reloadRootCatalog(with url: URL) {
        preferencesView.rootCatalogPathControl.url = url
    }
}

extension PreferencesViewController: PreferencesViewDelegate {    
    func preferencesViewDidPressedCancelButton(_ view: PreferencesView) {
        
    }
    
    func preferencesViewDidPressedSaveButton(_ view: PreferencesView, withNewRootCatalog url: URL) {
        presenter?.view(self, rootCatalogWasChanged: url)
    }
    
    func preferencesViewDidPressedAddFolderButton(_ view: PreferencesView, selectedFolder: Folder?) {
        presenter?.outlineManager?.createFolder(withTitle: "Новая папка", inFolder: selectedFolder)
    }
    
    func preferencesViewDidPressedDeleteFolderButton(_ view: PreferencesView, selectedFolder: Folder?, fromFolder: Folder?) {
        presenter?.outlineManager?.remove(folder: selectedFolder!, fromFolder: fromFolder)
    }
}
