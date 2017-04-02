//
//  ViewController.swift
//  HelloMetal
//
//  Created by Vlad Krupenko on 22.03.17.
//  Copyright © 2017 fixique. All rights reserved.
//

import UIKit
import Metal


class ViewController: UIViewController {
    
    var device: MTLDevice!
    var metalLayer: CAMetalLayer!
    var pipelineState: MTLRenderPipelineState!
    var commandQueue: MTLCommandQueue!
    var timer: CADisplayLink!
    var projectionMatrix: Matrix4!
    var lastFrameTimeStamp: CFTimeInterval = 0.0
    
    
    // Create a simple triangle buffer
    var objectToDraw: Cube!
    var triangleToDraw: Cube!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        projectionMatrix = Matrix4.makePerspectiveViewAngle(Matrix4.degrees(toRad: 85.0), aspectRatio: Float(self.view.bounds.size.width / self.view.bounds.size.height), nearZ: 0.01, farZ: 100.0)

        device = MTLCreateSystemDefaultDevice()
        
        
        metalLayer = CAMetalLayer()
        metalLayer.device = device // Specify the MTLDevice that the layer should use. Set this to the device
        metalLayer.pixelFormat = .bgra8Unorm // pixel format "8 bytes for Blue, Green, Red and Alpha"
        metalLayer.framebufferOnly = true
        metalLayer.frame = view.layer.frame // Set the frame of the layer to match the frame of the view
        view.layer.addSublayer(metalLayer) // add the layer as sublayer of the view's main layer
        
        // Get the size of the vertex data in bytes
        // Doing it by multiplyint the size of the first element by the count of elements in the array
        // Create a new buffer on the GPU, passing data frome the GPU
        // We pass empty array for default configuration
        
        objectToDraw = Cube(device: device)
//        objectToDraw.positionX = 0.0
//        objectToDraw.positionY = 0.0
//        objectToDraw.positionZ = -2.0
//        objectToDraw.rotationZ = Matrix4.degrees(toRad: 45)
//        objectToDraw.scale = 0.5
        
//        triangleToDraw = Cube(device: device)
//        triangleToDraw.positionX = 10.0
//        triangleToDraw.positionY = 10.0
//        triangleToDraw.positionZ = -20.0
    
        
        let defaultLibrary = device.newDefaultLibrary()!
        let fragmentProgram = defaultLibrary.makeFunction(name: "basic_fragment")
        let vertexProgram = defaultLibrary.makeFunction(name: "basic_vertex")
        
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.vertexFunction = vertexProgram
        pipelineStateDescriptor.fragmentFunction = fragmentProgram
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        pipelineState = try! device.makeRenderPipelineState(descriptor: pipelineStateDescriptor)
        
        commandQueue = device.makeCommandQueue()
        
        timer = CADisplayLink(target: self, selector: #selector(ViewController.newFrame(displayLink:)))
        timer.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    func render() {
        guard let drawable = metalLayer?.nextDrawable() else { return }
        let worldModelMatrix = Matrix4()
        worldModelMatrix.translate(0.0, y: 0.0, z: -7.0)
        worldModelMatrix.rotateAroundX(Matrix4.degrees(toRad: 25), y: 0.0, z: 0.0)
        
        objectToDraw.render(commandQueue: commandQueue, pipelineState: pipelineState, drawable: drawable, parentModelViewMatrix: worldModelMatrix, projectionMatrix: projectionMatrix ,clearColor: nil)
        
//        guard let drawableNext = metalLayer?.nextDrawable() else { return }
//        let worldModelMatrixNext = Matrix4()
//        worldModelMatrixNext.translate(0.0, y: 0.0, z: -20.0)
//        worldModelMatrixNext.rotateAroundX(Matrix4.degrees(toRad: 25), y: 0.0, z: 0.0)
//        
//        triangleToDraw.render(commandQueue: commandQueue, pipelineState: pipelineState, drawable: drawableNext, parentModelViewMatrix: worldModelMatrixNext, projectionMatrix: projectionMatrix, clearColor: nil)
    }
    
    func newFrame(displayLink: CADisplayLink) {
        
        if lastFrameTimeStamp == 0.0 {
            lastFrameTimeStamp = displayLink.timestamp
        }
        
        let elapsed: CFTimeInterval = displayLink.timestamp - lastFrameTimeStamp
        lastFrameTimeStamp = displayLink.timestamp
        
        gameloop(timeSinceLastUpdate: elapsed)
    }
    
    func gameloop(timeSinceLastUpdate: CFTimeInterval) {
        
        objectToDraw.updateWithDelta(delta: timeSinceLastUpdate)
        
        autoreleasepool {
            self.render()
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

