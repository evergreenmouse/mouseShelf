//
//  PreferencesContract.swift
//  mouseShelf
//
//  Created by Александр Ополовников on 12.11.2020.
//

import Foundation

protocol PreferencesViewOutput: class {
    func viewIsReady(_ view: PreferencesViewInput)
    func view(_ view: PreferencesViewInput, rootCatalogWasChanged newRootCatalog: URL)
}

protocol PreferencesViewInput: class {
    func reloadSettingsData()
    func reloadRootCatalog(with url: URL)
}

protocol PreferencesInteractorInput: class {
    func fetchUserRootCatalog()
    func setUserRootCatalog(with url: URL)
}

protocol PreferencesInteractorOutput: class {
    func interactor(_ interactor: PreferencesInteractorInput, didFetchUserSettings userSettings: [String: Any]?)
    func interactor(_ interactor: PreferencesInteractorInput, didFetchUserRootCatalog url: URL?)
    func interactor(_ interactor: PreferencesInteractorInput, didEncounterError error: Error)
}

protocol PreferencesRouterProtocol: class {
    
}
