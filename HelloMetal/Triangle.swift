//
//  Triangle.swift
//  HelloMetal
//
//  Created by Vlad Krupenko on 23.03.17.
//  Copyright © 2017 fixique. All rights reserved.
//

import Foundation
import Metal

class Triangle: Node {
    
    init(device: MTLDevice) {
        
        let V0 = Vertex(x: 0.0, y: 1.0, z: 0.0, r: 1.0, g: 0.0, b: 0.0, a: 1.0)
        let V1 = Vertex(x: -1.0, y: -1.0, z: 0.0, r: 0.0, g: 1.0, b: 0.0, a: 1.0)
        let V2 = Vertex(x: 1.0, y: -1.0, z: 0.0, r: 0.0, g: 0.0, b: 1.0, a: 1.0)
        
        let verticesArray = [V0, V1, V2]
        super.init(name: "Triangle", vertices: verticesArray, device: device)
    }
    
    override func updateWithDelta(delta: CFTimeInterval) {
        
        super.updateWithDelta(delta: delta)
        
        let secPerMove: Float = 6.0
        rotationY = sinf(Float(time) * 2.0 * Float(M_PI) / secPerMove)
        rotationX = sinf(Float(time) * 2.0 * Float(M_PI) / secPerMove)
    }
    
}
