//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Shail Patel on 3/12/23.
//
import SwiftUI

struct ContentView: View {
    @State private var expenses: [Expense] = [] {
        didSet {
            saveExpenses()
        }
    }
    @State private var showingAddExpense = false

    init() {
        loadExpenses()
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses) { expense in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(expense.title)
                                .font(.headline)
                            Text("$\(expense.amount, specifier: "%.2f")")
                        }
                        Spacer()
                        Text(expense.date, format: .dateTime.day().month().year())
                    }
                }
                .onDelete(perform: removeExpenses)
            }
            .navigationTitle("Expenses")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink(destination: MonthlyExpensesView(expenses: expenses)) {
                        Text("Monthly Totals")
                    }
                    Button(action: { self.showingAddExpense = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddExpenseView(expenses: $expenses)
            }
        }
    }

    func removeExpenses(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets)
    }

    func saveExpenses() {
        if let encoded = try? JSONEncoder().encode(expenses) {
            UserDefaults.standard.set(encoded, forKey: "Expenses")
        }
    }

    func loadExpenses() {
        if let savedExpenses = UserDefaults.standard.object(forKey: "Expenses") as? Data {
            if let decodedExpenses = try? JSONDecoder().decode([Expense].self, from: savedExpenses) {
                self.expenses = decodedExpenses
                return
            }
        }
        self.expenses = []
    }
}

struct AddExpenseView: View {
    @Binding var expenses: [Expense]
    @State private var title = ""
    @State private var amount = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $title)
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)

                Button("Add Expense") {
                    if let actualAmount = Double(amount) {
                        let newExpense = Expense(title: title, amount: actualAmount, date: Date())
                        expenses.append(newExpense)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationTitle("Add Expense")
            .background(Color.gray)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
