//
//  main.swift
//  Less7
//
//  Created by Таганов Юрий on 11.12.2021.
//

import Foundation

// MARK: - Enums

enum CreditCardOperationError: Error {
    case insufficientFunds (moneyNeeded: Double)
    case frozenBalance
}

// MARK: - Structs

struct thing {
    var price: Double
}

// MARK: - Classes

class CreditCardOperation {
    let limit: Double = -10000
    var balance: Double = 0
    var cardIsBlocked = false

    func buySomethig(thing: thing)throws {
        guard cardIsBlocked == false else {
            throw CreditCardOperationError.frozenBalance
        }
        guard thing.price <= (-limit + self.balance) else {
            if balance < 0 {
                throw CreditCardOperationError.insufficientFunds(moneyNeeded: thing.price + limit + balance)
            } else {
                throw CreditCardOperationError.insufficientFunds(moneyNeeded: thing.price + limit - balance)
            }
        }
        balance = self.balance - thing.price
    }

    func depositeMoney (someMoney: Double) {
        balance = self.balance + someMoney
    }

    func printBalance() {
        print ("Баланс \(balance) руб.")
    }

    func changeCardState(cardIsBlocked: Bool) {
        switch cardIsBlocked {
        case true:
            self.cardIsBlocked = true
        case false:
            self.cardIsBlocked = false
        }
    }
}

// MARK: - Extension CarProtocol

extension CreditCardOperationError: CustomStringConvertible {
    var description: String {
        switch self {
        case .insufficientFunds(let moneyNeeded): return "На карте недостаточно денег для проведения этой операции. Необходимая сумма для проведения операции: \(moneyNeeded) руб., на Вашем счете: \(operation.balance) руб."
        case .frozenBalance: return "Ваш баланс заморожен. Для получения дополнительной информации, пожалуйста, свяжитесь с Банком."
        }
    }
}

// MARK: - Initialization

let operation = CreditCardOperation()
do {
    try operation.buySomethig(thing: .init(price: 200))
} catch let error as CreditCardOperationError {
    print(error.description)
}
operation.printBalance()
operation.depositeMoney(someMoney: 3000)
operation.printBalance()
do {
    try operation.buySomethig(thing: .init(price: 20000))
} catch let error as CreditCardOperationError {
    print(error.description)
}
operation.printBalance()
do {
    try operation.buySomethig(thing: .init(price: 23000))
} catch let error as CreditCardOperationError {
    print(error.description)
}
operation.printBalance()

operation.changeCardState(cardIsBlocked: true)

do {
    try operation.buySomethig(thing: .init(price: 100))
} catch let error as CreditCardOperationError {
    print(error.description)
}
