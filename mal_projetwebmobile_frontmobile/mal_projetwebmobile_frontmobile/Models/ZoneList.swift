//
//  ZoneList.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 31/03/2021.
//

import Foundation

class ZoneList : ObservableObject {
    
    
    private(set) var zones : [Zone]
    
    
    init(zones: [Zone]) {
        self.zones = zones
    }
    
    func new(zones: [Zone]) {
        self.zones = zones
    }
    
    

    
}
