//
//  Expense.swift
//  ExpenseTracker
//
//  Created by Shail Patel on 3/12/23.
//
import Foundation

struct Expense: Identifiable, Codable{
    var id = UUID()
    var title: String
    var amount: Double
    var date: Date
    
    var monthYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
}
