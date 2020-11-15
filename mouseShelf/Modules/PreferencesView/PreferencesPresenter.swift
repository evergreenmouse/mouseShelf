//
//  PreferencesPresenter.swift
//  mouseShelf
//
//  Created by Александр Ополовников on 12.11.2020.
//

import Foundation

class PreferencesPresenter {
    weak var view: PreferencesViewInput?
    var router: PreferencesRouterProtocol?
    var interactor: PreferencesInteractorInput?
    var outlineManager: OutlineDataManager?
}

extension PreferencesPresenter: PreferencesViewOutput {
    
    func viewIsReady(_ view: PreferencesViewInput) {
        interactor?.fetchUserRootCatalog()
        interactor?.fetchUserFolderStructure()
    }
    
    func view(_ view: PreferencesViewInput, rootCatalogWasChanged newRootCatalog: URL) {
        interactor?.setUserRootCatalog(with: newRootCatalog)
        interactor?.setUserFolderStructure(with: outlineManager?.dataService.foldersStructure)
    }
}

extension PreferencesPresenter: PreferencesInteractorOutput {
    func interactor(_ interactor: PreferencesInteractorInput, didFetchUserFolderStructure folderStructure: Model?) {
        if let folderStructure = folderStructure {
            outlineManager?.dataService.foldersStructure = folderStructure
            view?.reloadSettingsData()
        }
        
    }
    
    func interactor(_ interactor: PreferencesInteractorInput, didFetchUserRootCatalog url: URL?) {
        guard let url = url else { return }
        view?.reloadRootCatalog(with: url)
    }

    
    func interactor(_ interactor: PreferencesInteractorInput, didEncounterError error: Error) {
        //TODO: view. handle an Error
    }
}

extension PreferencesPresenter: OutlineDataManagerDelegate { }
