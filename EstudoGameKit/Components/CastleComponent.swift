//
//  CastleComponent.swift
//  EstudoGameKit
//
//  Created by Rodrigo Carvalho on 24/05/21.
//

import SpriteKit
import GameplayKit

class CastleComponent: GKComponent {

  //Esse é o componente do Castelo, reponsável por incrementar e armazenar as moedas
  var coins = 0
  var lastCoinDrop = TimeInterval(0)

  override init() {
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // Função de update utilizando o time interval
  override func update(deltaTime seconds: TimeInterval) {
    super.update(deltaTime: seconds)
  
  // Ganho de moedas de acordo com o time interval
    let coinDropInterval = TimeInterval(0.5)
    let coinsPerInterval = 10
    if (CACurrentMediaTime() - lastCoinDrop > coinDropInterval) {
      lastCoinDrop = CACurrentMediaTime()
      coins += coinsPerInterval
    }
  }
}
