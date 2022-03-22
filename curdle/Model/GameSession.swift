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
    var currentStreak: Int = 0
    var startingPoint = Date()
    var lastGameId: Int = 0
    var timeToWin: Int = 0

    init() {
        game = Game()
        gameStats = GameStats()
        getGamesStats()
        
       

      // print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    
    mutating func startNewGame() {
        game = Game()
        startingPoint = Date()
        getGamesStats()
        
    }
    
    mutating func setGameAttributes() {
        lastGameId = gameStatsModelData.count
        if game.isGameOver {
            try! realm.write({
                let newgameStat = CurdleGameStatsDataModel()
                newgameStat.gameID = lastGameId + 1
                newgameStat.chosenWord = game.chosenWord
                newgameStat.isGameWon = game.isGameWon
                newgameStat.noOfAttempts = game.isGameWon ? game.numberOfAttempts : -1
                timeToWin = Int(round(startingPoint.timeIntervalSinceNow * -1 ))
                newgameStat.timeToWin = Double(timeToWin)
                realm.add(newgameStat)
            })
           
            currentStreak = game.isGameWon ? currentStreak + 1 : 0
        }
        getGamesStats()
    }
    
    mutating func getGamesStats() {
        self.gameStatsModelData = try! Realm().objects(CurdleGameStatsDataModel.self)
        
        let tmpGamesPlayed = gameStatsModelData.count > 0 ? gameStatsModelData.count : 0
        var tmpGamesWon = 0
        var tmpMaxStreak = 0
        var tmpattemptDistribution = [Int](repeating: 0, count: K.maxNumberOfAttempts)
        var tmpTotalTimeToWin = 0.0
        
        if tmpGamesPlayed > 0 {
            for i in 0...tmpGamesPlayed-1 {
                tmpGamesWon += gameStatsModelData[i].isGameWon ? 1 : 0
                tmpTotalTimeToWin += gameStatsModelData[i].isGameWon ? gameStatsModelData[i].timeToWin : 0
                if gameStatsModelData[i].noOfAttempts > 0 {
                    tmpattemptDistribution[gameStatsModelData[i].noOfAttempts - 1] += 1
                }
                tmpMaxStreak = gameStatsModelData[i].isGameWon ? tmpMaxStreak + 1 : 0
                gameStats.maxStreak = gameStats.maxStreak > tmpMaxStreak ? gameStats.maxStreak : tmpMaxStreak
            }
        }
        
        gameStats.gamesPlayed = tmpGamesPlayed
        gameStats.winPercent = tmpGamesPlayed > 0 ? tmpGamesWon/tmpGamesPlayed * 100 : 0
        gameStats.currentStreak = currentStreak
        for i in 0...tmpattemptDistribution.count - 1 {
            gameStats.attemptDistribution[i] = tmpattemptDistribution[i]
        }
        gameStats.avgTimeToWin = tmpGamesWon > 0 ? Int(tmpTotalTimeToWin)/tmpGamesWon : 0
        // print(gameStats)
        
    }
    
    
    mutating func getGameStatsForLabel() -> String {

        return "Curdle: " + String(lastGameId + 1) + ", Attempts: " + (game.isGameWon ? String(game.numberOfAttempts) : String("*"))  + "/" + String(K.maxNumberOfAttempts) + String(", Time: ") + String(timeToWin) + "s"
    }
    
}


struct GameStats {
    var gamesPlayed = 0
    var winPercent = 0
    var currentStreak = 0
    var maxStreak = 0
    var attemptDistribution = [Int](repeating: 0, count: K.maxNumberOfAttempts)
    var avgTimeToWin = 0
}

