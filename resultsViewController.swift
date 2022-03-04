//
//  resultsViewController.swift
//  curdle
//
//  Created by Kartik Narayanan on 04/03/22.
//

import UIKit

class resultsViewController: UIViewController {
    @IBOutlet weak var dismissButton: UIButton!
    
    var resultGameStats = GameStats()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(resultGameStats)
        // Do any additional setup after loading the view.
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
