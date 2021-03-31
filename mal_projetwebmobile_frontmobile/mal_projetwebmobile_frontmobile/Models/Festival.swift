//
//  Festival.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/28/21.
//

import Foundation



class Festival: ObservableObject {
    
    
    private(set) var date : String
    
    init(date : String){
        self.date = date
    }
    
    
    func new(date: String) {
        self.date = date
    }

    
    
}
