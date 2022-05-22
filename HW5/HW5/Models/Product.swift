//
//  Product.swift
//  HW5
//
//  Created by Artem Mazurkevich on 06.01.2022.
//

import Foundation
import RealmSwift

class Product : Object {
    @Persisted var id: String
    @Persisted var name: String
    @Persisted var emoji: String
    @Persisted var productDescription: String
    @Persisted var price: Decimal128
    
    convenience init(name: String, emoji: String, description: String, price: Decimal) {
        self.init()
        id = UUID().uuidString
        self.emoji = emoji
        self.productDescription = description
        self.price = Decimal128(value: price)
    }
    
    func getStringValue() -> String {
        return "\(emoji) \(name) (\(productDescription)) - \(price)$"
    }
    
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func !=(lhs: Product, rhs: Product) -> Bool {
        return lhs.id != rhs.id
    }
}
