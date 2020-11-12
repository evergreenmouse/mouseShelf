//
//  PreferencesInteractor.swift
//  mouseShelf
//
//  Created by Александр Ополовников on 12.11.2020.
//

import Foundation

class PreferencesInteractor: PreferencesInteractorInput {
    weak var presenter: PreferencesInteractorOutput?
    
    weak var userDataDelegate = DataStorageService.instanse
    
    func fetchUserRootCatalog() {
        let userRootCatalog = userDataDelegate?.fetchUserRootCatalog()
        presenter?.interactor(self, didFetchUserRootCatalog: userRootCatalog)
    }
    
    func setUserRootCatalog(with url: URL) {
        userDataDelegate?.setUserRootCatalog(with: url)
    }
}
