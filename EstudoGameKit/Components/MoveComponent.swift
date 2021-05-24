//
//  MoveComponent.swift
//  EstudoGameKit
//
//  Created by Rodrigo Carvalho on 24/05/21.
//

import SpriteKit
import GameplayKit

// GKAgent2D é uma subclasse do GKComponents responsável por objetos em movimento, são eles que recebem os behaviors
class MoveComponent: GKAgent2D, GKAgentDelegate {
    
    // Referencia do entityManager para acessar outras entidades do jogo
    let entityManager: EntityManager
    
    // Propriedades de movimento do agent e delegate
    init(maxSpeed: Float, maxAcceleration: Float, radius: Float, entityManager: EntityManager) {
        self.entityManager = entityManager
        super.init()
        delegate = self
        self.maxSpeed = maxSpeed
        self.maxAcceleration = maxAcceleration
        self.radius = radius
        print(self.mass)
        self.mass = 0.01
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Se prepara para atualizara posição do agent
    func agentWillUpdate(_ agent: GKAgent) {
        guard let spriteComponent = entity?.component(ofType: SpriteComponent.self) else {
            return
        }
        
        position = SIMD2<Float>(spriteComponent.node.position)
    }
    
    // Atualiza a posição da sprite em relação ao agent
    func agentDidUpdate(_ agent: GKAgent) {
        guard let spriteComponent = entity?.component(ofType: SpriteComponent.self) else {
            return
        }
        
        spriteComponent.node.position = CGPoint(position)
    }
    
    func closestMoveComponent(for team: Team) -> GKAgent2D? {
        
        var closestMoveComponent: MoveComponent? = nil
        var closestDistance = CGFloat(0)
        
        let enemyMoveComponents = entityManager.moveComponents(for: team)
        for enemyMoveComponent in enemyMoveComponents {
            let distance = (CGPoint(enemyMoveComponent.position) - CGPoint(position)).length()
            if closestMoveComponent == nil || distance < closestDistance {
                closestMoveComponent = enemyMoveComponent
                closestDistance = distance
            }
        }
        return closestMoveComponent
        
    }
    
    //Encontra o inimigo mais próximo
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        guard let entity = entity,
              let teamComponent = entity.component(ofType: TeamComponent.self) else {
            return
        }
        
        guard let enemyMoveComponent = closestMoveComponent(for: teamComponent.team.oppositeTeam()) else {
            return
        }
        
        let alliedMoveComponents = entityManager.moveComponents(for: teamComponent.team)
        
        behavior = MoveBehavior(targetSpeed: maxSpeed, seek: enemyMoveComponent, avoid: alliedMoveComponents)
    }
}
