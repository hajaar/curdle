    //
    //  GameSession.swift
    //  curdle
    //
    //  Created by Kartik Narayanan on 03/03/22.
    //

import Foundation

struct GameSession {
    var currentStreak: Int
    var game: Game
    var gameStats: [GameStats]
    
    init() {
        currentStreak = 0
        game = Game()
        gameStats = [GameStats]()
    }
    
    mutating func startNewGame() {
        game = Game()
    }
    
    mutating func setGameAttributes() {
        if game.isGameOver {
            gameStats.append(GameStats(game.chosenWord,game.isGameWon,game.numberOfAttempts))
        }
    }
    
    func getGamesPlayed() -> Int {
        return gameStats.count
    }
    
    func getGamesWon() -> Int {
        var t = 0
        if gameStats.count > 0 {
            for i in 1...gameStats.count {
                t += gameStats[i-1].isGameWon ? 1 : 0
            }
        }
        return t
        
    }
    
    mutating func getCurrentStreak() -> Int {
        var maxStreak = 0
        if gameStats.count > 0 {
            for i in 1...gameStats.count {
                if gameStats[i-1].isGameWon {
                    maxStreak += 1
                    currentStreak = currentStreak > maxStreak ? currentStreak : maxStreak
                } else {
                    maxStreak = 0
                }
            }
        }
        return currentStreak
    }
}

struct GameStats {
    let chosenWord: String
    let isGameWon: Bool
    let noOfAttempts: Int
    
    init(_ chosenWord: String, _ isGameWon: Bool, _ noOfAttempts: Int) {
        self.chosenWord = chosenWord
        self.isGameWon = isGameWon
        self.noOfAttempts = noOfAttempts
    }
}
