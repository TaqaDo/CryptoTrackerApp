//
//  RealmCrypto.swift
//  CryptoMadTracker
//
//  Created by talgar osmonov on 28/7/21.
//

import Foundation
import RealmSwift

class RealmCrypto: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var symbol: String = ""
    @objc dynamic var slug: String = ""
    @objc dynamic var price: Double = 0.0
    @objc dynamic var percentChange: Double = 0.0
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
