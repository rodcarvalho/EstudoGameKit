//
//  SpriteComponent.swift
//  EstudoGameKit
//
//  Created by Rodrigo Carvalho on 23/05/21.
//

import SpriteKit
import GameplayKit

//Esse component adiciona um SpriteNode na entidade

//Todas as entidades com sprite, precisam desse componente
class SpriteComponent: GKComponent {
    
    let node: SKSpriteNode
    
    init(texture: SKTexture) {
        node = SKSpriteNode(texture: texture, color: .white, size: texture.size())
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 }
