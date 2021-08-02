//
//  Crypto2.swift
//  CryptoMadTracker
//
//  Created by talgar osmonov on 27/7/21.
//

import Foundation

// MARK: - Welcome
struct CryptoResponse: Codable {
    let status: Status?
    let data: [Crypto]?
}

// MARK: - Datum
struct Crypto: Codable {
    let id: Int?
    let name, symbol, slug: String?
    let numMarketPairs: Int?
    let dateAdded: String?
    let tags: [String]?
    let maxSupply, circulatingSupply, totalSupply: Double?
    let cmcRank: Int?
    let lastUpdated: String?
    let quote: Quote?

    enum CodingKeys: String, CodingKey {
        case id, name, symbol, slug
        case numMarketPairs = "num_market_pairs"
        case dateAdded = "date_added"
        case tags
        case maxSupply = "max_supply"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case cmcRank = "cmc_rank"
        case lastUpdated = "last_updated"
        case quote
    }
}

// MARK: - Quote
struct Quote: Codable {
    let usd: Usd?

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}

// MARK: - Usd
struct Usd: Codable {
    let price, volume24H, percentChange1H, percentChange24H: Double?
    let percentChange7D, percentChange30D, percentChange60D, percentChange90D: Double?
    let marketCap: Double?
    let lastUpdated: String?

    enum CodingKeys: String, CodingKey {
        case price
        case volume24H = "volume_24h"
        case percentChange1H = "percent_change_1h"
        case percentChange24H = "percent_change_24h"
        case percentChange7D = "percent_change_7d"
        case percentChange30D = "percent_change_30d"
        case percentChange60D = "percent_change_60d"
        case percentChange90D = "percent_change_90d"
        case marketCap = "market_cap"
        case lastUpdated = "last_updated"
    }
}

// MARK: - Status
struct Status: Codable {
    let timestamp: String?
    let errorCode: Int?
    let elapsed, creditCount: Int?
    let totalCount: Int?

    enum CodingKeys: String, CodingKey {
        case timestamp
        case errorCode = "error_code"
        case elapsed
        case creditCount = "credit_count"
        case totalCount = "total_count"
    }
}
