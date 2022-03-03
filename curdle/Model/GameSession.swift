//
//  GameSession.swift
//  curdle
//
//  Created by Kartik Narayanan on 03/03/22.
//

import Foundation

struct GameSession {
    var gamesPlayed: Int
    var gamesWon: Int
    var currentStreak: Int
    var game: Game
    
    init() {
        gamesPlayed = 0
        gamesWon = 0
        currentStreak = 0
        game = Game()
    }
    
    mutating func startNewGame() {
        game = Game()
    }
    
    mutating func getGameAttributes() {
        if game.isGameOver {
            gamesPlayed += 1
        }
        if game.isGameWon {
            gamesWon += 1
        }
        print(gamesPlayed)
        print(gamesWon)
    }
}
