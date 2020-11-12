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
        
        presenter?.viewIsReady(self)
    }
    
}

extension PreferencesViewController: PreferencesViewInput {
    func reloadSettingsData() {
        print("reload settings data")
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
}
