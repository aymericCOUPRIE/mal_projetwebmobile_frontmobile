//
//  GameIntent.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/31/21.
//

import Foundation
import SwiftUI

class GameListViewIntent {
    
    @ObservedObject var gameList : GameListVM
    
    init(gameList : GameListVM) {
        self.gameList = gameList
    }
    
    func httpJsonLoaded(result: Result<GameList,HttpRequestError>){
        switch result {
        case let .success(data):
       
            gameList.gameListState = .loaded(data)
        case let .failure(error):
            gameList.gameListState = .loadingError(error)
        }
    }
    
    func loadGameList(url: String) {
        gameList.gameListState = .loading(url)
        ServerHelper.loadGamesFromAPI(url: url, endofrequest: httpJsonLoaded)
    }
    
    
    
}
