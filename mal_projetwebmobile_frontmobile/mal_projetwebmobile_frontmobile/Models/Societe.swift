//
//  Societe.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/28/21.
//

import Foundation

class Societe: ObservableObject {
    
    private(set) var soc_nom: String
    private(set) var reservation: [Reservation]()
    
    init(soc_nom: String, reservations: [Reservation]) {
        self.soc_nom = soc_nom
        self.reservation = reservation
    }
}
