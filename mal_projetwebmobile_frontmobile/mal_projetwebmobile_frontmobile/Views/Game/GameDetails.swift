//
//  GameDetails.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 01/04/2021.
//

import SwiftUI


struct GameDetails: View {
    
    var game : Game
    
    var body: some View {
         return VStack{
            Group{
            Text("\(game.j_titre)") .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom, 20)
                .foregroundColor(Color.init(red: 0/255, green: 32/255, blue: 101/255))
                .padding(.top, 10)
            Spacer()
            Text("Editeur: \(game.j_editor)")
            Spacer()
            Text("Type de jeu: \(game.j_type)")
            }
            Group{
            Spacer()
            Text("À partir de \(game.j_ageMin) ans")
            Spacer()
            Text("Se joue entre : \(game.j_nbMinJoueurs) et \(game.j_nbMaxJoueur) joueurs.")
            Spacer()
            Text("Durée d'une partie: \(game.j_duree)")
            }
        }
    }
}

/*
struct GameDetails_Previews: PreviewProvider {
    static var previews: some View {
        GameDetails()
    }
}
*/
