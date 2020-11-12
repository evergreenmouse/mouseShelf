//
//  PreferenceConfigurator.swift
//  mouseShelf
//
//  Created by Александр Ополовников on 12.11.2020.
//

import Cocoa

class PreferencesConfigurator {
    func configure(viewController: PreferencesViewController) {
        let presenter = PreferencesPresenter()
        let interactor = PreferencesInteractor()
        let router = PreferencesRouter()

        presenter.interactor = interactor
        interactor.presenter = presenter

        viewController.presenter = presenter
        presenter.view = viewController

        presenter.router = router
        router.viewController = viewController
    }
}
