//
//  Societe.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 31/03/2021.
//


import Foundation

class Societe: ObservableObject {
    static func == (lhs: Societe, rhs: Societe) -> Bool {
        return lhs.soc_nom == rhs.soc_nom
    }
    
    
    private(set) var soc_nom: String
    private(set) var reservations = [Reservation]()
    
    init(soc_nom: String, reservations: [Reservation]) {
        self.soc_nom = soc_nom
        self.reservations = reservations
    }
}
