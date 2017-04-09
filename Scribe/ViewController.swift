//
//  ViewController.swift
//  Scribe
//
//  Created by Kalyan Dechiraju on 09/04/17.
//  Copyright © 2017 Codelight Studios. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var transcriptionTextView: UITextView!
    var audioPlayer: AVAudioPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
    }
    
    func requestSpeechPermission() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                self.readAudioFile()
            }
        }
    }
    
    func readAudioFile() {
        if let filePath = Bundle.main.url(forResource: "test", withExtension: "m4a") {
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: filePath)
                audioPlayer.prepareToPlay()
                audioPlayer.play()
                analyzeSpeechFromAudio(fileUrl: filePath)
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    func analyzeSpeechFromAudio(fileUrl: URL) {
        let recognizer = SFSpeechRecognizer()
        let request = SFSpeechURLRecognitionRequest(url: fileUrl)
        recognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
            if let error = error {
                print(error)
            } else {
                //print(result?.bestTranscription.formattedString)
                self.transcriptionTextView.text = result?.bestTranscription.formattedString
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        })
    }
    
    @IBAction func recordButtonPressed(_ sender: RoundedButton) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        requestSpeechPermission()
    }
    
}

