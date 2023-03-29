//
//  MainViewController.swift
//  Sloth
//
//  Created by JAEHA JU on 2023/03/29.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var timerStartButton: UIButton!
    @IBOutlet weak var timerCountLabel: UILabel!
    @IBOutlet weak var timerResultLabel: UILabel!
    var timer: Timer?
    var timerNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    @IBAction func timerStartButtonAction(_ sender: UIButton) {
        if timer != nil && timer!.isValid {
            timer!.invalidate()
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.setTimerCount()
        }
    }

    func initUI() {
        self.navigationController?.navigationBar.isHidden = true;
        timerStartButton.setTitle("vfv-ZI-Ulv.Start.button".localized(), for: .normal)
    }
    
    func setTimerCount() {
        self.timerCountLabel.text = "\(timerNum)"
        if timerNum >= 10 {
            timerResultLabel.text = "NuY-tw-7rt.Start!.label".localized()
        } else if timerNum < 10 {
            timerResultLabel.text = "NuY-tw-7rt.Warming up.label".localized()
        }
     
        if timerNum == 15 {
            timer?.invalidate()
            timer = nil
            timerNum = 0
            timerResultLabel.text = "NuY-tw-7rt.Finish!.label".localized()
        }
        timerNum += 1
    }
}

extension String {
    func localized(comment: String = "") -> String {
           return NSLocalizedString(self, comment: comment)
       }
}
