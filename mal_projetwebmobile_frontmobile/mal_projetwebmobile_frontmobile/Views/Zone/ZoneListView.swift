//
//  ZoneListView.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 23/03/2021.
//

import SwiftUI

struct ZoneListView: View {
    //pour la barre de recherche
    @State private var searchText = ""
    
    @ObservedObject var zoneListVM: ZoneListVM
    var intent : ZoneListIntent
    
    var url : String = "https://mal-festival.herokuapp.com/server/festivals/closest/gamesByZone"
    
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
        ZStack {
            
            VStack {
                
                
                
                NavigationView{
                    VStack{
                        
                   
                        ZoneTitlePage()
                        
                        SearchBar(text: $searchText)
                            .padding(.top, -20)
                        List{
                            ForEach(zoneListVM.model.zones.filter( { searchText.isEmpty ? true : $0.zone_libelle.lowercased().contains(searchText.lowercased()) })){ zone in
                                NavigationLink(
                                    destination: GameListView(gameList: GameList(games: zone.jeux))
                                ){
                                    ZoneDetails(zone: zone)
                                }
                            }
                        }
                        
                    }
                }.navigationViewStyle(StackNavigationViewStyle())
                ErrorViewZone(state: zoneListState)
            }
        }
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
                Text("\(data.zones.count) zone(s) trouvée! ");
            }
            Spacer()
        }
    }
}


struct ZoneTitlePage : View {
    var body: some View{
        return Text("Zones du festival")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
            .foregroundColor(Color.init(red: 0/255, green: 32/255, blue: 101/255))
            .padding(.top, 10)
    }
}

/*
 struct ZoneListView_Previews: PreviewProvider {
 static var previews: some View {
 ZoneListView()
 }
 }
 */
