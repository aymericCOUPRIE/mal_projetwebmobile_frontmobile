//
//  TypeJeu.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 31/03/2021.
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
