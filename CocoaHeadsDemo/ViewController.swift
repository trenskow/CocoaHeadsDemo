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
    
    func rotateAnimation(left: Bool) -> Animation {
        return Slaminate(
            duration: 0.3,
            curve: Curve.easeInOutSine,
            animation: { _ in
                self.cat.transform = CGAffineTransformMakeRotation(
                    CGFloat(M_PI_2) + CGFloat(M_PI_2 * (left ? 1.0 : -1.0))
                )
            }
        ).completed({ _ in
            print("Rotate complete")
        })
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
    
    @IBAction func rotateLeftButtonTouchUpInside(sender: UIButton) {
        rotateAnimation(true)
    }
    
    @IBAction func rotateRightButtonTouchUpInside(sender: UIButton) {
        rotateAnimation(false)
    }
    
    @IBAction func rotateLeftAndRightButtonTouchUpInside(sender: UIButton) {
        rotateAnimation(true).then(animation: rotateAnimation(false))
    }
    
}

