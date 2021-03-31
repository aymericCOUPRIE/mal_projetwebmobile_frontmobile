//
//  Festival.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/28/21.
//

import Foundation



class Festival: ObservableObject {
    
    
    private(set) var date : Date
    
    init(date : Date){
        self.date = date
    }
    
    
    func new(date: Date) {
        self.date = date
    }

    
    
}
