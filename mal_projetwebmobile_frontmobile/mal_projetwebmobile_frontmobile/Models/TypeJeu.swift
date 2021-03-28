//
//  TypeJeu.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/28/21.
//

import Foundation


class TypeJeu : ObservableObject, Identifiable, Equatable, Encodable {
    static func == (lhs: TypeJeu, rhs: TypeJeu) -> Bool {
        lhs.typeJ_libelle == rhs.typeJ_libelle
    }
    
    
    private(set) var typeJ_libelle : String
    
    init(libelle: String) {
        self.typeJ_libelle = libelle
    }
}
