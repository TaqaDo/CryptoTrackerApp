//
//  SavedInteractorTest.swift
//  CryptoMadTrackerTests
//
//  Created by talgar osmonov on 29/7/21.
//

import XCTest
@testable import CryptoMadTracker

class MockSavedOutput: SavedInteractorOutput {
    
    var cryptoResult: [RealmCrypto]!
    var catchError: Error!
    
    func fetchCryptosFromDBResult(data: [RealmCrypto]) {
        cryptoResult = data
    }
    
    func fetchCryptoFromDBError(error: Error) {
        catchError = error
    }
    
}

class MockDatabseService: CryptoStorageProtocol {
    
    var cryptos: [RealmCrypto]!
    
    func saveCryptos(data: [RealmCrypto], completion: @escaping (CryptoStorageResult)) {
        if data != nil {
            completion(.success(nil))
        } else {
            let error = NSError(domain: "", code: 400, userInfo: nil)
            completion(.failure(error))
        }
    }
    
    func fetchCryptos(completion: @escaping (CryptoStorageResult)) {
        if let cryptos = cryptos {
            completion(.success(cryptos))
        } else {
            let error = NSError(domain: "", code: 400, userInfo: nil)
            completion(.failure(error))
        }
    }
    
}



class SavedInteractorTest: XCTestCase {
    
    var output: MockSavedOutput!
    var interactor: SavedInteractor!
    var databseService: MockDatabseService!
    
    override func setUpWithError() throws {
        output = MockSavedOutput()
        interactor = SavedInteractor()
        databseService = MockDatabseService()
    }
    
    override func tearDownWithError() throws {
        output = nil
        interactor = nil
        databseService = nil
    }
    
    func testFetchSuccessCryptos() {
        let data = RealmCrypto()
        data.id = 1
        data.name = "Baz"
        data.slug = "Bar"
        data.symbol = "Foo"
        let cryptos = [data]
        databseService.cryptos = cryptos
        
        interactor.databaseService = databseService
        interactor.output = output
        
        interactor.fetchCryptosFromDB()
        
        XCTAssertEqual(output.cryptoResult.first?.name, "Baz")
        XCTAssertNotNil(output.cryptoResult)
    }
    
    func testFetchFailureCryptos() {
        
        interactor.databaseService = databseService
        interactor.output = output

        interactor.fetchCryptosFromDB()

        XCTAssertNotNil(output.catchError)
    }
    
}

