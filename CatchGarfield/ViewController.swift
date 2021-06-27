//
//  ViewController.swift
//  CatchGarfield
//
//  Created by Oğulcan Evren on 27.06.2021.
//

import UIKit

class ViewController: UIViewController {
    
    //variables
    
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var score = 0
    var garfieldArray = [UIImageView]()
    var highScore = 0
    
    //views
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highestScoreLabel: UILabel!
    @IBOutlet weak var garfield1: UIImageView!
    @IBOutlet weak var garfield2: UIImageView!
    @IBOutlet weak var garfield3: UIImageView!
    @IBOutlet weak var garfield4: UIImageView!
    @IBOutlet weak var garfield5: UIImageView!
    @IBOutlet weak var garfield6: UIImageView!
    @IBOutlet weak var garfield7: UIImageView!
    @IBOutlet weak var garfield8: UIImageView!
    @IBOutlet weak var garfield9: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highestScoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highestScoreLabel.text = "Highscore: \(highScore)"
        }
        
        counter = 45
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideGarfield), userInfo: nil, repeats: true)
        
        
        //images
        
        garfield1.isUserInteractionEnabled = true
        garfield2.isUserInteractionEnabled = true
        garfield3.isUserInteractionEnabled = true
        garfield4.isUserInteractionEnabled = true
        garfield5.isUserInteractionEnabled = true
        garfield6.isUserInteractionEnabled = true
        garfield7.isUserInteractionEnabled = true
        garfield8.isUserInteractionEnabled = true
        garfield9.isUserInteractionEnabled = true
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))

        garfield1.addGestureRecognizer(recognizer1)
        garfield2.addGestureRecognizer(recognizer2)
        garfield3.addGestureRecognizer(recognizer3)
        garfield4.addGestureRecognizer(recognizer4)
        garfield5.addGestureRecognizer(recognizer5)
        garfield6.addGestureRecognizer(recognizer6)
        garfield7.addGestureRecognizer(recognizer7)
        garfield8.addGestureRecognizer(recognizer8)
        garfield9.addGestureRecognizer(recognizer9)
        
        garfieldArray = [garfield1,garfield2,garfield3,garfield4,garfield5,garfield6,garfield7,garfield8,garfield9]
        
        hideGarfield()
        

    }
    
    @objc func hideGarfield() {
        
        for garfield in garfieldArray{
            garfield.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(garfieldArray.count - 1)))
        garfieldArray[random].isHidden = false
        
    }
    
    @objc func increaseScore() {
        
        score += 1
        scoreLabel.text = "Score : \(score)"
        print("Caught")
    }
    
    @objc func countDown(){
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            print("Time's up!")
            timer.invalidate() // timer burada durur.
            hideTimer.invalidate()
            
            for garfield in garfieldArray{
                garfield.isHidden = true
            }
            
            if self.score > self.highScore{
                self.highScore = self.score
                highestScoreLabel.text = "High Score : \(self.highScore)"
                UserDefaults.standard.set(self.highScore,forKey: "highscore")
            }
            
            let alert = UIAlertController(title: "Time's up!", message: "Play Again?", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: .default) { (UIAlertAction) in
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 45
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideGarfield), userInfo: nil, repeats: true)
                
                
            
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
        print("timer")
    }


}

