//
//  ViewController.swift
//  LifeCounter
//
//  Created by stlp on 4/19/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var minusFiveButton: UIButton!
    @IBOutlet weak var plusFiveButton: UIButton!
    
    // player 2 controls
    @IBOutlet weak var minusFiveButton2: UIButton!
    @IBOutlet weak var minusButton2: UIButton!
    @IBOutlet weak var scoreLabel2: UILabel!
    @IBOutlet weak var plusButton2: UIButton!
    @IBOutlet weak var plusFiveButton2: UIButton!
    
    var score = 20
    var score2 = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scoreLabel.text = "\(score)"
        scoreLabel2.text = "\(score2)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func minusButtonDidTouchUpInside(_ sender: Any) {
        changeScore(sender: sender, changeBy: -1, player: "1")
    }
    
    @IBAction func plusButtonDidTouchUpInside(_ sender: Any) {
        changeScore(sender: sender, changeBy: 1, player: "1")
    }
    
    @IBAction func minusFiveButtonDidTouchUpInside(_ sender: Any) {
        changeScore(sender: sender, changeBy: -5, player: "1")
    }
    @IBAction func plusFiveButtonDidTouchUpInside(_ sender: Any) {
        changeScore(sender: sender, changeBy: 5, player: "1")
    }
    
    // player 2
    @IBAction func minusFiveButton2DidTouchUpInside(_ sender: Any) {
        changeScore(sender: sender, changeBy: -5, player: "2")
    }
    @IBAction func minusButton2DidTouchUpInside(_ sender: Any) {
        changeScore(sender: sender, changeBy: -1, player: "2")
    }
    @IBAction func plusButton2DidTouchUpInside(_ sender: Any) {
        changeScore(sender: sender, changeBy: 1, player: "2")
    }
    @IBAction func plusFiveButton2DidTouchUpInside(_ sender: Any) {
        changeScore(sender: sender, changeBy: 5, player: "2")
    }
    
    func changeScore(sender: Any, changeBy: Int, player: String) {
        if player == "1" {
            score += changeBy
            scoreLabel.text = "\(score)"
        }
        else {
            score2 += changeBy
            scoreLabel2.text = "\(score2)"
        }
        
        if score <= 0 || score2 <= 0 {
            alertPressed(sender, loser: player)
        }
    }
    
    @IBAction func alertPressed(_ sender: Any, loser: String) {
        let alert = UIAlertController(title: "The Game is Over", message: "Player \(loser) LOSES!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { _ in NSLog("\"OK\" pressed.")}))
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: { _ in NSLog("\"Cancel\" pressed.")}))
        self.present(alert, animated: true, completion: {
          NSLog("The completion handler fired")
        })
      }
}

