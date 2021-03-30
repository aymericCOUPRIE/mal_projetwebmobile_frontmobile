//
//  Festival.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/28/21.
//

import Foundation



class Festival: ObservableObject {
    
    
 
    private(set) var societes = [Societe]()
    
    init(societes: [Societe]){
        self.societes = societes
    }
    
    func new(societes: [Societe]) {
        self.societes = societes
    }
    
    
}
