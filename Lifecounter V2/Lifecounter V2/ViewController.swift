//
//  ViewController.swift
//  Lifecounter V2
//
//  Created by stlp on 4/26/22.
//

import UIKit
var history: [String] = []

class ViewController: UIViewController {
    
    var players: [String] = ["Player 1", "Player 2", "Player 3", "Player 4"]
    var scores: [Int] = [20, 20, 20, 20]
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var addPlayer: UIButton!
    @IBOutlet weak var numberInput: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var subtractButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        pickerView.dataSource = self
        pickerView.delegate = self
    }


    @IBAction func addPlayerPressed(_ sender: Any) {
        if players.count < 8 {
            players.append("Player \(players.count + 1)")
            scores.append(20)
            refreshUI()
        }
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let currentIndex = pickerView.selectedRow(inComponent: 0)
        let lifeChange = Int(numberInput.text!) ?? 0
        if lifeChange != 0 {
            addPlayer.isEnabled = false
        }
        history.append("\(history.count + 1) - \(players[currentIndex]) gained \(lifeChange) life.")
        changeScore(index: currentIndex, changeBy: lifeChange)
    }
    
    @IBAction func subtractButtonPressed(_ sender: Any) {
        let currentIndex = pickerView.selectedRow(inComponent: 0)
        let lifeChange = Int(numberInput.text!) ?? 0
        if lifeChange != 0 {
            addPlayer.isEnabled = false
        }
        history.append("\(history.count + 1) - \(players[currentIndex]) lost \(lifeChange) life.")
        changeScore(index: currentIndex, changeBy: lifeChange * -1)
    }
    
    func refreshUI() {
        self.tableView.reloadData()
        self.pickerView.reloadAllComponents()
    }
    
    func changeScore(index: Int, changeBy: Int) {
        scores[index] += changeBy
        refreshUI()
        
        if scores[index] <= 0 {
            alertPressed(loser: players[index])
            history.append("\(history.count + 1) - \(players[index]) has lost.")
        }
    }
    
    @IBAction func alertPressed(loser: String) {
        let alert = UIAlertController(title: "Attention!", message: "\(loser) LOSES!", preferredStyle: .alert)
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
    
    @IBAction func historyButtonPressed(_ sender: Any) {
        let hvc = HistoryViewController()
        present(hvc, animated: true) {
            NSLog("HVC presented")
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me!")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        let playerName = players[indexPath.row]
        let playerScore = scores[indexPath.row]
        
        cell.playerName.text = playerName
        cell.playerScore.text = String(playerScore)
        
        return cell
    }
}

extension ViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return players.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return players[row]
    }
}
