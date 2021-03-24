//
//  Editeur.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/23/21.
//

import Foundation


class Editor : Identifiable, ObservableObject, Encodable, Equatable {
    static func == (lhs: Editor, rhs: Editor) -> Bool {
        return lhs.j_id == rhs.j_id
    }
    
    
    enum CodingKeys: String, CodingKey {
        case j_id = "j_id"
        case nomEditeur = "nomEditeur"
    }	

    private(set) var j_id: Int
    private(set) var nomEditeur: String
    
    init(j_id: Int, nomEditeur: String) {
        self.j_id = j_id
        self.nomEditeur = nomEditeur
    }
       
}
