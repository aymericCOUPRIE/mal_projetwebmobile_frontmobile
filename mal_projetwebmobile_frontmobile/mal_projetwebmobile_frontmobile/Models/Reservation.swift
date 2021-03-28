//
//  Reservation.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/28/21.
//

import Foundation

class Reservation: ObservableObject, Identifiable, Equatable, Encodable {
    static func == (lhs: Reservation, rhs: Reservation) -> Bool {
        return lhs.res_id == rhs.res_id
    }
    
    private(set) var res_id : Int
    private(set) var suiv_jeux = [SuiviJeu]()


    init(res_id: Int, suiv_jeux: [SuiviJeu]) {
        self.res_id = res_id
        self.suiv_jeux = suiv_jeux
    }
    
}
