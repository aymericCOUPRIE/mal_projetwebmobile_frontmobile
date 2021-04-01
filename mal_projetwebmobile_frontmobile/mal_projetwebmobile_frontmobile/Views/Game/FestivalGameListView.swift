//
//  FestivalGameListView.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 01/04/2021.
//

import SwiftUI

struct FestivalGameListView: View {
    //pour la barre de recherche
    @State private var searchText = ""
    
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
        //GameListView(gameList: GameList(games: listGamesVM.model.games))
        ZStack {
            
            VStack {
                NavigationView{
                    VStack{
                        GameListeTitlePage()
                        SearchBar(text: $searchText)
                            .padding(.top, -20)
                        List{
                            ForEach(listGamesVM.model.games.filter({
                                searchText.isEmpty ? true :
                                    $0.j_titre.lowercased().contains(searchText.lowercased())
                            })){  game in
                                NavigationLink(
                                    destination :
                                        GameDetails(game: game)
                                ){
                                        VStack{
                                            HStack{
                                                Text("\(game.j_titre)")
                                    
                                            }
                                        }
                                }
                            }
                        }
                    }
                }.navigationViewStyle(StackNavigationViewStyle())
                ErrorViewGame(state: listGameState)
            }
        }
    }
}

struct  ErrorViewGame : View{
    let state : GameListState
    var body: some View{
        VStack{
            Spacer()
            switch state{
            case .loading:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(3)
            case .loadingError(let error):
                ErrorMessage(error: error)
            default:
                EmptyView()
            }
            if case let .loaded(data) = state{
                Text("\(data.games.count) jeu(x) trouvée! ");
            }
            Spacer()
        }
    }
}

/*
struct FestivalGameListView_Previews: PreviewProvider {
    static var previews: some View {
        FestivalGameListView()
    }
}
*/

