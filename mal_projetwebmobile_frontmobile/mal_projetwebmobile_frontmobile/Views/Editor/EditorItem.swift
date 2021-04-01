//
//  EditorItem.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 24/03/2021.
//

import SwiftUI

struct EditorItem: View {
    
    var editor : Editor
    
    var body: some View {
        VStack{
            HStack{
                Text(editor.nomEditeur)
                Spacer()
            }
            HStack {
                Text("Nombre de jeux: \(editor.games.count)")
            }
            
        }
    }
}

/*
struct EditorItem_Previews: PreviewProvider {
    static var previews: some View {
        EditorItem(EditorVM(Editor(nomEditeur: "Hasbro", games: [Game]())))
    }
}
*/
