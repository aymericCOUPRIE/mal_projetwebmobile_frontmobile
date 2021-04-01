//
//  GameListView.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 23/03/2021.
//

import SwiftUI


struct GameListView: View {
    //pour la barre de recherche
    @State private var searchText = ""
    
    var gameList : GameList

   
    var body: some View {
        ZStack{
            VStack{
                GameListeTitlePage()
                SearchBar(text: $searchText)
                    .padding(.top, -20)
                    List{
                        ForEach(gameList.games.filter({
                            searchText.isEmpty ? true :
                                $0.j_titre.lowercased().contains(searchText.lowercased())
                        })){
                            game in
                            NavigationLink(
                                destination:
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
        }
    }
}

struct GameListeTitlePage : View {
    var body: some View{
        return Text("Liste des jeux")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
            .foregroundColor(Color.init(red: 0/255, green: 32/255, blue: 101/255))
            .padding(.top, 10)
    }
}
/*
struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListView()
    }
}
*/
