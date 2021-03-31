//
//  GameList.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/30/21.
//

import Foundation

protocol GameListDelegate {
    func newGameList()
}

class GameList : ObservableObject {
    
    var delegate: GameListDelegate?
    
    private(set) var games = [Game]()
    
    func new(games: [Game]) {
        self.games = games
        self.delegate?.newGameList()
    }
}
