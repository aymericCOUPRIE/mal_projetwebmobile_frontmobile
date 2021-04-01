//
//  FestivalGameListView.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 01/04/2021.
//

import SwiftUI

struct FestivalGameListView: View {
    
    @ObservedObject var listGamesVM : GameListVM
    
    var intent : GameListViewIntent
    var url : String = "http://localhost:3000/server/jeuxFestival/allGames"
    
    init(listGamesVM : GameListVM) {
        self.listGamesVM = listGamesVM
        self.intent = GameListViewIntent(gameList: listGamesVM)
        let _ = self.listGamesVM.$gameListState.sink(receiveValue: stateChanged)
    }
    
    
    private var listGameState : GameListState {
        return self.listGamesVM.gameListState
    }
    
    
    func stateChanged(state: GameListState){
        
        switch state {
        case .ready:
            self.intent.loadGameList(url : url)//au tout début je charge mes données
            break
        case .loading(url):
            print("I am loading GameList")
            break
        case .new:
            print("I have your GameList data!")
            break
          
        default:
            return
        }
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

/*
struct FestivalGameListView_Previews: PreviewProvider {
    static var previews: some View {
        FestivalGameListView()
    }
}
*/

