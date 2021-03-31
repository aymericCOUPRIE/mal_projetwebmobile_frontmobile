//
//  GameVM.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 23/03/2021.
//

import Foundation
import SwiftUI




class GameVM : ObservableObject {
    
    @ObservedObject private(set) var model : Game
    
    var j_id: Int {
        return model.j_id
    }
    
    init(model: Game) {
        self.model = model
    }
   
    
    
}
