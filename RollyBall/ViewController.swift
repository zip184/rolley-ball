//
//  ViewController.swift
//  RollyBall
//
//  Created by Breton Tillinghast on 1/2/21.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    let rollyBox = RollyBox()
    let motionManager = CMMotionManager()
    
    @IBOutlet var boxView: UIImageView!
    @IBOutlet var ballView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initRollyBox()
        
        drawBox()
        drawBall()
        
        initMotion()
        
        Timer.scheduledTimer(withTimeInterval: Double(RollyConstants.refreshRate), repeats: true, block: { timer in
            self.drawBall()
            
            if let accelData = self.motionManager.accelerometerData {
                self.rollyBox.nextFrame(
                    timeDiffSeconds: RollyConstants.refreshRate,
                    xAccl: Float(accelData.acceleration.x),
                    yAccl: Float(accelData.acceleration.y)
                )
            }
        })
    }
    
    fileprivate func initRollyBox() {
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        let insets = UIApplication.shared.windows[0].safeAreaInsets
        let insetWidth = Float(screenWidth - (insets.left + insets.right))
        let insetHeight = Float(screenHeight - (insets.top + insets.bottom))
        
        let width = insetWidth - RollyConstants.boxMargin * 2
        let height = insetHeight - RollyConstants.boxMargin * 2
        
        let ballWidth = Float(ballView.frame.size.width)
        
        self.rollyBox.initBox(width: width, height: height, ballDiameter: ballWidth)
    }

    fileprivate func drawBox() {
        let insets = UIApplication.shared.windows[0].safeAreaInsets
        
        let width = CGFloat(rollyBox.width)
        let height = CGFloat(rollyBox.height)
        let x = CGFloat(RollyConstants.boxMargin) + insets.left
        let y = CGFloat(RollyConstants.boxMargin) + insets.top
        
        boxView.frame = CGRect(x:x, y:y, width: width, height: height)
    }
    
    fileprivate func drawBall() {
        let size = ballView.frame.size;
        
        let insets = UIApplication.shared.windows[0].safeAreaInsets
        let xStart = insets.left + CGFloat(RollyConstants.boxMargin)
        let yStart = insets.top + CGFloat(RollyConstants.boxMargin)
        
        let newPoint = CGPoint(x: xStart + CGFloat(rollyBox.ballPosX), y: yStart + CGFloat(rollyBox.ballPosY))
        ballView.frame = CGRect(origin: newPoint, size: size)
    }
    
    fileprivate func initMotion() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = Double(RollyConstants.refreshRate)
            motionManager.startAccelerometerUpdates()
        }
    }
}

