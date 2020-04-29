//
//  GameScene.swift
//  DiveIntoSpriteKit
//
//  Created by Paul Hudson on 16/10/2017.
//  Copyright © 2017 Paul Hudson. All rights reserved.
//

import SpriteKit

class Person {
    
    // MARK: Properties
    var hairColor : String
    var age: Int
    
    // MARK: Initializers
    init(hairColor: String, age: Int) {
        self.hairColor = hairColor
        self.age = age
    }
    
    // MARK: Methods
    
    // Purpose: Increase the age by one
    func birthday() {
        age += 1
    }
    
}



@objcMembers
class GameScene: SKScene {
    
    // MARK: Properties
    var touchingPlayer = false
    let player = SKSpriteNode(imageNamed: "player-rocket.png")
    var gameTimer: Timer?
    
    
    // MARK: Initializers
    
    
    // MARK: Methods
    override func didMove(to view: SKView) {
        // this method is called when your game scene is ready to run
        //Add and position space background in scene 
        let background = SKSpriteNode(imageNamed: "space.jpg")
        background.zPosition = -1
        addChild(background)
        
        //Add space dust particles to scene
        if let particles = SKEmitterNode(fileNamed: "SpaceDust") {
            particles.advanceSimulationTime(10)
            particles.position.x = 512
            addChild(particles)
            
            //Add player to scene
            
            
            player.position.x = -400 
            player.zPosition = 1
            addChild(player)
            
        }
        
            //Create timer to call function create enemy every 35 seconds
            gameTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // this method is called when the user touches the screen
        //Find the first touch on the screen
        guard let touch = touches.first else {
            return }
        
        //Find the location of touch in game scene
        let location = touch.location(in: self)
        
        //Find the list of nodes in location
        let tappedNodes = nodes(at: location)
        
        //If the player is tapped set touching player to true
        if tappedNodes.contains(player) {
            touchingPlayer = true
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //If touchingPlayer is false then return
        guard touchingPlayer else { return }
        guard let touch = touches.first else { return }
        
        //If the player's touch is read correctly find touch's location in scene and set player position to that location
        let location = touch.location(in: self)
        player.position = location
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // this method is called when the user stops touching the screen
        touchingPlayer = false
    }
    
    override func update(_ currentTime: TimeInterval) {
        // this method is called before each frame is rendered
    }
    
    func createEnemy() {
        //Add and position enemy ship in scene
        let sprite = SKSpriteNode(imageNamed: "enemy-ship")
        print(self.size.height)
        sprite.position = CGPoint(x: 1200, y: Int.random(in: -350...350))
        sprite.name = "enemy"
        sprite.zPosition = 1
        addChild(sprite)
        
        //Add physics body to sprite
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        sprite.physicsBody?.linearDamping = 0
        
    }
    
    
}

