//
//  ViewController.swift
//  CocoaHeadsDemo
//
//  Created by Kristian Trenskow on 24/02/16.
//  Copyright © 2016 trenskow.io. All rights reserved.
//

import UIKit
import Slaminate

class ViewController: UIViewController {
    
    @IBOutlet weak var cat: UIImageView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func growAnimation() -> Animation {
        return Slaminate(
            duration: 0.5,
            curve: Curve.easeOutBack,
            animation: {
                self.heightConstraint.constant *= 2.0
                self.widthConstraint.constant *= 2.0
            }
            ).completed({ animation in
                print("Grow complete")
            }
        )
    }
    
    func shrinkAnimation() -> Animation {
        return Slaminate(
            duration: 0.5,
            curve: Curve.easeInBack,
            animation: {
                self.heightConstraint.constant /= 2.0
                self.widthConstraint.constant /= 2.0
            }
            ).completed({ animation in
                print("Shrink complete")
            }
        )
    }

    @IBAction func growButtonTouchUpInside(sender: UIButton) {
        growAnimation()
    }
    
    @IBAction func shrinkButtonTouchUpInside(sender: UIButton) {
        shrinkAnimation()
    }
    
    @IBAction func growAndShrinkButtonTouchUpInside(sender: UIButton) {
        growAnimation().then(animation: shrinkAnimation())
            .completed({ _ in
                print("Both done")
            })
    }
    
}

