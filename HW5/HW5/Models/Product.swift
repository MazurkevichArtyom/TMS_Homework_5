//
//  Product.swift
//  HW5
//
//  Created by Artem Mazurkevich on 06.01.2022.
//

import Foundation

struct Product : Equatable {
    var id: Int = -1
    var name: String
    var emoji: String
    var description: String
    var price: Decimal
    
    func getStringValue() -> String {
        return "\(emoji) \(name) (\(description)) - \(price)$"
    }
    
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func !=(lhs: Product, rhs: Product) -> Bool {
        return lhs.id != rhs.id
    }
}
