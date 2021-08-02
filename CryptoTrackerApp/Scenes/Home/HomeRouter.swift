//
//  HomeRouter.swift
//  CryptoMadTracker
//
//  Created by talgar osmonov on 27/7/21.
//  
//

import UIKit

final class HomeRouter {
    var viewController: UIViewController?
}

extension HomeRouter: HomeRouterInput {
    func showSaveDBErrorAllert() {
        let allertController = UIAlertController(title: Localization.noInternet, message: Localization.noInternetMessage, preferredStyle: .alert)
        allertController.addAction(UIAlertAction(title: Localization.close,
                                                 style: .cancel, handler: nil))
        
        viewController?.navigationController?.present(allertController, animated: true, completion: nil)
    }
    
    func navigateToSaved() {
        let context = SavedContext(moduleOutput: nil)
        let container = SavedContainer.assemble(with: context)
        let controller = container.viewController
        
        viewController?.navigationController?.present(controller,
                                                      animated: true,
                                                      completion: nil)
    }
    
    func showNoConnectionAllert(completion: @escaping() -> Void) {
        let allertController = UIAlertController(title: Localization.noInternet, message: Localization.noInternetMessage, preferredStyle: .alert)
        allertController.addAction(UIAlertAction(title: Localization.retry,
                                                 style: .destructive,
                                                 handler: { action in
            completion()
        }))
        allertController.addAction(UIAlertAction(title: Localization.stayOffline,
                                                 style: .default, handler: nil))
        
        viewController?.navigationController?.present(allertController, animated: true, completion: nil)
    }
}
