//
//  EditorItem.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 24/03/2021.
//

import SwiftUI

struct EditorItem: View {
    
    var editor : EditorVM
    
    init(_ editor: EditorVM) {
        self.editor = editor
    }
    
    var body: some View {
        VStack{
            HStack{
                Text(editor.nomEditeur)
                Spacer()
            }
            HStack{
                Text("\(editor.j_id)") //différent de la ligne du dessus car c'est un int
                Spacer()
            }
            
        }
    }
}

struct EditorItem_Previews: PreviewProvider {
    static var previews: some View {
        EditorItem(EditorVM(Editor(j_id: 2, nomEditeur: "Hasbro")))
    }
}
