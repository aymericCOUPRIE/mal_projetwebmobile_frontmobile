//
//  GameVM.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 23/03/2021.
//

import Foundation
import Combine

class GameVM : ObservableObject {
    
    private(set) var model : Game
    

    init(_ game : Game) {
        self.model = game
    }
    
    
}
