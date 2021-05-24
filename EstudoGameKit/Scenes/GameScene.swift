//
//  GameScene.swift
//  EstudoGameKit
//
//  Created by Rodrigo Carvalho on 21/05/21.
//
// TUTORIAL BASE: https://www.raywenderlich.com/706-gameplaykit-tutorial-entity-component-system-agents-goals-and-behaviors
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entityManager : EntityManager!
    var label: SKLabelNode = SKLabelNode()
    private var lastUpdateTime : TimeInterval = 0
    
    // Constants
    let margin = CGFloat(30)
    
    // Buttons
    var quirkButton: ButtonNode!
    var zapButton: ButtonNode!
    var munchButton: ButtonNode!
    
    // Labels
    let coin1Label = SKLabelNode(fontNamed: "Courier-Bold")
    let coin2Label = SKLabelNode(fontNamed: "Courier-Bold")
    
    // Game over detection
    var gameOver = false
    
    let path = UIBezierPath()
    
    override func sceneDidLoad() {
        
        self.lastUpdateTime = 0
        
        entityManager = EntityManager(scene: self)
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addQuadCurve(to: CGPoint(x: 800, y: 0), controlPoint: CGPoint(x: size.height/2, y: size.width/2))
    }
    
    override func didMove(to view: SKView) {
        
        print("scene size: \(size)")
        
        // Start background music
        let bgMusic = SKAudioNode(fileNamed: "Latin_Industries.mp3")
        bgMusic.autoplayLooped = true
        addChild(bgMusic)
        
        // Add background
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.zPosition = -1
        addChild(background)
        
        // Add quirk button
        quirkButton = ButtonNode(iconName: "quirk1", text: "10", onButtonPress: quirkPressed)
        quirkButton.position = CGPoint(x: size.width * 0.25, y: margin + quirkButton.size.height / 2)
        addChild(quirkButton)
        
        // Add zap button
        zapButton = ButtonNode(iconName: "zap1", text: "25", onButtonPress: zapPressed)
        zapButton.position = CGPoint(x: size.width * 0.5, y: margin + zapButton.size.height / 2)
        addChild(zapButton)
        
        // Add munch button
        munchButton = ButtonNode(iconName: "munch1", text: "50", onButtonPress: munchPressed)
        munchButton.position = CGPoint(x: size.width * 0.75, y: margin + munchButton.size.height / 2)
        addChild(munchButton)
        
        // Add coin 1 indicator
        let coin1 = SKSpriteNode(imageNamed: "coin")
        coin1.position = CGPoint(x: margin + coin1.size.width/2, y: size.height - margin - coin1.size.height/2)
        addChild(coin1)
        coin1Label.fontSize = 50
        coin1Label.fontColor = SKColor.black
        coin1Label.position = CGPoint(x: coin1.position.x + coin1.size.width/2 + margin, y: coin1.position.y)
        coin1Label.zPosition = 1
        coin1Label.horizontalAlignmentMode = .left
        coin1Label.verticalAlignmentMode = .center
        coin1Label.text = "10"
        self.addChild(coin1Label)
        
        // Add coin 2 indicator
        let coin2 = SKSpriteNode(imageNamed: "coin")
        coin2.position = CGPoint(x: size.width - margin - coin1.size.width/2, y: size.height - margin - coin1.size.height/2)
        addChild(coin2)
        coin2Label.fontSize = 50
        coin2Label.fontColor = SKColor.black
        coin2Label.position = CGPoint(x: coin2.position.x - coin2.size.width/2 - margin, y: coin1.position.y)
        coin2Label.zPosition = 1
        coin2Label.horizontalAlignmentMode = .right
        coin2Label.verticalAlignmentMode = .center
        coin2Label.text = "10"
        self.addChild(coin2Label)
        
        entityManager = EntityManager(scene: self)
        
        let humanCastle = Castle(imageName: "castle1_atk", team: .team1, entityManager: entityManager)
        if let spriteComponent = humanCastle.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: spriteComponent.node.size.width/2, y: size.height/2)
        }
        entityManager.add(humanCastle)
        
        let aiCastle = Castle(imageName: "castle2_atk", team: .team2, entityManager: entityManager)
        if let spriteComponent = aiCastle.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: size.width - spriteComponent.node.size.width/2, y: size.height/2)
        }
        entityManager.add(aiCastle)
        
        let sol = Sun(imageName: "sol", entityManager: entityManager)
        if let spriteComponent = sol.component(ofType: SpriteComponent.self){
            spriteComponent.node.position = CGPoint(x: 0, y: 0)
        }
        entityManager.add(sol)
        
        sol.component(ofType: SpriteComponent.self)?.node.run(SKAction.follow(path.cgPath, duration: 10.0))
        
    }
    
    func quirkPressed() {
        print("Quirk pressed!")
        entityManager.spawnQuirk(team: .team1)
    }
    
    func zapPressed() {
        print("Zap pressed!")
    }
    
    func munchPressed() {
        print("Munch pressed!")
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        
    }
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    
    }
    
    func touchUp(atPoint pos : CGPoint) {
        print("Apertou")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        print("\(touchLocation)")
        
        if gameOver {
            let newScene = GameScene(size: size)
            newScene.scaleMode = scaleMode
            view?.presentScene(newScene, transition: SKTransition.flipHorizontal(withDuration: 0.5))
            return
        }
    }
    
    func showRestartMenu(_ won: Bool) {
        
        if gameOver {
            return;
        }
        gameOver = true
        
        let message = won ? "You win" : "You lose"
        
        let label = SKLabelNode(fontNamed: "Courier-Bold")
        label.fontSize = 100
        label.fontColor = SKColor.black
        label.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        label.zPosition = 1
        label.verticalAlignmentMode = .center
        label.text = message
        label.setScale(0)
        addChild(label)
        
        let scaleAction = SKAction.scale(to: 1.0, duration: 0.5)
        scaleAction.timingMode = SKActionTimingMode.easeInEaseOut
        label.run(scaleAction)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        
        
        self.lastUpdateTime = currentTime
        
        entityManager.update(dt)
        
        if let human = entityManager.castle(for: .team1),
           let humanCastle = human.component(ofType: CastleComponent.self) {
            coin1Label.text = "\(humanCastle.coins)"
        }
        if let ai = entityManager.castle(for: .team2),
           let aiCastle = ai.component(ofType: CastleComponent.self) {
            coin2Label.text = "\(aiCastle.coins)"
        }
    }
}
