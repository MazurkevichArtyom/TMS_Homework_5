//
//  Income.swift
//  HW5
//
//  Created by Artem Mazurkevich on 22.05.2022.
//

import Foundation
import RealmSwift

class Income : Object {
    @Persisted(primaryKey: true) var id: String = "income_key"
    @Persisted var incomeValue: Decimal128
    
    convenience init(initialIncome: Decimal) {
        self.init()
        self.incomeValue = Decimal128(value: initialIncome)
    }
    
    func addIncome(price: Decimal) {
        incomeValue += Decimal128(value: price)
    }
}
