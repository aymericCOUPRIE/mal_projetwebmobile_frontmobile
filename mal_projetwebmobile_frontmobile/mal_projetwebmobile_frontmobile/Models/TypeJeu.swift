//
//  TypeJeu.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/28/21.
//

import Foundation


class TypeJeu : ObservableObject, Identifiable, Equatable, Encodable {
    static func == (lhs: TypeJeu, rhs: TypeJeu) -> Bool {
        lhs.typeJ_id == rhs.typeJ_id
    }
    
    
    private(set) var typeJ_id : Int
    private(set) var typeJ_libelle : String
    
    init(id: Int, libelle: String) {
        self.typeJ_id = id
        self.typeJ_libelle = libelle
    }
}
