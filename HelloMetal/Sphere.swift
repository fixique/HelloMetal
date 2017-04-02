//
//  Sphere.swift
//  HelloMetal
//
//  Created by Vlad Krupenko on 23.03.17.
//  Copyright © 2017 fixique. All rights reserved.
//

import Foundation
import Metal

class Sphere: Node {
    
    var newVerticesArray = Array<Vertex>()
    var verticesArray = Array<Vertex>()
    var recursionLevel: Int = 3
    
    
    
    init(device: MTLDevice) {
        
        let t = (1.0 + sqrt(5.0)) / 2.0
        
        var A = Vertex(x: -1.0, y: Float(t), z: 0.0, r: 1.0, g: 0.0, b: 0.0, a: 1.0) // 0
        var length = sqrt(A.x * A.x + A.y * A.y + A.z * A.z)
        A = Vertex(x: A.x / length, y: A.y / length, z: A.z / length, r: 1.0, g: 0.0, b: 0.0, a: 1.0)
        var B = Vertex(x: 1.0, y: Float(t), z: 0.0, r: 0.0, g: 1.0, b: 0.0, a: 1.0) // 1
        length = sqrt(B.x * B.x + B.y * B.y + B.z * B.z)
        B = Vertex(x: B.x / length, y: B.y / length, z: B.z / length, r: 1.0, g: 0.0, b: 0.0, a: 1.0)

        var C = Vertex(x: -1.0, y: Float(-t), z: 0.0, r: 0.0, g: 0.0, b: 1.0, a: 1.0) // 2
        length = sqrt(C.x * C.x + C.y * C.y + C.z * C.z)
        C = Vertex(x: C.x / length, y: C.y / length, z: C.z / length, r: 1.0, g: 0.0, b: 0.0, a: 1.0)

        var D = Vertex(x: 1.0, y: Float(-t), z: 0.0, r: 0.1, g: 0.6, b: 0.4, a: 1.0) // 3
        length = sqrt(D.x * D.x + D.y * D.y + D.z * D.z)
        D = Vertex(x: D.x / length, y: D.y / length, z: D.z / length, r: 1.0, g: 0.0, b: 0.0, a: 1.0)

        
        var E = Vertex(x: 0.0, y: -1.0, z: Float(t), r: 1.0, g: 0.0, b: 0.0, a: 1.0) // 4
        length = sqrt(E.x * E.x + E.y * E.y + E.z * E.z)
        E = Vertex(x: E.x / length, y: E.y / length, z: E.z / length, r: 1.0, g: 0.0, b: 0.0, a: 1.0)

        var F = Vertex(x: 0.0, y: 1.0, z: Float(t), r: 0.0, g: 1.0, b: 0.0, a: 1.0) // 5
        length = sqrt(F.x * F.x + F.y * F.y + F.z * F.z)
        F = Vertex(x: F.x / length, y: F.y / length, z: F.z / length, r: 1.0, g: 0.0, b: 0.0, a: 1.0)


        var G = Vertex(x: 0.0, y: -1.0, z: Float(-t), r: 0.0, g: 0.0, b: 0.1, a: 1.0) // 6
        length = sqrt(G.x * G.x + G.y * G.y + G.z * G.z)
        G = Vertex(x: G.x / length, y: G.y / length, z: G.z / length, r: 1.0, g: 0.0, b: 0.0, a: 1.0)

        var H = Vertex(x: 0.0, y: 1.0, z: Float(-t), r: 0.1, g: 0.6, b: 0.4, a: 1.0) // 7
        length = sqrt(H.x * H.x + H.y * H.y + H.z * H.z)
        H = Vertex(x: H.x / length, y: H.y / length, z: H.z / length, r: 1.0, g: 0.0, b: 0.0, a: 1.0)
        
        var I = Vertex(x: Float(t), y: 0.0, z: -1.0, r: 1.0, g: 0.0, b: 0.0, a: 1.0) // 8
        length = sqrt(I.x * I.x + I.y * I.y + I.z * I.z)
        I = Vertex(x: I.x / length, y: I.y / length, z: I.z / length, r: 1.0, g: 0.0, b: 0.0, a: 1.0)

        var J = Vertex(x: Float(t), y: 0.0, z: 1.0, r: 0.0, g: 1.0, b: 0.0, a: 1.0) // 9
        length = sqrt(J.x * J.x + J.y * J.y + J.z * J.z)
        J = Vertex(x: J.x / length, y: J.y / length, z: J.z / length, r: 1.0, g: 0.0, b: 0.0, a: 1.0)

        var K = Vertex(x: Float(-t), y: 0.0, z: -1.0, r: 0.0, g: 0.0, b: 1.0, a: 1.0) // 10
        length = sqrt(K.x * K.x + K.y * K.y + K.z * K.z)
        K = Vertex(x: K.x / length, y: K.y / length, z: K.z / length, r: 1.0, g: 0.0, b: 0.0, a: 1.0)

        var L = Vertex(x: Float(-t), y: 0.0, z: 1.0, r: 0.1, g: 0.6, b: 0.4, a: 1.0) // 11
        length = sqrt(L.x * L.x + L.y * L.y + L.z * L.z)
        L = Vertex(x: L.x / length, y: L.y / length, z: L.z / length, r: 1.0, g: 0.0, b: 0.0, a: 1.0)
        
        
        verticesArray = [
            A,L,F, // 0, 11, 5
            A,F,B, // 0, 5, 1
            A,B,H, // 0, 1, 7
            A,H,K, // 0, 7, 10
            A,K,L, // 0, 10, 11
            B,F,J, // 1, 5, 9
            F,L,E, // 5, 11, 4
            L,K,C, // 11, 10, 2
            K,H,G, // 10, 7, 6
            H,B,I, // 7, 1, 8
            D,J,E, // 3, 9, 4
            D,E,C, // 3, 4, 2
            D,C,G, // 3, 2, 6
            D,G,I, // 3, 6, 8
            D,I,J, // 3, 8, 9
            E,J,F, // 4, 9, 5
            C,E,L, // 2, 4, 11
            G,C,K, // 6, 2, 10
            I,G,H, // 8, 6, 7
            J,I,B  // 9, 8, 1
        ]
        

        
        super.init(name: "Sphere", vertices: self.verticesArray, device: device)

        var currentVertice: Int = 0
        
        for _ in 0..<recursionLevel {
            
            for _ in 0..<verticesArray.count {
                
                
                if currentVertice == verticesArray.count {
                    continue
                }
                    let newOne: Vertex = getMiddlePoint(firstVertex: currentVertice, secondVertex: (currentVertice + 1))
                    let newTwo: Vertex = getMiddlePoint(firstVertex: (currentVertice + 1), secondVertex: (currentVertice + 2))
                    let newThree: Vertex = getMiddlePoint(firstVertex: (currentVertice + 2), secondVertex: currentVertice)
                    
                    newVerticesArray.append(verticesArray[currentVertice])
                    newVerticesArray.append(newOne)
                    newVerticesArray.append(newThree)
                    
                    newVerticesArray.append(verticesArray[currentVertice + 1])
                    newVerticesArray.append(newTwo)
                    newVerticesArray.append(newOne)
                    
                    newVerticesArray.append(verticesArray[currentVertice + 2])
                    newVerticesArray.append(newThree)
                    newVerticesArray.append(newTwo)
                    
                    newVerticesArray.append(newOne)
                    newVerticesArray.append(newTwo)
                    newVerticesArray.append(newThree)
                    
                    currentVertice += 3

                
            }
            verticesArray = newVerticesArray

        }
        
        
        var vertexData = Array<Float>()

        
        for vertex in verticesArray {
            vertexData += vertex.floatBuffer()
        }
        
        let dataSize = vertexData.count * MemoryLayout.size(ofValue: vertexData[0])
        super.vertexBuffer = super.device.makeBuffer(bytes: vertexData, length: dataSize, options: [])
        super.vertexCount = verticesArray.count

        
    }
    
    
    
    override func updateWithDelta(delta: CFTimeInterval) {
        
        super.updateWithDelta(delta: delta)
        
        let secPerMove: Float = 6.0
        rotationY = sinf(Float(time) * 2.0 * Float(M_PI) / secPerMove)
        rotationX = sinf(Float(time) * 2.0 * Float(M_PI) / secPerMove)
    }
    
    
    func getMiddlePoint(firstVertex: Int, secondVertex: Int) -> Vertex {
        
        let firstIsSmaller: Bool = firstVertex < secondVertex
        let smallerIndex = firstIsSmaller ? firstVertex : secondVertex
        let greaterIndex = firstIsSmaller ? secondVertex : firstVertex
        
        let pointOne = self.verticesArray[firstVertex]
        let pointTwo = self.verticesArray[secondVertex]
        let middlePoint = Vertex(x: (pointOne.x + pointTwo.x) / 2, y: (pointOne.y + pointTwo.y) / 2, z: (pointOne.z + pointTwo.z) / 2, r: 1.0, g: 0.0, b: 0.0, a: 1.0)
        
        let length = sqrt(middlePoint.x * middlePoint.x + middlePoint.y * middlePoint.y + middlePoint.z * middlePoint.z)
        let A = Vertex(x: middlePoint.x / length, y: middlePoint.y / length, z: middlePoint.z / length, r: 1.0, g: 0.0, b: 0.0, a: 1.0)
        
        return middlePoint
        
    }


    
}
