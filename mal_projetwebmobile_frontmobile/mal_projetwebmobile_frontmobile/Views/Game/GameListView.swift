//
//  GameListView.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 23/03/2021.
//

import SwiftUI


struct GameListView: View {
    
    var gameList : GameList

   
    var body: some View {
        ZStack{
            VStack{
                //GameListeTitlePage()
                NavigationView{
                    List{
                        ForEach(gameList.games){
                            game in
                            NavigationLink(
                                destination:
                                    GameDetails(game: game)
                            ){
                               
                                VStack{
                                    HStack{
                                        Text("\(game.j_titre)")
                                        Spacer()
                                        Text("Editeur: \(game.j_editor)")
                                        Spacer()
                                        Text("Type de jeu: \(game.j_type)")
                                        Spacer()
                                        //Text("A partir de \(game.)") age min
                                        Spacer()
                                        Text("Se joue entre : \(game.j_nbMinJoueurs) et \(game.j_nbMaxJoueur).")
                                        Spacer()
                                        Text("Durée d'une partie: \(game.j_duree)")
                                        
                                    }
                                }
                            }
                        }
                    }
                }.navigationViewStyle(StackNavigationViewStyle())
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
