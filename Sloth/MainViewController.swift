//
//  MainViewController.swift
//  Sloth
//
//  Created by JAEHA JU on 2023/03/29.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController {

    @IBOutlet weak var timerStartButton: UIButton!
    @IBOutlet weak var timerCountLabel: UILabel!
    @IBOutlet weak var timerResultLabel: UILabel!
    @IBOutlet weak var countProgressBar: CircularProgressBar!
    
    private var player: AVAudioPlayer?
    var timer: Timer?
    var timerNum: Int = 0
    var exerciseNum: Int = 1
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    @IBAction func timerStartButtonAction(_ sender: UIButton) {
        if timer != nil && timer!.isValid {
            timer!.invalidate()
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                self.setTimerCount()
            }
        }
    }

    func initUI() {
        self.navigationController?.navigationBar.isHidden = true;
        timerResultLabel.text = "NuY-tw-7rt.Warming up.label".localized()
        timerResultLabel.clipsToBounds = true
        timerResultLabel.layer.cornerRadius = 4.0
        timerStartButton.setTitle("vfv-ZI-Ulv.Start.button".localized(), for: .normal)
        timerStartButton.layer.cornerRadius = 4.0
        timerCountLabel.text = "\(timerNum)"
        countProgressBar.value = 0.5 / 0.2
    }
    
    func setTimerCount() {
        self.timerCountLabel.text = "\(timerNum)"
        
        if timerNum < 10 {
            timerResultLabel.text = "NuY-tw-7rt.Warming up.label".localized()
            stopSound()
        } else if timerNum >= 10 && timerNum <= 14 {
            timerResultLabel.text = "NuY-tw-7rt.Start!.label".localized()
        } else {
            if timerNum % 5 == 0 {
                timerResultLabel.text = "\(exerciseNum)개!"
                playSound()
                exerciseNum += 1
            } else {
                stopSound()
            }
        }
     
        if timerNum == 60 {
            timer!.invalidate()
            timer = nil
            timerNum = 0
            exerciseNum = 1
            timerResultLabel.text = "NuY-tw-7rt.Finish!.label".localized()
            stopSound()
        }
        timerNum += 1
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "SoundHelix-Song-12", withExtension: "mp3") else {
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            player?.numberOfLoops = 0
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    func stopSound() {
        player?.stop()
    }
}

extension String {
    func localized(comment: String = "") -> String {
           return NSLocalizedString(self, comment: comment)
       }
}
