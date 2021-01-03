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
    fileprivate var ballVelocityX : Float = 0;
    fileprivate var ballVelocityY : Float = 0;
    
    func initBox(width: Float, height: Float, ballDiameter: Float) {
        self.width = width
        self.height = height
        self.ballDiameter = ballDiameter
        
        // Center ball
        ballPosX = width / 2 - ballDiameter / 2
        ballPosY = height / 2 - ballDiameter / 2
    }
    
    func nextFrame(timeDiffSeconds : Float, xAccl: Float, yAccl: Float) {
        // Adjust velocities
        adjustTilt(xAccl: xAccl, yAccl: yAccl)
        applyFriction()
        
        // Advance ball position
        let xDist = ballVelocityX * timeDiffSeconds
        let yDist = ballVelocityY * timeDiffSeconds
        ballPosX += xDist
        ballPosY += yDist
        
        // Check for bounces
        if (ballPosX + ballDiameter > width) {
            ballVelocityX *= -1 * RollyConstants.wallBounceSpeedDropFactor
            ballPosX -= (ballPosX + ballDiameter - width) * 2
        } else if (ballPosX < 0.0) {
            ballVelocityX *= -1 * RollyConstants.wallBounceSpeedDropFactor
            ballPosX *= -1
        }
        if (ballPosY + ballDiameter > height) {
            ballVelocityY *= -1 * RollyConstants.wallBounceSpeedDropFactor
            ballPosY -= (ballPosY + ballDiameter - height) * 2
        } else if (ballPosY < 0.0) {
            ballVelocityY *= -1 * RollyConstants.wallBounceSpeedDropFactor
            ballPosY *= -1
        }
    }
    
    fileprivate func applyWallBounceVelocity(velocity: Float) -> Float {
        // Apply speed drop factor
        var newVelocity = velocity * RollyConstants.wallBounceSpeedDropFactor
        
        // Apply speed drop constant
        if (newVelocity > RollyConstants.wallBounceSpeedDropConstant) {
            newVelocity -= RollyConstants.wallBounceSpeedDropConstant
        } else if (newVelocity < RollyConstants.wallBounceSpeedDropConstant) {
            newVelocity += RollyConstants.wallBounceSpeedDropConstant
        } else {
            // The distance from zero is less than the constant, so set it to zero
            newVelocity = 0
        }
        
        return newVelocity
    }
    
    fileprivate func adjustTilt(xAccl: Float, yAccl: Float) {
        ballVelocityX += xAccl * RollyConstants.tiltAccelFactor
        ballVelocityY += yAccl * RollyConstants.tiltAccelFactor * -1
    }
    
    fileprivate func applyFriction() {
        ballVelocityX *= RollyConstants.frictionFactor
        ballVelocityY *= RollyConstants.frictionFactor
    }
}
