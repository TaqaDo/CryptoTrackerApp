//
//  HomeContainer.swift
//  CryptoMadTracker
//
//  Created by talgar osmonov on 27/7/21.
//  
//

import UIKit

final class HomeContainer {
    let input: HomeModuleInput
	let viewController: UIViewController
	private(set) weak var router: HomeRouterInput!
    

	static func assemble(with context: HomeContext) -> HomeContainer {
        let container = AppDependencies.shared.container
        let router = HomeRouter()
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
		let viewController = HomeViewController()
        
        viewController.output = presenter

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
        presenter.router = router
        presenter.interactor = interactor

		interactor.output = presenter
        interactor.networkService = container.resolve(CryptoNetworkProtocol.self)
        interactor.databaseService = container.resolve(CryptoStorageProtocol.self)
        
        router.viewController = viewController

        return HomeContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: HomeModuleInput, router: HomeRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct HomeContext {
	weak var moduleOutput: HomeModuleOutput?
}
