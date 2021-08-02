//
//  URLFactory2.swift
//  CryptoMadTracker
//
//  Created by talgar osmonov on 27/7/21.
//

import Foundation

struct RequestParams {
    let limit: Int
    let start: Int
}

enum URLFactory {
    private static let apiKey = "d51ebd0e-a5f3-4a8b-94b8-18d03c52cb6c"
    private static var baseUrl: URL {
        baseUrlComponets.url!
    }
    
    private static let baseUrlComponets: URLComponents = {
        let url = URL(string: "https://pro-api.coinmarketcap.com/v1/")!
        let queryItems = URLQueryItem(name: "CMC_PRO_API_KEY", value: URLFactory.apiKey)
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = [queryItems]
        return urlComponents
    }()

    static func crypto(params: RequestParams) -> String {
        let params = [URLQueryItem(name: "limit", value: "\(params.limit)"),
                      URLQueryItem(name: "start", value: "\(params.start)")]
        var urlComponents = baseUrlComponets
        urlComponents.queryItems?.append(contentsOf: params)
        return urlComponents.url!.appendingPathComponent("cryptocurrency/listings/latest").absoluteString
    }

    static func cryptoInfo(slug: String) -> String {
        let params = [URLQueryItem(name: "slug", value: slug)]
        var urlComponents = baseUrlComponets
        urlComponents.queryItems?.append(contentsOf: params)
        return urlComponents.url!.appendingPathComponent("cryptocurrency/info").absoluteString
    }

    static func cryptoPriceInfo(slug: String) -> String {
        let params = [URLQueryItem(name: "slug", value: slug)]
        var urlComponents = baseUrlComponets
        urlComponents.queryItems?.append(contentsOf: params)
        return urlComponents.url!.appendingPathComponent("cryptocurrency/quotes/latest").absoluteString
    }
}
