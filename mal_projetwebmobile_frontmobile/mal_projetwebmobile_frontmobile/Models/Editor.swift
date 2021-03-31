//
//  Editeur.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/23/21.
//

import Foundation


class Editor : Identifiable, ObservableObject {
    

    private(set) var nomEditeur: String
    private(set) var games: [Game]
    
    init(nomEditeur: String, games: [Game]) {
        self.nomEditeur = nomEditeur
        self.games = games
    }
       
}
