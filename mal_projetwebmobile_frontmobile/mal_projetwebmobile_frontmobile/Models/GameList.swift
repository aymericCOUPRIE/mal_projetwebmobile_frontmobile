//
//  GameList.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/30/21.
//

import Foundation


class GameList : ObservableObject {
    
    
    private(set) var games : [Game]
    
    init(games: [Game]){
        self.games = games
    }
    
    func new(games: [Game]) {
        self.games = games
    }
}
