//
//  StoreManager.swift
//  HW5
//
//  Created by Artem Mazurkevich on 06.01.2022.
//

import Foundation
import RealmSwift

class StoreManager {
    static let shared = StoreManager()
    
    private(set) var availableProducts: [Product] = [Product]()
    var income: Decimal {
        get {
            incomeModel.incomeValue.decimalValue
        }
    }
    
    private var incomeModel = Income(initialIncome: 0)
    
    private let defaultNames: [String] = ["Apple", "Tangerine", "Lemon", "Mango", "Pear"]
    private let defaultEmojis: [String] = ["🍏", "🍊", "🍋", "🥭", "🍐"]
    
    private let defaultDescriptions: [String] = ["Sweet", "Sour", "Tasteless", "Viscous"]
    
    private init()
    {
        let realm = try! Realm()
        let objects = realm.objects(Product.self)
        availableProducts = Array(objects)
        
        if let incomeModel = realm.objects(Income.self).first {
            self.incomeModel = incomeModel
        }
    }
    
    func buyProducts(products: Product...) {
        for product in products {
            let realm = try! Realm()
            try? realm.write {
                realm.add(product)
                availableProducts.append(product)
            }
        }
    }
    
    func sellProducts(products: Product...) {
        for product in products {
            if availableProducts.contains(product) {
                let realm = try! Realm()
                try? realm.write {
                    incomeModel.addIncome(price: product.price.decimalValue)
                    availableProducts = availableProducts.filter { aProduct in
                        return aProduct != product
                    }
                    realm.add(incomeModel, update: .all)
                    realm.delete(product)
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
