//
//  GameListView.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 23/03/2021.
//

import SwiftUI

struct GameListView: View {
    
    @ObservedObject var listGames : GameVM
    
    var intent : 
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListView()
    }
}
