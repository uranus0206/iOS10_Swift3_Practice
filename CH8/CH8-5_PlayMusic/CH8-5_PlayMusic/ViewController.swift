//
//  ViewController.swift
//  CH8-5_PlayMusic
//
//  Created by Chung-I Wu on 2019/7/12.
//  Copyright © 2019 Chung-I Wu. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {
    var audio: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(audioInterrupt(_:)), name: AVAudioSession.interruptionNotification, object: nil)
        
        do {
            let url = Bundle.main.url(forResource: "Moonlight", withExtension: "mp3")
            
            try AVAudioSession.sharedInstance().setCategory(.playback)
            
            audio = try AVAudioPlayer.init(contentsOf: url!)
            
            if audio != nil {
                if audio!.prepareToPlay() {
                    audio!.play()
                    print("Start play music")
                }
            }
        } catch {
            print(error)
        }
    }
    
    @objc func audioInterrupt(_ noti: NSNotification) {
        guard audio != nil else {
            return
        }
        
        guard let type = noti.userInfo?[AVAudioSessionInterruptionTypeKey] as? AVAudioSession.InterruptionType.RawValue else {
                return
        }
        
        guard let _type = AVAudioSession.InterruptionType(rawValue: type) else {
            return
        }
        
        switch _type {
        case .began:
            print("Music interrupt")
            audio?.pause()
            
        case .ended:
            print("Finish interrupt")
            guard let option = noti.userInfo?[AVAudioSessionInterruptionOptionKey] as? AVAudioSession.InterruptionOptions.RawValue else {
                return
            }
            let _option = AVAudioSession.InterruptionOptions(rawValue: option)
            if _option == .shouldResume {
                audio!.play()
            }
            audio!.play()
        }
    }
}

