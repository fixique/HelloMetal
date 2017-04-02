//
//  Vertex.swift
//  HelloMetal
//
//  Created by Vlad Krupenko on 23.03.17.
//  Copyright © 2017 fixique. All rights reserved.
//

struct Vertex {
    var x, y, z: Float // Position data
    var r, g, b, a: Float // Color data 
    
    func floatBuffer() -> [Float] {
        return [x,y,z,r,g,b,a]
    }
}
