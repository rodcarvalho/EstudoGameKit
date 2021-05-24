//
//  TeamComponent.swift
//  EstudoGameKit
//
//  Created by Rodrigo Carvalho on 23/05/21.
//

import SpriteKit
import GameplayKit


//Esse componente usa uma enum para definir qual o time da entidade
enum Team: Int {
    case team1 = 1
    case team2 = 2
    
    static let allVallues = [team1,team2]
    
    //Função que ajuda a retornar o time adversário mais fácilmente
    func oppositeTeam() -> Team {
        switch self {
        case .team1:
            return .team2
        case .team2:
            return .team1
        }
    }
}

class TeamComponent: GKComponent {
    
    let team: Team
    
    init(team: Team) {
        self.team = team
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
