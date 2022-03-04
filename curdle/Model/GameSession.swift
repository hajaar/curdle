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


    init() {
        game = Game()
        gameStats = GameStats()
        getGamesStats()
       

        //print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    
    mutating func startNewGame() {
        game = Game()
        startingPoint = Date()
        getGamesStats()
    }
    
    mutating func setGameAttributes() {
        if game.isGameOver {
            try! realm.write({
                let newgameStat = CurdleGameStatsDataModel()
                newgameStat.chosenWord = game.chosenWord
                newgameStat.isGameWon = game.isGameWon
                newgameStat.noOfAttempts = game.isGameWon ? game.numberOfAttempts : -1
                newgameStat.timeToWin = round(startingPoint.timeIntervalSinceNow * -1 * 10.0)/10.0
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
        gameStats.winPercent = tmpGamesPlayed > 0 ? round(Double(tmpGamesWon)/Double(tmpGamesPlayed) * 100.0) : 0
        gameStats.currentStreak = currentStreak
        for i in 0...tmpattemptDistribution.count - 1 {
            gameStats.attemptDistribution[i] = tmpattemptDistribution[i]
        }
        gameStats.avgTimeToWin = round(tmpTotalTimeToWin/Double(tmpGamesWon))*10.0/10.0
        print(gameStats)
        
    }
    
    
    mutating func getGameStatsForLabel() -> String {

        return String(gameStats.gamesPlayed) + " " + String(gameStats.winPercent) +  "% " + String(gameStats.currentStreak)
    }
    
}



