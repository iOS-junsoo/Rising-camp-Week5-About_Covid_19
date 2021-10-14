//
//  secondViewController.swift
//  About-Covid-19
//
//  Created by 준수김 on 2021/10/13.
//

import UIKit
import MarqueeLabel

class secondViewController: UIViewController {

    @IBOutlet weak var marqueeLabel: MarqueeLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.marqueeLabel.type = .continuous
        self.marqueeLabel.speed = .duration(15)
        self.marqueeLabel.animationCurve = .easeInOut
        self.marqueeLabel.fadeLength = 10.0
        self.marqueeLabel.leadingBuffer = 30.0
        
        let strings = ["오늘의 총 백신 접종자 수는 1차: 3302,312명 2차: 2134,322명 3차: 512명 입니다. 오늘도 모두 힘내세요."]
        
        self.marqueeLabel.text = strings[Int(arc4random_uniform(UInt32(strings.count)))]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
