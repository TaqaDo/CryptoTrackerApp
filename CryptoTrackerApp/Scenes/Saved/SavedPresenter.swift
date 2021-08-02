//
//  SavedPresenter.swift
//  CryptoMadTracker
//
//  Created by talgar osmonov on 28/7/21.
//  
//

import Foundation

final class SavedPresenter {
	weak var view: SavedViewInput?
    weak var moduleOutput: SavedModuleOutput?
    
	var router: SavedRouterInput?
	var interactor: SavedInteractorInput?
    
}

extension SavedPresenter: SavedModuleInput {
}

extension SavedPresenter: SavedViewOutput {
    func fetchCryptosFromDB() {
        interactor?.fetchCryptosFromDB()
    }
}

extension SavedPresenter: SavedInteractorOutput {
    func fetchCryptosFromDBResult(data: [RealmCrypto]) {
        view?.fetchCryptoResult(data: makeViewModels(data: data))
    }
    
    func fetchCryptoFromDBError(error: Error) {
        print(error.localizedDescription)
    }
    
}

private extension SavedPresenter {
    func makeViewModels(data: [RealmCrypto]) -> [CryptoViewModel]{
        return data.map { result in
            CryptoViewModel(id: result.id , name: result.name, symbol: result.symbol, slug: result.slug, price: result.price, percentChange: result.percentChange)
        }
    }
}

