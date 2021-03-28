//
//  Zone.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/28/21.
//

import Foundation

class Zone: ObservableObject, Encodable, Equatable, Identifiable {
    static func == (lhs: Zone, rhs: Zone) -> Bool {
        return lhs.zone_libelle == rhs.zone_libelle
    }
    
    
    private(set) var zone_libelle : String
    
    init(zone_libelle: String) {
        self.zone_libelle = zone_libelle
    }
}
