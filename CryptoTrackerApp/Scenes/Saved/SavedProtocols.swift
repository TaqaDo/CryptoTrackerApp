//
//  SavedProtocols.swift
//  CryptoMadTracker
//
//  Created by talgar osmonov on 28/7/21.
//  
//

import Foundation

protocol SavedModuleInput {
	var moduleOutput: SavedModuleOutput? { get }
}

protocol SavedModuleOutput: AnyObject {
}

protocol SavedViewInput: AnyObject {
    func fetchCryptoResult(data: [CryptoViewModel])
}

protocol SavedViewOutput: AnyObject {
    func fetchCryptosFromDB()
}

protocol SavedInteractorInput: AnyObject {
    func fetchCryptosFromDB()
}

protocol SavedInteractorOutput: AnyObject {
    func fetchCryptosFromDBResult(data: [RealmCrypto])
    func fetchCryptoFromDBError(error: Error)
}

protocol SavedRouterInput: AnyObject {
}
