//
//  HomeProtocols.swift
//  CryptoMadTracker
//
//  Created by talgar osmonov on 27/7/21.
//  
//

import Foundation

protocol HomeModuleInput {
	var moduleOutput: HomeModuleOutput? { get }
}

protocol HomeModuleOutput: AnyObject {
    
}

protocol HomeViewInput: AnyObject {
    func fetchCryptoResult(data: [CryptoViewModel])
    func searchForCryptoResult(data: CryptoViewModel)
    func searchForNotFound()
    func saveToDBError()
    func noConnection()
}

protocol HomeViewOutput: AnyObject {
    func showNoConnectionAllert()
    func showSaveDBErrorAllert()
    func fetchCryptos()
    func searchForCryptos(text: String)
    func navigateToSaved()
}

protocol HomeInteractorInput: AnyObject {
    func fetchCryptos()
    func searchForCryptos(text: String)
}

protocol HomeInteractorOutput: AnyObject {
    func noConnection()
    func saveToDBError(error: Error)
    func searchForNotFound()
    func searchForCryptoResult(data: CryptoPriceInfo)
    func searchForCryptoError(error: Error)
    func fetchCryptosResult(data: [Crypto])
    func fetchCryptosError(error: Error)
}

protocol HomeRouterInput: AnyObject {
    func navigateToSaved()
    func showNoConnectionAllert(completion: @escaping() -> Void)
    func showSaveDBErrorAllert()
}
