//
//  NetworkService2.swift
//  CryptoMadTracker
//
//  Created by talgar osmonov on 27/7/21.
//

import Foundation

class NetworkService {
    
    private let allowedDiskSize = 100 * 1024 * 1024
    private lazy var cache: URLCache = {
        return URLCache(memoryCapacity: allowedDiskSize, diskCapacity: allowedDiskSize, diskPath: "networkCache")
    }()
    
    private func session() -> URLSession {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.requestCachePolicy = .returnCacheDataElseLoad
        sessionConfiguration.urlCache = cache
        sessionConfiguration.timeoutIntervalForRequest = 3
        sessionConfiguration.httpMaximumConnectionsPerHost = 5
        return URLSession(configuration: sessionConfiguration)
    }
    
    func baseRequest<T: Codable>(url: String, completion: @escaping(Result<T, Error>) -> Void) {
        
        guard let downloadUrl = URL(string: url) else {
            DispatchQueue.main.async {
                completion(.failure(NetworkError.wrongUrl))
            }
            return
        }
        
        let urlRequest = URLRequest(url: downloadUrl)
        
        if let cachedData = self.cache.cachedResponse(for: urlRequest) {
            
            print("Cached data in bytes:", cachedData.data)
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: cachedData.data)
                DispatchQueue.main.async {
                    completion(.success(decodedObject))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        } else {
            
            session().dataTask(with: urlRequest) { (data, response, error) in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data, let response = response else {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.dataIsNil))
                    }
                    return
                }
                
                let cachedData = CachedURLResponse(response: response, data: data)
                self.cache.storeCachedResponse(cachedData, for: urlRequest)
                
                do {
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(decodedObject))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
                
            }.resume()
        }
    }
}

