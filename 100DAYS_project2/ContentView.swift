//
//  ContentView.swift
//  100DAYS_project2
//
//  Created by Taras Kyparenko on 1/4/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var questionCounter = 1
    @State private var showingResult = false
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var selectedFlag = -1
    @State private var correctAnswerCount = 0
    @State private var uncorrectAnswerCount = 0
    @State private var tappedCount = 0
    {
        didSet {
            if tappedCount >= 8 {
                showingResult = true
                tappedCount = 0
            }
        }
    }
    
      static let allCountries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var countries = allCountries.shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            //            RadialGradient(stops: [
            //                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
            //                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)], center: .top, startRadius: 200, endRadius: 800)
            LinearGradient(gradient: Gradient(colors: [.clear, .cyan]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.blue)
                VStack(spacing: 15){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                        //                            .foregroundColor(.indigo)
                            .font(.largeTitle.weight(.semibold))
                        
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .shadow(radius: 10)
                                .rotation3DEffect(.degrees((number == selectedFlag) ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                                .opacity(selectedFlag == -1 || selectedFlag == number ? 1 : 0.25)
                                .blur(radius: selectedFlag == -1 || selectedFlag == number ? 0 : 3)
//                                .saturation(selectedFlag == -1 || selectedFlag == number ? 1 : 0)
//                                .scaleEffect(selectedFlag == -1 || selectedFlag == number ? 1 : 0.75)
//                                .animation(.default, value: selectedFlag)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(tappedCount)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        }
        .alert("GAME OVER", isPresented: $showingResult) {
            Button("Start again", action: newGame)
        } message: {
            Text("""
\(scoreTitle)
Your correct aswer \(correctAnswerCount)
Yor falls \(uncorrectAnswerCount)
""")
        }
    }
    
    func flagTapped(_ number: Int) -> Int {
        selectedFlag = number
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            correctAnswerCount += 1
            tappedCount += 1
        } else {
            let needsThe = ["UK", "US"]
            let thairAnswer = countries[number]
            if needsThe.contains(thairAnswer) {
                scoreTitle = "Wrong! That's the flag of the \(countries[number])"
            } else {
                scoreTitle = "Wrong! That's the flag of \(countries[number])"
            }
            uncorrectAnswerCount += 1
            if tappedCount > 0 {
                tappedCount -= 1
            }
            
        }
        showingScore = true
        return tappedCount
    }
    
    func askQuestion() {
        countries.remove(at: correctAnswer)
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCounter += 1
        selectedFlag = -1
    }
    
    func newGame() {
        questionCounter = 0
        tappedCount = 0
        countries = ContentView.allCountries
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
