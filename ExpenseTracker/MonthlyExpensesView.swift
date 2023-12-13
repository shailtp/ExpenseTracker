//
//  MonthlyExpensesView.swift
//  ExpenseTracker
//
//  Created by Shail Patel on 3/12/23.
//
import SwiftUI

struct MonthlyExpensesView: View {
    let expenses: [Expense]

    private var totalPerMonth: [(month: String, total: Double)] {
        let grouped = Dictionary(grouping: expenses, by: { $0.monthYear })
        return grouped.map { month, expenses in
            (month, expenses.reduce(0) { $0 + $1.amount })
        }.sorted { $0.month < $1.month }
    }

    var body: some View {
        List(totalPerMonth, id: \.month) { month, total in
            HStack {
                Text(month)
                Spacer()
                Text("$\(total, specifier: "%.2f")")
                    .foregroundColor(.green)
            }
        }
        .navigationTitle("Monthly Totals")
    }
}

struct MonthlyExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyExpensesView(expenses: [])
    }
}
