//
//  Game.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 23/03/2021.
//

import Foundation

class Game: Identifiable, ObservableObject, Encodable, Equatable {
    
    static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.j_id == rhs.j_id
    }
    
    
    
    private(set) var j_id: Int
    /*private(set) var j_titre: String
    private(set) var j_duree: String //PAS DE TYPE STRING
    private(set) var j_nbMaxJoueur: Int
    private(set) var j_nbMinJoueurs: Int
    private(set) var j_lienNotice: String*/
    private(set) var j_editor : Editor
    private(set) var j_type : TypeJeu
    
    //private(set) var soc_nom: String
    
    init(j_id: Int/*, j_titre: String, j_duree: String ,j_nbMaxJoueur: Int, j_nbMinJoueurs: Int, j_lienNotice: String*/) {
        self.j_id = j_id
        /*self.j_titre = j_titre
        self.j_duree = j_duree
        self.j_nbMaxJoueur = j_nbMaxJoueur
        self.j_nbMinJoueurs = j_nbMinJoueurs
        self.j_lienNotice = j_lienNotice*/
    }
}


