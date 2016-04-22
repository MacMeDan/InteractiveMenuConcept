//: Playground - noun: a place where people can play

import UIKit
import SpriteKit
import XCPlayground

let gameWidth = 600
let gameHeight = 800

class Scene: SKScene {
    var sprite = SKShapeNode()
    var buttons = [SKShapeNode]()
    
    override init(size: CGSize) {
        super.init(size: size)
        
        physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        setupButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButtons(){
        let centerX = CGFloat(gameWidth/2)
        let centerY = CGFloat(gameHeight * 2/3)
        let buttonRadius = CGFloat(40)
        createButton("Schedule", position: CGPointMake(centerX, centerY), radius: buttonRadius)
        createButton("Patients", position: CGPointMake(centerX - 90, centerY - 90), radius: buttonRadius)
        createButton("Settings", position: CGPointMake(centerX + 90, centerY - 90), radius: buttonRadius)
        
    }
    
    func createButton(name: String, position: CGPoint, radius: CGFloat){
        sprite = SKShapeNode(circleOfRadius: radius)
        let label = SKLabelNode(text: name)
        sprite.addChild(label)
        sprite.fillColor = UIColor.blueColor()
        sprite.strokeColor = UIColor.clearColor()
        let physicsBody = SKPhysicsBody(circleOfRadius: radius)
        sprite.physicsBody = physicsBody
        sprite.physicsBody?.affectedByGravity = false
        physicsBody.restitution = 0.5
        sprite.name = name
        
        addChild(sprite)
        buttons.append(sprite)
        sprite.position = position
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            touch.locationInNode(self)
            for button in buttons {
                
                if button.containsPoint(touch.locationInNode(self)){
                    let buttonName = button.name
                    print("touched \(buttonName)")
                }
            }
            
            let anotherSprite = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 30, height: 30))
            
            
            let physicsBody = SKPhysicsBody(rectangleOfSize: anotherSprite.size)
            physicsBody.restitution = 0.5
            anotherSprite.physicsBody = physicsBody
            anotherSprite.physicsBody?.affectedByGravity = true
            physicsBody.velocity = CGVectorMake(1, 0.2)
            
            addChild(anotherSprite)
            anotherSprite.position = touch.locationInNode(self)
        }
    }
}

let skView = SKView(frame: CGRect(x: 0, y: 0, width: gameWidth, height: gameHeight))
skView.showsNodeCount = true
skView.showsFPS = true
let scene = Scene(size: CGSize(width: gameWidth, height: gameHeight))

skView.presentScene(scene)

XCPlaygroundPage.currentPage.liveView = skView
