//
//  GameVM.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 23/03/2021.
//

import Foundation
import Combine

class GameVM : ObservableObject, Identifiable{
    
    private(set) var model : Game
    
    
    var titre : String {
        return model.j_titre
    }
    
    var duree : String {
        return model.j_duree
    }
    
    var ageMin : Int {
        return model.j_ageMin
    }
    
    var nbMaxJoueur : Int {
        return model.j_nbMaxJoueur
    }
    
    var nbMinJoueur : Int {
        return model.j_nbMinJoueurs
    }
    
    var typeJeu : String {
        return model.j_type
    }
    
    var editeur : String {
        return model.j_editor
    }

    init(_ game : Game) {
        self.model = game
    }
    
    
}
