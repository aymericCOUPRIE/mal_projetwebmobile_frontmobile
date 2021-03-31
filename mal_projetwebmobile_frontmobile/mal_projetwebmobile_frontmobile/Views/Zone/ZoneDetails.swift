//
//  ZoneDetails.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 01/04/2021.
//

import SwiftUI

struct ZoneDetails: View {
    
    var zone : Zone
    
    var body: some View {
        
         VStack{
             HStack{
                 Text("\(zone.zone_libelle)")
                 Spacer()
             }
             HStack{
                 Text("\(zone.jeux.count)")
                 Spacer()
             }
         }
    }
}

/*
struct ZoneDetails_Previews: PreviewProvider {
    static var previews: some View {
        ZoneDetails()
    }
}
*/
