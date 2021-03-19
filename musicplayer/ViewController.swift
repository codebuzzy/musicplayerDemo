//
//  ViewController.swift
//  musicplayer
//
//  Created by Malti Maurya on 19/03/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var slider: UISlider!
    var player = AVAudioPlayer()
    var isPaused = false
    
    @IBOutlet weak var btnPause: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    @objc func updateTime(_ timer: Timer) {
        slider.value = Float(player.currentTime)
    }

    @IBAction func slide(_ timer: UISlider) {
        player.currentTime = TimeInterval(slider.value)

    }
    
    func initViews()
    {
        do{
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "sample", ofType: "mp3")!))
            player.delegate = self
            slider.maximumValue = Float(player.duration)
            slider.value = 0.0
               Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
             
            player.prepareToPlay()
            
            let session = AVAudioSession.sharedInstance()
            do{
                try session.setCategory(.playback)
            }catch let err
            {
                print(err)
            }
            
            
        }catch let error{
            print(error)
        }
        
    }
 
    
    @IBAction func playButton(_ sender: Any) {
        if player.isPlaying
        {
            player.pause()
            btnPause.setTitle("Resume", for: .normal)
            isPaused = true
            
        }else
        {
            btnPause.setTitle("Pause", for: .normal)
            isPaused = false
            player.play()
        }
    }
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        btnPause.setTitle("Play", for: .normal)
    }
    @IBAction func restartButton(_ sender: Any) {
        btnPause.setTitle("Play", for: .normal)
        if player.isPlaying || isPaused
        {
            player.stop()
            player.currentTime = 0
            player.play()
        }else{
            player.play()
        }
    }
}

