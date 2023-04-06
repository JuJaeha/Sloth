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
    var mTimer: Timer?
    var timerNum: Int = 0
    var exerciseNum: Int = 1
    var maxCount: Int = 60
   
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    @IBAction func timerStartButtonAction(_ sender: UIButton) {
        if let timer = mTimer {
            if timer.isValid && mTimer != nil {
                timer.invalidate()
            } else {
                mTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    self.setTimerCount()
                }
            }
        } else {
            mTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                self.setTimerCount()
            }
        }
    }
    
    func initUI() {
        self.navigationController?.navigationBar.isHidden = true;
        timerResultLabel.text = LocalizedString.Main.warmingUp
        timerResultLabel.clipsToBounds = true
        timerStartButton.setTitle(LocalizedString.Main.start, for: .normal)
        timerStartButton.layer.cornerRadius = 4.0
        timerCountLabel.text = "\(timerNum)"
        countProgressBar.value = 0
    }
    
    func setTimerCount() {
        self.timerCountLabel.text = "\(timerNum)"
        if timerNum < 10 {
            //워밍업
            timerResultLabel.text = LocalizedString.Main.warmingUp
            stopSound()
        } else if timerNum >= 10 && timerNum <= 14 {
            //시작
            timerResultLabel.text = LocalizedString.Main.start
        } else {
            // X개!
            if timerNum % 5 == 0 {
                timerResultLabel.text = "\(exerciseNum)개!"
                playSound()
                exerciseNum += 1
            } else {
                stopSound()
            }
        }
     
        if timerNum == 60 {
            //끝
            if let timer = mTimer {
                timer.invalidate()
                mTimer = nil
            }
            timerNum = 0
            exerciseNum = 1
            timerResultLabel.text = LocalizedString.Main.finish
            stopSound()
        }
        countProgressBar.value = Double(timerNum) / Double(maxCount/10)
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
