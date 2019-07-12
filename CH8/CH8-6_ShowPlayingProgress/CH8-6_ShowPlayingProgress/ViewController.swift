//
//  ViewController.swift
//  CH8-6_ShowPlayingProgress
//
//  Created by Chung-I Wu on 2019/7/12.
//  Copyright © 2019 Chung-I Wu. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {

    var audio: AVAudioPlayer?
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        do {
            let url = Bundle.main.url(forResource: "Moonlight", withExtension: "mp3")
            try AVAudioSession.sharedInstance().setCategory(.playback)
            audio = try AVAudioPlayer.init(contentsOf: url!)
            
            if audio != nil {
                if audio!.prepareToPlay() {
                    print("Start play")
                    audio!.play()
                    
                    slider.minimumValue = 0
                    slider.maximumValue = Float(audio!.duration)
                    slider.value = 0
                    
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                        self.ticker(timer: timer)
                    }
                }
            }
        } catch {
            print(error)
        }
    }
    
    func ticker(timer: Timer) {
        slider.value = Float(audio!.currentTime)
        if !audio!.isPlaying {
            print("Music stop")
            timer.invalidate()
        }
    }


    @IBAction func sliderValueChanged(_ sender: Any) {
        audio?.currentTime = TimeInterval(slider.value)
    }
}

