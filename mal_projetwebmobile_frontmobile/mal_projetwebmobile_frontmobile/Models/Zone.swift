//
//  Zone.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/28/21.
//

import Foundation

class Zone: ObservableObject, Encodable, Equatable, Identifiable {
    static func == (lhs: Zone, rhs: Zone) -> Bool {
        return lhs.zone_id == rhs.zone_id
    }
    
    
    private(set) var zone_id : Int
    
    init(zone_id: Int) {
        self.zone_id = zone_id
    }
}
