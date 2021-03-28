//
//  SuiviJeu.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/28/21.
//

import Foundation


class SuiviJeu : ObservableObject, Identifiable, Equatable, Encodable {
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
