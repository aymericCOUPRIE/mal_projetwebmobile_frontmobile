//
//  ZoneVM.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/31/21.
//

import Foundation
import SwiftUI

class ZoneVM : Identifiable {
    
    
    @ObservedObject private(set) var model : Zone
    
    var libelle : String {
        return model.zone_libelle
    }
    
    var games : [GameVM] {
        var games = [GameVM]()
        for game in model.jeux {
            games.append(GameVM(game))
        }
        return games
    }
    
    init(model : Zone) {
        self.model = model
    }
}
