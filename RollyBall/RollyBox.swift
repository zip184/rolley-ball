//
//  RollyBox.swift
//  RollyBall
//
//  Created by Breton Tillinghast on 1/2/21.
//

import Foundation

class RollyBox {
    
    public private(set) var width : Float = -1;
    public private(set) var height : Float = -1;
    
    public private(set) var ballDiameter : Float = -1;
    
    public private(set) var ballPosX : Float = 0;
    public private(set) var ballPosY : Float = 0;
    
    // Units / Second
    fileprivate var ballVelocityX : Float = 80;
    fileprivate var ballVelocityY : Float = 110;
    
    func initBox(width: Float, height: Float, ballDiameter: Float) {
        self.width = width
        self.height = height
        self.ballDiameter = ballDiameter
    }
    
    func nextFrame(timeDiffSeconds : Float) {
        // Adjust velocities
        // TODO
        
        // Advance ball position
        let xDist = ballVelocityX * timeDiffSeconds
        let yDist = ballVelocityY * timeDiffSeconds
        ballPosX += xDist
        ballPosY += yDist
        
        // Check for bounces
        if (ballPosX + ballDiameter > width) {
            ballVelocityX *= -1
            ballPosX -= (ballPosX + ballDiameter - width) * 2
        } else if (ballPosX < 0.0) {
            ballVelocityX *= -1
            ballPosX *= -1
        }
        if (ballPosY + ballDiameter > height) {
            ballVelocityY *= -1
            ballPosY -= (ballPosY + ballDiameter - height) * 2
        } else if (ballPosY < 0.0) {
            ballVelocityY *= -1
            ballPosY *= -1
        }
    }
}
