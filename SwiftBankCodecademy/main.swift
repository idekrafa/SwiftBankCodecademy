//
//  main.swift
//  SwiftBankCodecademy
//
//  Created by Rafael Ribeiro on 5/27/25.
//

import Foundation

struct SwiftBank {
    private let password: String
    init(initialPassword: String, initialDeposit: Double) {
        self.password = initialPassword
        makeDeposit(ofAmount: initialDeposit)
    }
    
    // Password checker -> This will verify if the user inputed the write password
    private func isValid(_ enteredPassword: String) -> Bool {
        if enteredPassword == password {
            return true
        } else {
            return false
        }
    }
    
    // Variable balance -> This will represent the balance in the users account
    private var balance: Double = 0 {
        didSet {
            if balance < 100 { // This will check if the balance is under 100, if it is, the func will be called and the message will be displayed to the user
                displayLowBalanceMessage()
            }
        }
    }
    
    // Type property to add a bonus -> This will add a bonus everytime the user deposits an amount to their account
    static let depositBonusRate = 0.01
    
    // This method will calculate the total deposit amount with bonus
    private func finalDepositWithBonus(fromInitialDeposit deposit: Double) -> Double {
        return deposit + (deposit * SwiftBank.depositBonusRate)
    }
    
    // This method will be used to make a deposit
    
    mutating func makeDeposit(ofAmount depositAmount: Double) {
        let depositWithBonus = finalDepositWithBonus(fromInitialDeposit: depositAmount)
        if depositAmount > 0 {
            balance += depositWithBonus
            print("Making a deposit of $\(depositAmount) with a bonus rate. The final amount deposited is $\(depositWithBonus)")
        } else {
            print("Error: The deposit amount has to me grater than 0.")
        }
    }
    // This method will check the balance
    
    func displayBalance(usingPassword password: String) {
        if isValid(password) == false {
            print("Error: Invalid password. Cannot retrieve balance.")
            return
        } else {
            print("Your current balance is $\(balance)")
        }
    }
    // This method will withdraw the amount from the users balance
    
    mutating func makeWithdraw(ofAmount withdrawAmount: Double, usingPassword password: String) {
        if isValid(password) == false {
            print("Error: Invalid password. Cannot make withdraw.")
            return
        } else {
            if balance >= withdrawAmount {
            balance -= withdrawAmount
            print("Making a $\(withdrawAmount) withdraw.")
            } else {
                print("Error: your balance is lower than the amount you're trying to withdraw")
            }
        }
    }
    //This method displays a warning whenever the user balance is below $100
    
    private func displayLowBalanceMessage() {
        print("Alert: Your balance is under $100")
    }
}

var myAccount = SwiftBank(initialPassword: "123456", initialDeposit: 500)

// This deposits $50
myAccount.makeDeposit(ofAmount: 50)

// This will make a $10 withdraw
myAccount.makeWithdraw(ofAmount: 10, usingPassword: "123456")

// This will display the user balance
myAccount.displayBalance(usingPassword: "123456")



