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
    var game: Game = Game()
    var gameStats = GameStats()

    
    
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
                newgameStat.noOfAttempts = game.numberOfAttempts
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
            for i in 0...tmpGamesPlayed-1{
                tmpGamesWon += gameStatsModelData[i].isGameWon ? 1 : 0
            }
            
            
        }
        gameStats.gamesPlayed = tmpGamesPlayed
        gameStats.winPercent = round(Double(tmpGamesWon)/Double(tmpGamesPlayed) * 100.0)
        gameStats.currentStreak = tmpCurrentStreak
        gameStats.maxStreak = tmpMaxStreak
        
    }
    
    
    mutating func getGameStatsForLabel() -> String {

        return String(gameStats.gamesPlayed) + " " + String(gameStats.winPercent) +  "% " + String(gameStats.currentStreak)
    }
    
}



