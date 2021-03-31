//
//  SuiviJeu.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 31/03/2021.
//

import Foundation

class SuiviJeu : ObservableObject{
    static func == (lhs: SuiviJeu, rhs: SuiviJeu) -> Bool {
        return lhs.suivJ_id == rhs.suivJ_id
    }
    
    private(set) var suivJ_id: Int
    private(set) var game : Game
    //private(set) var editor: Editor
    private(set) var zone : Zone
    
    init(suivJ_id: Int, game: Game, zone : Zone) {
        self.suivJ_id = suivJ_id
        self.game = game
        self.zone = zone
    }
}
