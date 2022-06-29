//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let eggTimes = ["Soft": 5*60, "Medium": 7*60, "Hard": 12*60]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness: String = sender.currentTitle!
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        secondsPassed = 0
        totalTime = eggTimes[hardness]!
        
        titleLabel.text = hardness
        
        progressBar.progress = 0.0
    }
    
    @objc func updateTimer() {
        progressBar.progress = Float(secondsPassed) / Float(totalTime)
            secondsPassed += 1
        
        if secondsPassed > totalTime {
            timer.invalidate()
            titleLabel.text = "Done!"
            playSound(fileName: "alarm_sound")
        }
    }
    
    func playSound(fileName: String) {
        let url = Bundle.main.url(forResource: fileName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
