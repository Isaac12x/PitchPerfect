//
//  RecordSoundsViewController.swift
//  Pitch Perfec v2
//
//  Created by Isaac Albets Ramonet on 21/7/15.
//  Copyright (c) 2015 Isaac Albets Ramonet. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    // Variable declaration
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var tapToRecord: UILabel!
    
    @IBOutlet weak var stopButton: UIButton!
    
    // Variables Declared Globally
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        tapToRecord.hidden = false
        tapToRecord.text = "Tap to record"
    }
    
    // Prepare buttons to be displayed then locate the 
    // main directory of the app, declare the name of the
    // recording pass it to an array then to a filePath 
    // so we can track it. Initialitzate a session of 
    // audio and then start audioRecorder passing the
    // path to the file and performing the recording.
    
    @IBAction func recordAudio(sender: UIButton) {
        stopButton.hidden = false
        tapToRecord.text = "recording..."
        print("in recordAudio")
        
        var dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
        
       
        let recordingName = "My_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        var session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch _ {
        }
        
        audioRecorder = try? AVAudioRecorder(URL: filePath, settings: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    // Identify if audio has finished recording before
    // performing any action in this audio
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
            let recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
            performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else{
            print("Recording was not successful")
            recordButton.enabled = true
            stopButton.hidden = true
        }
        
    }
    
    // Perform a segue to the next view when the user
    // presses on stopRecording
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording"){
            let playSoundsVC:PlaySoundViewController = segue.destinationViewController as! PlaySoundViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
    // Stop recording when pressed the stop button
    // TO improve someday: keep pressed stop button to pause
    // implement audioRecord.pause() and labels for 
    // user interface usability purposes.
    
    @IBAction func stopRecording(sender: UIButton) {
        audioRecorder.pause()
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false)
        } catch _ {
        }
        audioRecorder.stop()

    }
    
    


}

