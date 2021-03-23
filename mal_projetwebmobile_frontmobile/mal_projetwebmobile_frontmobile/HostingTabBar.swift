//
//  HostingTabBar.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 23/03/2021.
//

import SwiftUI


struct TabBarApp: App {
    var body: some Scene {
        WindowGroup{
            HostingTabBar()
        }
    }
}

struct HostingTabBar: View {
    private enum Tab: Hashable {
        case home
        case gameList
        case editorList
        case zoneList
    }
    
    @State private var selectedTab: Tab = .home
    
    var body: some View{
        TabView(selection: $selectedTab){
            StartView()
                .tag(0)
                .tabItem{
                    Text("Acceuil")
                    Image(systemName: "house.fill")
                }
            GameListView()
                .tag(1)
                .tabItem{
                    Text("Jeux")
                    Image(systemName: "house.fill")
                }
            
            EditorListView()
                .tag(2)
                .tabItem{
                    Text("Éditeurs")
                    Image(systemName: "house.fill")
                }
            ZoneListView()
                .tag(3)
                .tabItem{
                    Text("Zones")
                    Image(systemName: "house.fill")
                }
        }
    }
    
}



struct HostingTabBar_Previews: PreviewProvider {
    static var previews: some View {
        HostingTabBar()
    }
}
