//
//  Zone.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/28/21.
//

import Foundation

class Zone: ObservableObject, Identifiable {
 
    private(set) var zone_libelle : String
    private(set) var jeux : [Game]
    
    init(zone_libelle: String, jeux: [Game]) {
        self.zone_libelle = zone_libelle
        self.jeux = jeux
    }
    
    func new(zone_libelle: String, jeux: [Game]) {
        self.zone_libelle = zone_libelle
        self.jeux = jeux
    }
}
