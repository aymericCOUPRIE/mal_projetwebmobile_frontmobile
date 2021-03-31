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
