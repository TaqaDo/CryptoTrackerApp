//
//  CryptoStorage.swift
//  CryptoMadTracker
//
//  Created by talgar osmonov on 28/7/21.
//

import Foundation
import RealmSwift


protocol CryptoStorageProtocol {
    func saveCryptos(data: [RealmCrypto], completion: @escaping(CryptoStorageResult))
    func fetchCryptos(completion: @escaping(CryptoStorageResult))
}


class CryptoStorage {
    private let queue = DispatchQueue(label: "cryptoStorageQueue")
}

extension CryptoStorage: CryptoStorageProtocol {
    func saveCryptos(data: [RealmCrypto], completion: @escaping (CryptoStorageResult)) {
        queue.async {
            let realm = try? Realm()
            do {
                try realm?.write {
                    realm?.deleteAll()
                    realm?.add(data, update: .all)
                }
                completion(.success(nil))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    
    func fetchCryptos(completion: @escaping (CryptoStorageResult)) {
        queue.async {
            let realm = try? Realm()
            if let realmLists = realm?.objects(RealmCrypto.self) {
                let lists = realmLists.toArray(ofType: RealmCrypto.self)
                completion(.success(lists))
            } else {
                completion(.failure(StorageError.cannotFetch))
            }
        }
    }
}
