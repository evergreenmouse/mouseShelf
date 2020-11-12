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
}

extension PreferencesPresenter: PreferencesInteractorOutput {
    func interactor(_ interactor: PreferencesInteractorInput, didFetchUserRootCatalog url: URL?) {
        print(url)
    }
    
    func interactor(_ interactor: PreferencesInteractorInput, didFetchUserSettings userSettings: [String : Any]?) {
        view?.reloadSettingsData()
    }
    
    func interactor(_ interactor: PreferencesInteractorInput, didEncounterError error: Error) {
        //view. handle an Error
    }
    
    
}
