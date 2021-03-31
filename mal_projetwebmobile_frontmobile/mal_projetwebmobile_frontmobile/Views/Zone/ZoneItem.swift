//
//  ZoneItem.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/31/21.
//

import SwiftUI

struct ZoneItem : View {
    
    var zoneVM : ZoneVM
    
    init(_ zoneVM : ZoneVM) {
        self.zoneVM = zoneVM
    }
    
    
    var body: some View {
        VStack {
            ZStack{
                Text(zoneVM.libelle)
                List {
                    ForEach(self.zoneVM.games){ game in
                        Text(game.titre)
                    }
                }
            }
        }
    }
}

/*
struct ZoneItem_Previews: PreviewProvider {
    static var previews: some View {
        ZoneItem(ZoneVM(Zone))
    }
}
 */
