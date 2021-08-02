//
//  HomePresenter.swift
//  CryptoMadTracker
//
//  Created by talgar osmonov on 27/7/21.
//  
//

import Foundation

final class HomePresenter {
	weak var view: HomeViewInput?
    weak var moduleOutput: HomeModuleOutput?
    
	var router: HomeRouterInput?
	var interactor: HomeInteractorInput?
}

extension HomePresenter: HomeModuleInput {
    
}

extension HomePresenter: HomeViewOutput {
    func showSaveDBErrorAllert() {
        router?.showSaveDBErrorAllert()
    }
    
    func showNoConnectionAllert() {
        router?.showNoConnectionAllert(completion: { [weak self] in
            self?.interactor?.fetchCryptos()
        })
    }
    
    func navigateToSaved() {
        router?.navigateToSaved()
    }
    
    func searchForCryptos(text: String) {
        interactor?.searchForCryptos(text: text)
    }
    
    func fetchCryptos() {
        interactor?.fetchCryptos()
    }
}

extension HomePresenter: HomeInteractorOutput {
    func noConnection() {
        DispatchQueue.main.async {
            self.view?.noConnection()
        }
    }
    
    func saveToDBError(error: Error) {
        view?.saveToDBError()
    }
    
    func searchForNotFound() {
        view?.searchForNotFound()
    }
    
    func searchForCryptoResult(data: CryptoPriceInfo) {
        view?.searchForCryptoResult(data: makeViewModel(data: data))
    }
    
    func searchForCryptoError(error: Error) {
        print(error.localizedDescription)
    }
    
    func fetchCryptosResult(data: [Crypto]) {
        view?.fetchCryptoResult(data: makeViewModels(data: data))
    }
    
    func fetchCryptosError(error: Error) {
        print(error.localizedDescription)
    }
    
}

private extension HomePresenter {
    func makeViewModels(data: [Crypto]) -> [CryptoViewModel]{
        return data.map { result in
            CryptoViewModel(id: result.id ?? 0, name: result.name ?? "", symbol: result.symbol ?? "", slug: result.slug ?? "", price: result.quote?.usd?.price ?? 0.0, percentChange: result.quote?.usd?.percentChange24H ?? 0.0)
        }
    }
    
    func makeViewModel(data: CryptoPriceInfo) -> CryptoViewModel {
        return CryptoViewModel(id: data.id ?? 0, name: data.name ?? "", symbol: data.symbol ?? "", slug: data.slug ?? "", price: data.quote?.usd?.price ?? 0.0, percentChange: data.quote?.usd?.percentChange24H ?? 0.0)
    }
}
