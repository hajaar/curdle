//
//  resultsViewController.swift
//  curdle
//
//  Created by Kartik Narayanan on 04/03/22.
//

import UIKit

class resultsViewController: UIViewController {
    @IBOutlet weak var dismissButton: UIButton!
    
    @IBOutlet weak var playedLabel: UILabel!
    @IBOutlet weak var wonLabel: UILabel!
    @IBOutlet weak var currentStreakLabel: UILabel!
    @IBOutlet weak var maxStreakLabel: UILabel!
    @IBOutlet weak var avgTimeLabel: UILabel!
    var resultGameStats = GameStats()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(resultGameStats)
        playedLabel.text = String(resultGameStats.gamesPlayed)
        wonLabel.text = String(resultGameStats.winPercent)
        currentStreakLabel.text = String(resultGameStats.currentStreak)
        maxStreakLabel.text = String(resultGameStats.maxStreak)
        avgTimeLabel.text = String(resultGameStats.avgTimeToWin)
        
    }
    
    
    @IBAction func dismissScreen(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
