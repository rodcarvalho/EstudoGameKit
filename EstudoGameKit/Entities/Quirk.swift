//
//  Quirk.swift
//  EstudoGameKit
//
//  Created by Rodrigo Carvalho on 24/05/21.
//

import SpriteKit
import GameplayKit

class Quirk: GKEntity {
    
    init(team: Team, entityManager: EntityManager) {
        super.init()
        let texture = SKTexture(imageNamed: "quirk\(team.rawValue)")
        let spriteComponent = SpriteComponent(texture: texture)
        addComponent(spriteComponent)
        addComponent(TeamComponent(team: team))
        addComponent(MoveComponent(maxSpeed: 150, maxAcceleration: 5, radius: Float(texture.size().width * 0.3), entityManager: entityManager))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
