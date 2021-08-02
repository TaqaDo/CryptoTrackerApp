//
//  Typealias.swift
//  CryptoMadTracker
//
//  Created by talgar osmonov on 27/7/21.
//

import RealmSwift

typealias CryptoResult = (Result<CryptoResponse, Error>) -> Void
typealias CryptoInfoResult = (Result<CryptoInfoResponse, Error>) -> Void
typealias CryptoPriceInfoResult = (Result<CryptoPriceInfoResponse, Error>) -> Void
typealias CryptoStorageResult = (Result<[RealmCrypto]?, Error>) -> Void
