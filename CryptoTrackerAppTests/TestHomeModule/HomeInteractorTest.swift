//
//  HomeInteractorTest.swift
//  CryptoMadTrackerTests
//
//  Created by talgar osmonov on 29/7/21.
//

import XCTest
@testable import CryptoMadTracker

class MockOutput: HomeInteractorOutput {
    
    var cryptosResult: [Crypto]?
    var cryptosInfoResult: CryptoInfo?
    var cryptoSearchInfoResult: CryptoPriceInfo?
    var notFound: Int?
    var noConnectionResult: Int?
    var catchError: Error?
    
    func noConnection() {
        noConnectionResult = 1
    }
    
    func saveToDBError(error: Error) {
        
    }
    
    func searchForNotFound() {
        notFound = 1
    }
    
    func searchForCryptoResult(data: CryptoPriceInfo) {
        cryptoSearchInfoResult = data
    }
    
    func searchForCryptoError(error: Error) {
        catchError = error
    }
    
    func fetchCryptosResult(data: [Crypto]) {
        cryptosResult = data
    }
    
    func fetchCryptosError(error: Error) {
        catchError = error
    }
    
}

class MockNetworkService: CryptoNetworkProtocol {
    
    var cryptos: CryptoResponse!
    var cryptoInfo: CryptoInfoResponse!
    var cryptoSearchInfo: CryptoPriceInfoResponse!
    
    func fetchCryptos(params: RequestParams, completion: @escaping CryptoResult) {
        
        if let cryptos = cryptos {
            completion(.success(cryptos))
        } else {
            let error = NSError(domain: "", code: 400, userInfo: nil)
            completion(.failure(error))
        }
    }
    
    func fetchCryptoInfo(slug: String, completion: @escaping CryptoInfoResult) {
        
        if let cryptoInfo = cryptoInfo {
            completion(.success(cryptoInfo))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
        
    }
    
    func searchForCrypto(slug: String, completion: @escaping CryptoPriceInfoResult) {
        
        if let cryptoSearchInfo = cryptoSearchInfo {
            completion(.success(cryptoSearchInfo))
        } else {
            let error = NSError(domain: "", code: 400, userInfo: nil)
            completion(.failure(error))
        }
    }
    
}



class HomeInteractorTest: XCTestCase {
    
    var output: MockOutput!
    var interactor: HomeInteractor!
    var networkService: MockNetworkService!
    
    override func setUpWithError() throws {
        output = MockOutput()
        interactor = HomeInteractor()
        networkService = MockNetworkService()
    }
    
    override func tearDownWithError() throws {
        output = nil
        interactor = nil
        networkService = nil
    }
    
    func testFetchSuccessCryptos() {
        
        let cryptos = CryptoResponse(status: nil, data: [Crypto(id: 1, name: "Baz", symbol: "Bar", slug: "Foo", numMarketPairs: nil, dateAdded: nil, tags: nil, maxSupply: nil, circulatingSupply: nil, totalSupply: nil, cmcRank: nil, lastUpdated: nil, quote: nil)])
        networkService.cryptos = cryptos
        
        interactor.networkService = networkService
        interactor.output = output
        
        interactor.fetchCryptos()
        
        XCTAssertEqual(output.cryptosResult?.first?.name, "Baz")
        XCTAssertNotNil(output.cryptosResult)
    }
    
    func testFetchNoConnectionCryptos() {
        
        interactor.networkService = networkService
        interactor.output = output
        
        interactor.fetchCryptos()
        
        XCTAssertEqual(output.noConnectionResult, nil)
    }
    
    func testFetchFailureCryptos() {
        
        interactor.networkService = networkService
        interactor.output = output
        
        interactor.fetchCryptos()
        
        XCTAssertNotNil(output.catchError)
    }
    
    func testSearchForSuccessCrypto() {
        
        let searchCryptos = CryptoPriceInfoResponse(status: Status(timestamp: nil, errorCode: 0, elapsed: nil, creditCount: nil, totalCount: nil), data: ["1" : CryptoPriceInfo(id: 1, name: "Baz", symbol: "Bar", slug: "Foo", numMarketPairs: nil, dateAdded: nil, tags: nil, isActive: nil, cmcRank: nil, isFiat: nil, lastUpdated: nil, quote: nil)])
        networkService.cryptoSearchInfo = searchCryptos
        
        interactor.networkService = networkService
        interactor.output = output
        
        interactor.searchForCryptos(text: "Bit")
        
        XCTAssertEqual(output.cryptoSearchInfoResult?.slug, "Foo")
        XCTAssertNotNil(output.cryptoSearchInfoResult)
        
    }
    
    func testSearchForNotFoundCrypto() {
        
        let searchCryptos = CryptoPriceInfoResponse(status: Status(timestamp: nil, errorCode: 400, elapsed: nil, creditCount: nil, totalCount: nil), data: ["1" : CryptoPriceInfo(id: 1, name: "Baz", symbol: "Bar", slug: "Foo", numMarketPairs: nil, dateAdded: nil, tags: nil, isActive: nil, cmcRank: nil, isFiat: nil, lastUpdated: nil, quote: nil)])
        networkService.cryptoSearchInfo = searchCryptos
        
        interactor.networkService = networkService
        interactor.output = output
        
        interactor.searchForCryptos(text: "Bit")
        
        XCTAssertEqual(output.notFound, 1)
        
    }
    
    func testSearchForFailureCrypto() {
        
        interactor.networkService = networkService
        interactor.output = output
        
        interactor.searchForCryptos(text: "Bit")
        
        XCTAssertNotNil(output.catchError)
    }
    
}
