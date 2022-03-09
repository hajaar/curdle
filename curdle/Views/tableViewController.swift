    //
    //  tableViewController.swift
    //  curdle
    //
    //  Created by Kartik Narayanan on 02/03/22.
    //

import UIKit
import AVFoundation


class tableViewController: UIViewController {
    
    var gameSession = GameSession()
    var isNewGame: Bool = true
    var tmpText: String = ""
    var msgText: String = ""
    var player: AVAudioPlayer!
    var takeScreenShot: Bool = false
    
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var guessesTableView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        inputText.becomeFirstResponder()
        inputText.delegate = self
        inputText.returnKeyType = .done
        
        guessesTableView.dataSource = self
    }
    
    @IBAction func showStats(_ sender: UIButton) {
            self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    @IBAction func inputTextEditing(_ sender: UITextField) {
        if !gameSession.game.isGameOver {
            tmpText = inputText.text ?? ""
            playSound("letterentry")
            isNewGame = false
            guessesTableView.reloadData()
        }
        if gameSession.game.isGameOver {
            startGameOverTasks()
            
        }
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
    
}

extension tableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !gameSession.game.isGameOver {
            msgText = gameSession.game.checkGuess(guess: textField.text!)
            gameSession.setGameAttributes()
              playSound("wordentered")
            textField.text = ""
            tmpText = ""
        }
        guessesTableView.reloadData()
        if gameSession.game.isGameOver {
            startGameOverTasks()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let allowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
            let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
            let typedCharacterSet = CharacterSet(charactersIn: string)
            let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
            return alphabet

    }
}

extension tableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return K.maxNumberOfAttempts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! guessTableViewCell
        
        let imageArray = [cell.imageView1!, cell.imageView2!, cell.imageView3!, cell.imageView4!, cell.imageView5!]
        

        
        gameSession.game.getWordDetails(row: indexPath.row, typeText: tmpText)
        
        for i in 0...K.maxLengthOfWord - 1 {
            
            
            
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


