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
}

extension PreferencesPresenter: PreferencesViewOutput {
    
    func viewIsReady(_ view: PreferencesViewInput) {
        interactor?.fetchUserRootCatalog()
    }
    
    func view(_ view: PreferencesViewInput, rootCatalogWasChanged newRootCatalog: URL) {
        interactor?.setUserRootCatalog(with: newRootCatalog)
    }
}

extension PreferencesPresenter: PreferencesInteractorOutput {
    func interactor(_ interactor: PreferencesInteractorInput, didFetchUserRootCatalog url: URL?) {
        guard let url = url else { return }
        view?.reloadRootCatalog(with: url)
    }
    
    func interactor(_ interactor: PreferencesInteractorInput, didFetchUserSettings userSettings: [String : Any]?) {
        view?.reloadSettingsData()
    }
    
    func interactor(_ interactor: PreferencesInteractorInput, didEncounterError error: Error) {
        //TODO: view. handle an Error
    }
    
    
}
