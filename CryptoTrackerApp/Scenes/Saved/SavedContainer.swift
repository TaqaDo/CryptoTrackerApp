//
//  SavedContainer.swift
//  CryptoMadTracker
//
//  Created by talgar osmonov on 28/7/21.
//  
//

import UIKit

final class SavedContainer {
    let input: SavedModuleInput
	let viewController: UIViewController
	private(set) weak var router: SavedRouterInput!

	static func assemble(with context: SavedContext) -> SavedContainer {
        let container = AppDependencies.shared.container
        let router = SavedRouter()
        let interactor = SavedInteractor()
        let presenter = SavedPresenter()
		let viewController = SavedViewController()
        
        viewController.output = presenter

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
        presenter.router = router
        presenter.interactor = interactor

		interactor.output = presenter
        interactor.databaseService = container.resolve(CryptoStorageProtocol.self)

        return SavedContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: SavedModuleInput, router: SavedRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct SavedContext {
	weak var moduleOutput: SavedModuleOutput?
}
