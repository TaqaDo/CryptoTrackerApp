//
//  AppDependencies.swift
//  CryptoMadTracker
//
//  Created by talgar osmonov on 28/7/21.
//

import Foundation
import Swinject


class AppDependencies {
    
    static let shared = AppDependencies()
    let container = Container()
    
    private init() {
        setupDependencies()
    }
    
    private func setupDependencies() {
        container.register(CryptoNetworkProtocol.self) { r in
            return NetworkService()
        }
        
        container.register(CryptoStorageProtocol.self) { r in
            return CryptoStorage()
        }
    }
}
