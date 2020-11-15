//
//  PreferencesContract.swift
//  mouseShelf
//
//  Created by Александр Ополовников on 12.11.2020.
//

import Foundation

protocol PreferencesViewOutput: class {
    var outlineManager: OutlineDataManager? { get }
    func viewIsReady(_ view: PreferencesViewInput)
    func view(_ view: PreferencesViewInput, rootCatalogWasChanged newRootCatalog: URL)
}

protocol PreferencesViewInput: class {
    func reloadSettingsData()
    func reloadRootCatalog(with url: URL)
}

protocol PreferencesInteractorInput: class {
    func fetchUserRootCatalog()
    func fetchUserFolderStructure()
    func setUserRootCatalog(with url: URL)
    func setUserFolderStructure(with structure: Model?)
}

protocol PreferencesInteractorOutput: class {
    func interactor(_ interactor: PreferencesInteractorInput, didFetchUserFolderStructure folderStructure: Model?)
    func interactor(_ interactor: PreferencesInteractorInput, didFetchUserRootCatalog url: URL?)
    func interactor(_ interactor: PreferencesInteractorInput, didEncounterError error: Error)
}

protocol PreferencesRouterProtocol: class {
    
}
