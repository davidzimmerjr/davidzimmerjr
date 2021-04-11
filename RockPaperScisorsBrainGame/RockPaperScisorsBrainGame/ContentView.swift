// https://www.hackingwithswift.com/guide/ios-swiftui/2/3/challenge
//  ContentView.swift
//  RockPaperScisorsBrainGame
//
//  Created by David Zimmer on 4/7/21.
//

import SwiftUI

struct ContentView: View {
//    @State var winningStatus = 0
//    @State var compPieceSelection = 0
    @State var userPieceSelection = 0 // gets set with buttons
    @State var userScore = 0
    
    @State var timeRemaining = 5
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var alertShowing = false
//    let alertTitle = "You got \(userScore) right"
    
    var winningStatuses = ["beats", "loses to"]
    var pieceSelections = ["Rock", "Paper", "Scissors"]
    
    @State private var randWinStatus = Int.random(in: 0..<2)
    @State private var randPSelect = Int.random(in: 0..<3)
    
    var body: some View {
        VStack {
            Text("00:\(String(format: "%02d", timeRemaining))")
                .onChange(of: timeRemaining) { value in
                timesUp(timeRemaining)
                print(value)
                }
//            Text(timerText(timeRemaining))
            Spacer()
            Text("Select what \(winningStatuses[randWinStatus]) \(pieceSelections[randPSelect]):")
                .padding()
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
//            Spacer()
            
            VStack {
                ForEach(0..<3) {number in
                    Button(pieceSelections[number]) {
                        buttonTapped(number)
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.black)
                    .clipShape(Capsule())
                }
            }
            .padding()
            Spacer()
            Text("Score: \(userScore)")
        }.onReceive(timer) { time in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
        }
        .alert(isPresented: $alertShowing) {
            Alert(title: Text("Times Up!"), message: Text("Your score is \(userScore)"), dismissButton: Alert.Button.default(Text("Play A Round?"), action: {resetGame()}))
        }
    }
    
    func buttonTapped(_ number: Int) {
        if randWinStatus == 0 {
            print("\(winningStatuses[randWinStatus]) \(pieceSelections[randPSelect])")
            let compare = (randPSelect + 1) == 3 ? 0 : (randPSelect + 1)
            print("\(compare)")
            if pieceSelections[compare] == pieceSelections[number] {
                userScore += 1
            } else {
                userScore -= 1
            }
        } else {
            print("\(winningStatuses[randWinStatus]) \(pieceSelections[randPSelect])")
            let compare = (randPSelect - 1) == -1 ? 2 : (randPSelect - 1)
            print("\(compare)")
            if pieceSelections[compare] == pieceSelections[number] {
                userScore += 1
            } else {
                userScore -= 1
            }
        }
        nextQuestion()
    }
    
    func nextQuestion() {
        randWinStatus = Int.random(in: 0..<2)
        randPSelect = Int.random(in: 0..<3)
    }
    
    func timesUp(_ timeRemaining: Int) {
        if timeRemaining == 0 {
            alertShowing = true
        }
    }
    
    func resetGame() {
        userScore = 0
        timeRemaining = 5
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
