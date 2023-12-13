//
//  IntroView.swift
//  ExpenseTracker
//
//  Created by Shail Patel on 3/12/23.
//
import SwiftUI

struct IntroView: View {
    @State private var isActive = false

    var body: some View {
        VStack {
            if isActive {
                ContentView()
            } else {
                Text("Nina: Your personal expense tracker!")
                    .font(.custom("Helvetica-BoldItalic", size: 36)) // Bold Italic Helvetica font
                    .foregroundColor(.black) // Black font color
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.peach)
                    .edgesIgnoringSafeArea(.all)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                self.isActive = true
                            }
                        }
                    }
            }
        }
    }
}

// Define an extension for the peach color
extension Color {
    static let peach = Color(red: 1.0, green: 224 / 255, blue: 178 / 255)
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}

