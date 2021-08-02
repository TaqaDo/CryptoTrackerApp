//
//  HomeRouterTest.swift
//  CryptoMadTrackerTests
//
//  Created by talgar osmonov on 29/7/21.
//

import XCTest
@testable import CryptoMadTracker


class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}


class HomeRouterTest: XCTestCase {
    
    var router: HomeRouter!
    var view: UIViewController!
    var navController: MockNavigationController!
    
    override func setUpWithError() throws {
        router = HomeRouter()
        view = UIViewController()
        navController = MockNavigationController()
    }
    
    override func tearDownWithError() throws {
        view = nil
        router = nil
        navController = nil
    }
    
}
