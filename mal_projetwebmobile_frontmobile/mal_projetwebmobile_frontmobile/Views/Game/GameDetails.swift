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
        
         VStack{
        
                Text("\(game.j_titre)")
                 Spacer()
            Spacer()
            Text("Editeur: \(game.j_editor)")
            Spacer()
            Text("Type de jeu: \(game.j_type)")
            Spacer()
            //Text("A partir de \(game.)") age min
            Spacer()
            Text("Se joue entre : \(game.j_nbMinJoueurs) et \(game.j_nbMaxJoueur).")
            Spacer()
            //Text("Durée d'une partie: \(game.j_duree)")
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
