//
//  MoveBehavior.swift
//  EstudoGameKit
//
//  Created by Rodrigo Carvalho on 24/05/21.
//

import GameplayKit
import SpriteKit

// Behavior que que cria o comportamento de movimento
// Os behaviors possuem um conjuto de goals
class MoveBehavior: GKBehavior {
    
    // Os goals são setados através de um setWeight quanto maior o peso, maior a prioridade do goal
    init(targetSpeed: Float, seek: GKAgent, avoid: [GKAgent]) {
        super.init()
        // Verifica se a velocidade do Agent é menor que 0
        if targetSpeed > 0 {
            setWeight(0.1, for: GKGoal(toReachTargetSpeed: targetSpeed))
            // Peso baixo
            setWeight(0.5, for: GKGoal(toSeekAgent: seek))
            // Peso médio
            setWeight(1.0, for: GKGoal(toAvoid: avoid, maxPredictionTime: 1.0))
            // Peso alto
        }
    }
}
