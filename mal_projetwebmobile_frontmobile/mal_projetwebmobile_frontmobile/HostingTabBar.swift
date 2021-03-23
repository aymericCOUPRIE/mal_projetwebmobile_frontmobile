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
        
    }
    
}



struct HostingTabBar_Previews: PreviewProvider {
    static var previews: some View {
        HostingTabBar()
    }
}
