//
//  StoreManager.swift
//  HW5
//
//  Created by Artem Mazurkevich on 06.01.2022.
//

import Foundation

class StoreManager {
    static let shared = StoreManager()
    
    private(set) var availableProducts: [Product] = [Product]()
    private(set) var income: Decimal = 0
    private var autoIncrementKey: Int = 0
    
    private let defaultNames: [String] = ["Apple", "Tangerine", "Lemon", "Mango", "Pear"]
    private let defaultEmojis: [String] = ["🍏", "🍊", "🍋", "🥭", "🍐"]
    
    private let defaultDescriptions: [String] = ["Sweet", "Sour", "Tasteless", "Viscous"]
    
    func buyProducts(products: Product...) {
        for var product in products {
            product.id = autoIncrementKey
            availableProducts.append(product)
            autoIncrementKey += 1
        }
    }
    
    func sellProducts(products: Product...) {
        for product in products {
            if availableProducts.contains(product) {
                income += product.price
                availableProducts = availableProducts.filter { aProduct in
                    return aProduct != product
                }
            }
        }
    }
    
    func generateRandomProduct() -> Product {
        let randomIndex = Int.random(in: 0..<defaultNames.count)
        let randomName = defaultNames[randomIndex]
        let randomEmoji = defaultEmojis[randomIndex]
        let randomDescription = defaultDescriptions[Int.random(in: 0..<defaultDescriptions.count)]
        let randomPrice = Int.random(in: 2...10)
        
        return Product(name: randomName, emoji: randomEmoji, description: randomDescription, price: Decimal(randomPrice))
    }
}
