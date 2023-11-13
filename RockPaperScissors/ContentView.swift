//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Noalino on 13/11/2023.
//

import SwiftUI

struct MoveIcon: View {
    let name: String

    var body: some View {
        Text(name)
            .font(.system(size: 80))
    }
}

struct ContentView: View {
    let moves = ["✋", "👊", "🤞"]

    @State private var currentChoice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var answersCount = 0
    @State private var hasGameEnded = false

    var body: some View {
        VStack {
            Text("Score: \(score)")
                .font(.title)

            Spacer()

            VStack {
                Text("The app's move:")
                    .font(.headline)
                MoveIcon(name: moves[currentChoice])
            }

            Spacer()

            VStack {
                HStack {
                    Text("Pick the")
                    Text(shouldWin ? "winning" : "loosing")
                        .underline()
                        .foregroundStyle(shouldWin ? .green : .red)
                        .fontWeight(.semibold)
                    Text("move:")
                }

                HStack {
                    ForEach(0..<3) { i in
                        Button {
                            moveTapped(i)
                        } label: {
                            MoveIcon(name: moves[i])
                        }
                    }
                }
            }

            Spacer()
        }
        .padding()
        .alert("Training is over", isPresented: $hasGameEnded) {
            Button("Restart", action: resetGame)
        } message: {
            Text("Your final score is \(score)")
        }
    }

    func hasWon(with icon: String) -> Bool {
        switch moves[currentChoice] {
        case "✋":
            return shouldWin ? icon == "🤞" : icon == "👊"
        case "👊":
            return shouldWin ? icon == "✋" : icon == "🤞"
        case "🤞":
            return shouldWin ? icon == "👊" : icon == "✋"
        default:
            return false
        }
    }

    func moveTapped(_ i: Int) {
        if hasWon(with: moves[i]) {
            score += 1
        } else {
            score -= 1
        }

        answersCount += 1
        if answersCount == 10 {
            hasGameEnded = true
            return
        }

        currentChoice = Int.random(in: 0..<3)
        shouldWin.toggle()
    }

    func resetGame() {
        answersCount = 0
        score = 0
        currentChoice = Int.random(in: 0..<3)
        shouldWin.toggle()
    }
}

#Preview {
    ContentView()
}
