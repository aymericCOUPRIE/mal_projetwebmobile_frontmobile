//
//  HostingTabBar.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 31/03/2021.
//

import SwiftUI

struct HostingTabBar: View {
    private enum Tab: Hashable {
          case home
          case gameList
          case editorList
          case zoneList
      }
      
      @State private var selectedTab: Tab = .home
    @ObservedObject var festivalVM : FestivalVM = FestivalVM(Festival(date : Date()))
        
    
    var body: some View {
        TabView(selection: $selectedTab){
                    StartView(festivalVM: self.festivalVM)
                           .tag(0)
                           .tabItem{
                               Text("Acceuil")
                               Image(systemName: "house.fill")
                           }
                      // GameListView()
                           .tag(1)
                           .tabItem{
                               Text("Jeux")
                               Image(systemName: "die.face.5")
                           }
                       
                       EditorListView()
                           .tag(2)
                           .tabItem{
                               Text("Éditeurs")
                               Image(systemName: "person.2.square.stack")
                           }
                       ZoneListView()
                           .tag(3)
                           .tabItem{
                               Text("Zones")
                               Image(systemName: "map")
                           }

        }
    }
}

struct HostingTabBar_Previews: PreviewProvider {
    static var previews: some View {
        HostingTabBar()
    }
}
