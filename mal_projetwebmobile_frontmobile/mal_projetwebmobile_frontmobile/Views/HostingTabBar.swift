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
      
    
    //@StateObject var festivalVM : FestivalVM = FestivalVM(Festival(date: "2020-05-06"))
    
    @State private var selectedTab: Tab = .home
    @StateObject var festivalVM : FestivalVM = FestivalVM(Festival(date : "2000-00-00"))
    @StateObject var zoneListVM : ZoneListVM = ZoneListVM(ZoneList(zones: [Zone]()))
    @StateObject var editorListVM : EditorListVM = EditorListVM(EditorList(editors: [Editor]()))
    
    var body: some View {
        TabView(selection: $selectedTab){
                    StartView(festivalVM: self.festivalVM)
                           .tag(0)
                           .tabItem{
                               Text("Acceuil")
                               Image(systemName: "house.fill")
                           }
                      FestivalGameListView()
                           .tag(1)
                           .tabItem{
                               Text("Jeux")
                               Image(systemName: "die.face.5")
                           }
                       
                        EditorListView(editorListVM: self.editorListVM)
                           .tag(2)
                           .tabItem{
                               Text("Éditeurs")
                               Image(systemName: "person.2.square.stack")
                           }
                        ZoneListView(zoneListVM: self.zoneListVM)
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
