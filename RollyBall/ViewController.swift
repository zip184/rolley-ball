//
//  ViewController.swift
//  RollyBall
//
//  Created by Breton Tillinghast on 1/2/21.
//

import UIKit

class ViewController: UIViewController {

    var rollyBox = RollyBox();
    
    @IBOutlet var boxView: UIImageView!
    @IBOutlet var ballView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initRollyBox()
        drawBox()
        drawBall()
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            print("Next frame " + timer.timeInterval.description)
            self.rollyBox.nextFrame()
            self.drawBall()
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
        
        self.rollyBox.initBox(width: width, height: height)
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
        
        let newPoint = CGPoint(x: CGFloat(rollyBox.ballPosX), y: CGFloat(rollyBox.ballPosY))
        ballView.frame = CGRect(origin: newPoint, size: size)
    }
}

