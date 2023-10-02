//
//  ContentView.swift
//  diceGame
//
//  Created by Andreas Antonsson on 2023-10-02.
//

import SwiftUI

// Game Class
class DiceGame : ObservableObject {
    @Published var dice1: Int = 0
    @Published var dice2: Int = 0
    @Published var currentScore: Int = 0
    
}

struct ContentView: View {
    
    // Instantiate the game
   @StateObject var myGame = DiceGame()
    
   @State var showWinnersView = false
    
    // Function for rolling the dice
    func rollDice() {
        myGame.dice1 = Int.random(in: 1...6)
        myGame.dice2 = Int.random(in: 1...6)
        myGame.currentScore += myGame.dice1 + myGame.dice2
        print(myGame.currentScore)
        
        if myGame.currentScore > 21 {
            showWinnersView = true
        }
    }
    
    var body: some View {
        ZStack {
            Color(cgColor: CGColor (red: 45/255, green: 112/255, blue: 0/255, alpha: 1)).ignoresSafeArea()
            
            VStack(spacing: 50) {
                Text("Dice Game!")
                    .font(.largeTitle)
                    .bold()
                    .padding(50)
                Spacer()
                Text("Current score: \(myGame.currentScore)")
                HStack {
                    if myGame.dice1 == 0 || myGame.dice2 == 0 {
                        Text("Start the game by rolling the dice!")
                    } else {
                        Image("dice-\(myGame.dice1)").background(.white)
                        Image("dice-\(myGame.dice2)").background(.white)
                    }
                }
                
                Button(action: {
                    rollDice()},
                       label: {
                    Text("Roll the Dice!").font(.title2)
                        .bold()
                        .foregroundColor(.black)
                        .padding(10).background(.white)
                        .cornerRadius(10)
                })
                Spacer()
                
            }.sheet(isPresented: $showWinnersView,
                    onDismiss: {
                myGame.dice1 = 0
                myGame.dice2 = 0
                myGame.currentScore = 0
                }, content: {
                winnersView(myGame: myGame)
            })
        }
    }
    
    struct winnersView: View {
        
        @ObservedObject var myGame: DiceGame
        
        var body: some View {
            VStack(spacing: 20) {
                Text("congratulations you have won!")
                Text("current score: \(myGame.currentScore)")
                Button(action: {
                    myGame.currentScore += 1
                    print(myGame.currentScore)
                }, label: {
                    Text("Increment score").foregroundColor(.black).padding().background(.brown).cornerRadius(10)
                })
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            //ContentView()
            winnersView(myGame: DiceGame())
        }
    }
}
// 2:09
