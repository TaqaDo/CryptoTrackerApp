//
//  SavedPresenterTest.swift
//  CryptoMadTrackerTests
//
//  Created by talgar osmonov on 29/7/21.
//

//
//  HomePresenterTest.swift
//  CryptoMadTrackerTests
//
//  Created by talgar osmonov on 29/7/21.
//

import XCTest
@testable import CryptoMadTracker


class MockSavedRouter: SavedRouterInput {
    
}



class MockSavedInteractor: SavedInteractorInput {
    
    var cryptosResult: [RealmCrypto]!
    
    func fetchCryptosFromDB() {
        let data = RealmCrypto()
        data.id = 1
        data.name = "Baz"
        data.slug = "Bar"
        data.symbol = "Foo"
        cryptosResult = [data]
    }
}



class SavedPresenterTest: XCTestCase {
    
    var presenter: SavedPresenter!
    var router: MockSavedRouter!
    var interactor: MockSavedInteractor!
    
    override func setUpWithError() throws {
        presenter = SavedPresenter()
        router = MockSavedRouter()
        interactor = MockSavedInteractor()
        
    }
    
    override func tearDownWithError() throws {
        presenter = nil
        router = nil
        interactor = nil
    }
    
    func testFetchCryptos() {
        presenter.interactor = interactor
        presenter.fetchCryptosFromDB()
        
        XCTAssertEqual(interactor.cryptosResult.first?.name, "Baz")
    }
    
}

