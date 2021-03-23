//
//  EditorListView.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 23/03/2021.
//

import SwiftUI

struct EditorListView: View {
    
    private let intent : EditorIntent
    private let url : String = "http://localhost:3000/server/festivals/gameByEditor"
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        loadEditor()
    }
    
    func loadEditor() {
        self.intent.loadEditorList(url: url)
    }
}

struct EditorListView_Previews: PreviewProvider {
    static var previews: some View {
        EditorListView()
    }
}
