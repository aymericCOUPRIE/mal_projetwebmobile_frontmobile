//
//  Editeur.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/23/21.
//

import Foundation


class Editor : Identifiable, ObservableObject, Encodable, Equatable {
    static func == (lhs: Editor, rhs: Editor) -> Bool {
        return lhs.nomEditeur == rhs.nomEditeur
    }
    

    private(set) var nomEditeur: String
    
    init(nomEditeur: String) {
        self.nomEditeur = nomEditeur
    }
       
}
