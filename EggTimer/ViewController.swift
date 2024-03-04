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
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player: AVAudioPlayer!

    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    
    var totalTime = 300
    
    var counter = 1
    
    var timer = Timer()
    
    
    @objc func updateCounter() {
        if counter >= 0 {
            let percentageProgress = Float(counter) / Float(totalTime)
            
            progressBar.progress = percentageProgress
            
            counter -= 1
        } else {
            timer.invalidate()
            playSound()
            label.text = "done!"
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        
    }
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        
        let hardness: String = sender.currentTitle!
        
        label.text = hardness
        
        totalTime = (eggTimes[hardness] ?? counter)
        
        
        counter = totalTime
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
}
