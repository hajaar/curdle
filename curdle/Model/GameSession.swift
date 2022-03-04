    //
    //  GameSession.swift
    //  curdle
    //
    //  Created by Kartik Narayanan on 03/03/22.
    //

import Foundation
import RealmSwift

struct GameSession {
    let realm = try! Realm()
    lazy var gameStatsModelData: Results<CurdleGameStatsDataModel> = {self.realm.objects(CurdleGameStatsDataModel.self)}()
    var game: Game
    var gameStats: GameStats

    init() {
        game = Game()
        gameStats = GameStats()
        getGamesStats()
    }
    
    
    mutating func startNewGame() {
        game = Game()
        getGamesStats()
    }
    
    mutating func setGameAttributes() {
        if game.isGameOver {
            try! realm.write({
                let newgameStat = CurdleGameStatsDataModel()
                newgameStat.chosenWord = game.chosenWord
                newgameStat.isGameWon = game.isGameWon
                newgameStat.noOfAttempts = game.isGameWon ? game.numberOfAttempts : -1
                realm.add(newgameStat)
                print("success")
            })
        }
        getGamesStats()
    }
    
    mutating func getGamesStats() {
        self.gameStatsModelData = try! Realm().objects(CurdleGameStatsDataModel.self)
        
        let tmpGamesPlayed = gameStatsModelData.count > 0 ? gameStatsModelData.count : 0
        var tmpGamesWon = 0
        var tmpCurrentStreak = 0
        var tmpMaxStreak = 0
        
        if tmpGamesPlayed > 0 {
            for i in 0...tmpGamesPlayed-1 {
                tmpGamesWon += gameStatsModelData[i].isGameWon ? 1 : 0
                if gameStatsModelData[i].noOfAttempts > 0 {
                    //print(gameStatsModelData[i].noOfAttempts)
                    gameStats.attemptDistribution[gameStatsModelData[i].noOfAttempts - 1] += 1
                }
            }
        }
        
        gameStats.gamesPlayed = tmpGamesPlayed
        gameStats.winPercent = tmpGamesPlayed > 0 ? round(Double(tmpGamesWon)/Double(tmpGamesPlayed) * 100.0) : 0
        gameStats.currentStreak = tmpCurrentStreak
        gameStats.maxStreak = tmpMaxStreak
        print(gameStats)
        
    }
    
    
    mutating func getGameStatsForLabel() -> String {

        return String(gameStats.gamesPlayed) + " " + String(gameStats.winPercent) +  "% " + String(gameStats.currentStreak)
    }
    
}



