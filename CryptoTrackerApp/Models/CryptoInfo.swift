//
//  CryptoInfo2.swift
//  CryptoMadTracker
//
//  Created by talgar osmonov on 27/7/21.
//

import Foundation

// MARK: - Welcome
struct CryptoInfoResponse: Codable {
    let status: Status?
    let data: [String : CryptoInfo]?
}


// MARK: - Btc
struct CryptoInfo: Codable {
    let id: Int?
    let name, symbol, category, btcDescription: String?
    let slug: String?
    let logo: String?
    let subreddit, notice: String?
    let tags: [String]?
    let tagNames: [String]?
    let urls: Urls?
    let dateAdded, twitterUsername: String?
    let isHidden: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, symbol, category
        case btcDescription = "description"
        case slug, logo, subreddit, notice
        case tags
        case tagNames = "tag-names"
        case urls
        case dateAdded = "date_added"
        case twitterUsername = "twitter_username"
        case isHidden = "is_hidden"
    }
}

enum TagGroup: String, Codable {
    case consensusAlgorithm = "CONSENSUS_ALGORITHM"
    case other = "OTHER"
    case property = "PROPERTY"
}

// MARK: - Urls
struct Urls: Codable {
    let website: [String]?
    let twitter: [String]?
    let messageBoard: [String]?
    let chat: [String]?
    let explorer, reddit: [String]?
    let technicalDoc: [String]?
    let sourceCode: [String]?
    let announcement: [String]?

    enum CodingKeys: String, CodingKey {
        case website, twitter
        case messageBoard = "message_board"
        case chat, explorer, reddit
        case technicalDoc = "technical_doc"
        case sourceCode = "source_code"
        case announcement
    }
}


