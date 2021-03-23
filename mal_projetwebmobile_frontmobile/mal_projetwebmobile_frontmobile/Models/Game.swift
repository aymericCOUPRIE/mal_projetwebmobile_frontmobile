//
//  Game.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 23/03/2021.
//

import Foundation
import SwiftUI
import Combine


struct Game: Codable {
    private(set) var j_id: Int
    private(set) var j_titre: String
    private(set) var j_duree: String //PAS DE TYPE STRING
    private(set) var j_nbMaxJoueur: Int
    private(set) var j_nbMinJoueurs: Int
    private(set) var j_lienNotice: String
    
    private(set) var soc_nom: String
}


