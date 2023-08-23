//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Karlyn Sanders on 8/14/23.
//

import SwiftUI

    struct ContentView: View {
        @State private var showingScore = false
        @State private var scoreTitle = ""
        @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
        @State private var correctAnswer = Int.random(in: 0...2)
        @State private var userScore = 0
        
        
        var body: some View {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack(spacing:30){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.white)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) {number in
                        Button {
                            flagTapped(number)
                        } label: {
                            ImageView(image: countries[number])
                        }
                    }
                }
            }
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(userScore)")
            }
        }
        func flagTapped(_ number: Int) {
            if number == correctAnswer{
                scoreTitle = "Correct! \(countries[number])"
                userScore+=1
            } else {
                scoreTitle = "Wrong. That's the flag of \(countries[number])"
            }
            showingScore = true
            
        }
        func askQuestion() {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    }
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }


struct ImageView: View {
    
    var image: String
    
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct flagViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline.weight(.heavy))
            .foregroundColor(.blue)
    }
}
