//
//  NetworkService+CryptoSSSS.swift
//  CryptoMadTracker
//
//  Created by talgar osmonov on 27/7/21.
//

import Foundation

extension NetworkService: CryptoNetworkProtocol {
    func searchForCrypto(slug: String, completion: @escaping CryptoPriceInfoResult) {
        let url = URLFactory.cryptoPriceInfo(slug: slug)
        baseRequest(url: url, completion: completion)
    }

    func fetchCryptoInfo(slug: String, completion: @escaping CryptoInfoResult) {
        let url = URLFactory.cryptoInfo(slug: slug)
        baseRequest(url: url, completion: completion)
    }

    func fetchCryptos(params: RequestParams, completion: @escaping CryptoResult) {
        let url = URLFactory.crypto(params: params)
        baseRequest(url: url, completion: completion)
    }
}
