//
//  CryptoPriceInfo2.swift
//  CryptoMadTracker
//
//  Created by talgar osmonov on 27/7/21.
//

import Foundation

// MARK: - Welcome
struct CryptoPriceInfoResponse: Codable {
    let status: Status?
    let data: [String : CryptoPriceInfo]?
}

// MARK: - The1
struct CryptoPriceInfo: Codable {
    let id: Int?
    let name, symbol, slug: String?
    let numMarketPairs: Int?
    let dateAdded: String?
    let tags: [String]?
    let isActive: Int?
    let cmcRank, isFiat: Int?
    let lastUpdated: String?
    let quote: Quote?

    enum CodingKeys: String, CodingKey {
        case id, name, symbol, slug
        case numMarketPairs = "num_market_pairs"
        case dateAdded = "date_added"
        case tags
        case isActive = "is_active"
        case cmcRank = "cmc_rank"
        case isFiat = "is_fiat"
        case lastUpdated = "last_updated"
        case quote
    }
}

