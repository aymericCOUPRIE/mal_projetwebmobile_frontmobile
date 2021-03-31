//
//  ZoneListView.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 23/03/2021.
//

import SwiftUI

struct ZoneListView: View {
    
    @ObservedObject var zoneListVM: ZoneListVM
    var intent : ZoneListIntent
    
    var url : String = "http://localhost:3000/server/festivals/closest/gamesByZone"
    
    init(zoneListVM : ZoneListVM){
        self.zoneListVM = zoneListVM
        self.intent = ZoneListIntent(zoneList: zoneListVM)
        let _ = self.zoneListVM.$zoneListState.sink(receiveValue: stateChanged)
    }
    
    

    private var zoneListState : ZoneListState{
        return self.zoneListVM.zoneListState
    }
    
    var zones : [ZoneVM] {
        return self.zoneListVM.zones
    }
    
    func stateChanged(state: ZoneListState){
        
        switch state {
        case .ready:
            self.intent.loadZones(url : url)//au tout début je charge mes données
            break
            
        case .loading(url):
            print("I am loading ZoneList")
            break
        case .new:
            print("I have your ZoneList data!")
            break
          
        default:
            return
        }
    }
    

    
    var body: some View {
        NavigationView{

            ForEach(zoneListVM.model.zones){ zone in
                ZoneItem(ZoneVM(model: zone))
           }

            ErrorViewZone(state: zoneListState)
           
        }.navigationTitle("Zones du festival")
      
    }
}

struct ErrorViewZone : View{
    let state : ZoneListState
    var body: some View{
        VStack{
            Spacer()
            switch state{
            case .loading:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(3)
            case .loadingError(let error):
                ErrorMessage(error: error)
            default:
                EmptyView()
            }
            if case let .loaded(data) = state{
              Text("Zones found!");
            }
            Spacer()
        }
    }
}


/*
struct ZoneListView_Previews: PreviewProvider {
    static var previews: some View {
        ZoneListView()
    }
}
*/
