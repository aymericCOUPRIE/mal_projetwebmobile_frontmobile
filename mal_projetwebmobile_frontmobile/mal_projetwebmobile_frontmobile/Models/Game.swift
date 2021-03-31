//
//  Game.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 23/03/2021.
//

import Foundation

class Game : ObservableObject {
    
    private(set) var j_titre: String
    private(set) var j_duree: String
    private(set) var j_nbMaxJoueur: Int
    private(set) var j_nbMinJoueurs: Int
    //private(set) var j_lienNotice: String
    private(set) var j_editor : String
    private(set) var j_type : String

    
    init(j_titre: String, j_duree: String ,j_nbMaxJoueur: Int, j_nbMinJoueurs: Int, /*j_lienNotice: String,*/ j_editor: String, j_type : String) {
      
        self.j_titre = j_titre
        self.j_duree = j_duree
        self.j_nbMaxJoueur = j_nbMaxJoueur
        self.j_nbMinJoueurs = j_nbMinJoueurs
        //self.j_lienNotice = j_lienNotice
        self.j_type = j_type
        self.j_editor = j_editor
    }
    
    
    
}


