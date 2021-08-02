//
//  SavedInteractor.swift
//  CryptoMadTracker
//
//  Created by talgar osmonov on 28/7/21.
//  
//

import Foundation

final class SavedInteractor {
	weak var output: SavedInteractorOutput?
    var databaseService: CryptoStorageProtocol?
}

extension SavedInteractor: SavedInteractorInput {
    func fetchCryptosFromDB() {
        databaseService?.fetchCryptos(completion: { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                self.output?.fetchCryptosFromDBResult(data: data ?? [])
            case .failure(let error):
                self.output?.fetchCryptoFromDBError(error: error)
            }
        })
    }
}
