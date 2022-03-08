    //
    //  tableViewController.swift
    //  curdle
    //
    //  Created by Kartik Narayanan on 02/03/22.
    //

import UIKit
import AVFoundation


class tableViewController: UIViewController {
    
    
    
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var guessesTableView: UITableView!
    
    @IBAction func startNewGame(_ sender: UIButton) {
        gameSession.startNewGame()
        isNewGame = true
        playSound("startnewgame")
        guessesTableView.reloadData()
        
    }
    var gameSession = GameSession()
    var isNewGame: Bool = true
    var tmpText: String = ""
    var msgText: String = ""
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        inputText.becomeFirstResponder()
        inputText.delegate = self
        inputText.returnKeyType = .done
        
        guessesTableView.delegate = self
        guessesTableView.dataSource = self
    }
    

    
    @IBAction func inputTextEditing(_ sender: UITextField) {
        if !gameSession.game.isGameOver {
            tmpText = inputText.text ?? ""
            playSound("letterentry")
            isNewGame = false
            guessesTableView.reloadData()
        }
        if gameSession.game.isGameOver {
            self.performSegue(withIdentifier: "goToResult", sender: self)
        }
    }
    
    @IBAction func shareImage(_ sender: UIButton) {
        
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: guessesTableView.bounds.width, height: guessesTableView.bounds.height),
            false,
            2
        )
        
        guessesTableView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        
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
            let tmpStr = gameSession.game.isGameWon ? "correctguess" : "gamelost"
            playSound(tmpStr)
            self.performSegue(withIdentifier: "goToResult", sender: self)
        }
        return true
    }
}




extension tableViewController: UITableViewDelegate {
    
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
                              animations: { imageArray[i].image = self.gameSession.game.wordDetails[i].letterImage },
                              completion: nil)
            imageArray[i].tintColor = gameSession.game.wordDetails[i].letterColor
            
        }
        
        
        return cell
        
    }
    
}


