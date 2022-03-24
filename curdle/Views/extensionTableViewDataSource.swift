    //
    //  extensionTableViewDataSource.swift
    //  curdle
    //
    //  Created by Kartik Narayanan on 24/03/22.
    //

import Foundation
import UIKit

extension tableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return K.maxNumberOfAttempts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! guessTableViewCell
        
        let imageArray = [cell.imageView1!, cell.imageView2!, cell.imageView3!, cell.imageView4!, cell.imageView5!]
        
        if !isViewingHistory {
            
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
        } else {

                for i in 0...K.maxLengthOfWord - 1 {
                    
                    
                    imageArray[i].image = gameSession.encodeDecodeGuesses.historyWords[i + 5 * indexPath.row].letterImage
                    imageArray[i].tintColor = gameSession.encodeDecodeGuesses.historyWords[i + 5 * indexPath.row].letterColor
                }
            
        }
        
        return cell
        
    }
    
}
