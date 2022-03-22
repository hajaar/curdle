    //
    //  tableViewController.swift
    //  curdle
    //
    //  Created by Kartik Narayanan on 02/03/22.
    //

import UIKit
import AVFoundation
import KeyboardKit


class tableViewController: UIViewController {
    
    var gameSession = GameSession()
    var isNewGame: Bool = true
    var tmpText: String = ""
    var msgText: String = ""
    var player: AVAudioPlayer!
    var takeScreenShot: Bool = false
    
    @IBOutlet weak var guessesTableView: UITableView!
    
    @IBOutlet var keyButtons: [UIButton]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guessesTableView.dataSource = self
        colorKeys()
        
    }
    
    @IBAction func showStats(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }

    func colorKeys() {
        for item in keyButtons {
            let tmpTag = item.tag
            if tmpTag > 0 && tmpTag < 27 {
                item.tintColor = gameSession.game.colorOfKeys[tmpTag - 1]
            }
        }
    }
    
    
    @IBAction func startNewGame(_ sender: UIButton) {
        startGame()
    }
    
    func startGame() {
        gameSession.startNewGame()
        isNewGame = true
        playSound("startnewgame")
        guessesTableView.reloadData()
    }
    
    func shareScreenShot(tmpView: UITableView) {
        takeScreenShot = true
        tmpView.reloadData()
        
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: tmpView.bounds.width, height: tmpView.bounds.height),
            false,
            2
        )
        
        tmpView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        takeScreenShot = false
        tmpView.reloadData()
        
        
            //  UIImageWriteToSavedPhotosAlbum(screenshot, self, #selector(imageWasSaved), nil)
        
        let messageStr = gameSession.getGameStatsForLabel()
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems:  [screenshot, messageStr], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! resultsViewController
            destinationVC.resultGameStats = gameSession.gameStats
        }
    }
    
    func playSound(_ sender: String?) {
        let url = Bundle.main.url(forResource: sender, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        
    }
    
    func startGameOverTasks() {
        
        playSound(gameSession.game.isGameWon ? "correctguess" : "gamelost")
        
        
        let alert = UIAlertController(title: gameSession.game.isGameWon ? "You Win. Woohoo!" : "You Lost. Sorry!", message: gameSession.getGameStatsForLabel(), preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Share", style: UIAlertAction.Style.default, handler: {action in self.shareScreenShot(tmpView: self.guessesTableView)}))
        alert.addAction(UIAlertAction(title: "New Game", style: UIAlertAction.Style.default, handler: {action in self.startGame()} ))
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBAction func changeLanguage(sender: AnyObject) {
        guard let button = sender as? UIButton else {
            return
        }
        let keyEntered: Int = button.tag
        if keyEntered != 28 {
            switch keyEntered {
            case 1:
                tmpText += "A"
            case 2:
                tmpText += "B"
            case 3:
                tmpText += "C"
            case 4:
                tmpText += "D"
            case 5:
                tmpText += "E"
            case 6:
                tmpText += "F"
            case 7:
                tmpText += "G"
            case 8:
                tmpText += "H"
            case 9:
                tmpText += "I"
            case 10:
                tmpText += "J"
            case 11:
                tmpText += "K"
            case 12:
                tmpText += "L"
            case 13:
                tmpText += "M"
            case 14:
                tmpText += "N"
            case 15:
                tmpText += "O"
            case 16:
                tmpText += "P"
            case 17:
                tmpText += "Q"
            case 18:
                tmpText += "R"
            case 19:
                tmpText += "S"
            case 20:
                tmpText += "T"
            case 21:
                tmpText += "U"
            case 22:
                tmpText += "V"
            case 23:
                tmpText += "W"
            case 24:
                tmpText += "X"
            case 25:
                tmpText += "Y"
            case 26:
                tmpText += "Z"
            case 27:
                if tmpText.isEmpty == false {
                    tmpText.removeLast()
                }
            default:
                print("Unknown language")
                return
            }
            if !gameSession.game.isGameOver {
                playSound("letterentry")
                isNewGame = false
                guessesTableView.reloadData()
            }
            if gameSession.game.isGameOver {
                startGameOverTasks()
                
            }
        } else {
            if !gameSession.game.isGameOver {
                msgText = gameSession.game.checkGuess(guess: tmpText.lowercased())
                playSound(gameSession.game.isValidGuess ? "wordentered" : "invalidword")
                gameSession.setGameAttributes()
                colorKeys()
                guessesTableView.reloadData()
                tmpText = ""
            }
            if gameSession.game.isGameOver {
                startGameOverTasks()
            }
        }
        print(tmpText)
    }
}



extension tableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return K.maxNumberOfAttempts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! guessTableViewCell
        
        let imageArray = [cell.imageView1!, cell.imageView2!, cell.imageView3!, cell.imageView4!, cell.imageView5!]
        
        
        
        gameSession.game.getWordDetails(row: indexPath.row, typeText: tmpText.lowercased())
        
        for i in 0...K.maxLengthOfWord - 1 {
            
           // print("\(i) \(gameSession.game.wordDetails[i].letterImage)")
            
            UIView.transition(with: imageArray[i],
                              duration: gameSession.game.wordDetails[i].letterDuration,
                              options: gameSession.game.wordDetails[i].letterAnimation,
                              animations: { imageArray[i].image = self.takeScreenShot ? K.filledTileImage : self.gameSession.game.wordDetails[i].letterImage },
                              completion: nil)
            
            imageArray[i].tintColor = gameSession.game.wordDetails[i].letterColor
            
        }
        
        
        return cell
        
    }
    
}


