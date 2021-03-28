//
//  Festival.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/28/21.
//

import Foundation

protocol FestivalDelegate {
    func newFestival()
}

class Festival: ObservableObject {
    
    
    var delegate: FestivalDelegate?
    private(set) var societes = [Societe]()
    
    func new(societes: [Societe]) {
        self.societes = societes
        self.delegate?.newFestival()
    }
    
}
