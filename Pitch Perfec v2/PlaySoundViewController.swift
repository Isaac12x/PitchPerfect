//
//  PlaySoundViewController.swift
//  Pitch Perfec v2
//
//  Created by Isaac Albets Ramonet on 21/7/15.
//  Copyright (c) 2015 Isaac Albets Ramonet. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio: RecordedAudio!

    
    var audioEngine:AVAudioEngine!
    var audioFile: AVAudioFile!
    var putRate: Float!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer = try? AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = try? AVAudioFile(forReading: receivedAudio.filePathUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func stopAll(){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.currentTime = 0.0
    }
    
    func playAudio(newRate: Float){
        stopAll()
        audioPlayer.rate = newRate
        audioPlayer.play()
    }
    
    @IBAction func decreaseSoundSpeed(sender: UIButton) {
        playAudio(0.5)
    }
    
    
    @IBAction func increaseSoundSpeed(sender: UIButton) {
        playAudio(2.0)
    }
    
    
    
    func playAudioWithVariablePitch(pitch: Float) {
        stopAll()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format:nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        do {
            try audioEngine.startAndReturnError()
        } catch _ {
        }
        
        audioPlayerNode.play()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton){
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        stopAll()
    }

}


