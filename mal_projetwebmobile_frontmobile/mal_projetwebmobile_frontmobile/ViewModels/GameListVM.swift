//
//  GameListVM.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/31/21.
//

import Foundation

enum GameListState {
    case ready
    case loading(String)
    case loaded(GameList)
    case loadingError(Error)
    case new(GameList)
    
    var description: String{
        switch self {
            case .ready                   : return "ready"
            case .loading(let s)          : return "loading: \(s)"
            case .loaded(let games)     : return "loaded: \(games) editors"
            case .loadingError(let error) : return "loadingError: Error loading -> \(error)"
            case .new(let games) : return "games are ready \(games)"
        }
    }
}

class GameListVM : ObservableObject{

    private(set) var model : GameList

    @Published var gameListState : GameListState = .ready {
        didSet {
            //data -- tableau d'editor
            switch self.gameListState {
            case .loaded(let data):
                self.model.new(games: data.games)
            case .loadingError:
                print("LOADING ERROR")
            default:
                return
            }
        }
    }

    init(gameList: GameList) {
        self.model = gameList
    }

}
