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
    
    public private(set) var ballPosX = 100;
    public private(set) var ballPosY = 100;
    
    func initBox(width: Float, height: Float) {
        self.width = width;
        self.height = height;
    }
    
    func nextFrame() {
        ballPosX = ballPosX == 100 ? 200 : 100
    }
}
