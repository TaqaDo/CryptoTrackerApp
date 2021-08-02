//
//  HomeInteractor.swift
//  CryptoMadTracker
//
//  Created by talgar osmonov on 27/7/21.
//  
//

import Foundation


struct Constants {
    static let initailStart = 1
}

final class HomeInteractor {
    weak var output: HomeInteractorOutput?
    var networkService: CryptoNetworkProtocol?
    var databaseService: CryptoStorageProtocol?
    private var start = Constants.initailStart
}

extension HomeInteractor: HomeInteractorInput {
    func searchForCryptos(text: String) {
        networkService?.searchForCrypto(slug: text) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                if data.status!.errorCode! >= 400 {
                    self.output?.searchForNotFound()
                } else {
                    guard let responseData = data.data?.values.first else {return}
                    self.output?.searchForCryptoResult(data: responseData)
                }
            case .failure(let error):
                if let error = error as? URLError, error.code  == URLError.Code.notConnectedToInternet {
                    self.output?.noConnection()
                }
                self.output?.searchForCryptoError(error: error)
            }
        }
    }
    
    func fetchCryptos() {
        let params = RequestParams(limit: 35, start: start)
        networkService?.fetchCryptos(params: params, completion: { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                guard let responseData = data.data else {return}
                self.saveCryptosToDB(data: responseData)
                self.output?.fetchCryptosResult(data: data.data ?? [])
            case .failure(let error):
                if let error = error as? URLError, error.code  == URLError.Code.notConnectedToInternet {
                    self.output?.noConnection()
                }
                self.output?.fetchCryptosError(error: error)
            }
        })
    }
}

private extension HomeInteractor {
    
    func saveCryptosToDB(data: [Crypto]) {
        self.databaseService?.saveCryptos(data: self.makeRealmCrypto(data: data)) { [weak self] result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                self?.output?.saveToDBError(error: error)
            }
        }
        
    }
    
    func makeRealmCrypto(data: [Crypto]) -> [RealmCrypto] {
        return data.map { result in
            let model = RealmCrypto()
            model.id = result.id ?? 0
            model.name = result.name ?? ""
            model.symbol = result.symbol ?? ""
            model.slug = result.slug ?? ""
            model.price = result.quote?.usd?.price ?? 0.0
            model.percentChange = result.quote?.usd?.percentChange24H ?? 0.0
            return model
        }
    }
}
