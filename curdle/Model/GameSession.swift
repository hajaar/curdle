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
        for i in 0...gameStats.count {
            t += gameStats[i].isGameWon ? 1 : 0
        }
        return t
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
