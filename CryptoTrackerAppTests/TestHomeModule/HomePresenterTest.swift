//
//  HomePresenterTest.swift
//  CryptoMadTrackerTests
//
//  Created by talgar osmonov on 29/7/21.
//

import XCTest
@testable import CryptoMadTracker


class MockRouter: HomeRouterInput {
    
    var navigateToSavedResult: Int?
    var showNoConnectionAllertResult: Int?
    var showSaveDBErrorAllertResult: Int?
    
    func navigateToSaved() {
        navigateToSavedResult = 1
    }
    
    func showNoConnectionAllert(completion: @escaping () -> Void) {
        showNoConnectionAllertResult = 1
    }
    
    func showSaveDBErrorAllert() {
        showSaveDBErrorAllertResult = 1
    }
}



class MockInteractor: HomeInteractorInput {
    
    var cryptosResult: CryptoResponse!
    var searchResult: CryptoPriceInfoResponse!
    
    func fetchCryptos() {
        cryptosResult = CryptoResponse(status: nil, data: [Crypto(id: 1, name: "Baz", symbol: "Bar", slug: "Foo", numMarketPairs: nil, dateAdded: nil, tags: nil, maxSupply: nil, circulatingSupply: nil, totalSupply: nil, cmcRank: nil, lastUpdated: nil, quote: nil)])
        
    }
    
    func searchForCryptos(text: String) {
        searchResult = CryptoPriceInfoResponse(status: Status(timestamp: nil, errorCode: 0, elapsed: nil, creditCount: nil, totalCount: nil), data: ["1" : CryptoPriceInfo(id: 1, name: "Baz", symbol: text, slug: "Foo", numMarketPairs: nil, dateAdded: nil, tags: nil, isActive: nil, cmcRank: nil, isFiat: nil, lastUpdated: nil, quote: nil)])
    }
}



class HomePresenterTest: XCTestCase {
    
    var presenter: HomePresenter!
    var router: MockRouter!
    var interactor: MockInteractor!
    
    override func setUpWithError() throws {
        presenter = HomePresenter()
        router = MockRouter()
        interactor = MockInteractor()
        
    }
    
    override func tearDownWithError() throws {
        presenter = nil
        router = nil
        interactor = nil
    }
    
    func testFetchCryptos() {
        presenter.interactor = interactor
        presenter.fetchCryptos()
        
        XCTAssertEqual(interactor.cryptosResult.data?.first?.name, "Baz")
    }
    
    func testSearchCryptos() {
        presenter.interactor = interactor
        presenter.searchForCryptos(text: "Bit")
        
        XCTAssertEqual(interactor.searchResult.data?.values.first?.symbol, "Bit")
    }
    
    func testNavigateToSaved() {
        presenter.router = router
        presenter.navigateToSaved()
        
        XCTAssertEqual(router.navigateToSavedResult, 1)
    }
    
    func testShowNoConnectionAllert() {
        presenter.router = router
        presenter.showNoConnectionAllert()
        
        XCTAssertEqual(router.showNoConnectionAllertResult, 1)
    }
    
    func testShowSaveDBErrorAllert() {
        presenter.router = router
        presenter.showSaveDBErrorAllert()
        
        XCTAssertEqual(router.showSaveDBErrorAllertResult, 1)
    }
    
}
