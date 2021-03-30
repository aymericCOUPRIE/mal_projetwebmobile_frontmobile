//
//  HostingTabBar.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 23/03/2021.
//

import SwiftUI


struct TabBarApp: App {
    
    //@StateObject var editorList : EditorListVM = EditorListVM(EditorList())
    @StateObject var festivalVM : FestivalVM = FestivalVM(Festival(societes: [Societe]()))
    
    var body: some Scene {
        WindowGroup{
            HostingTabBar(festivalVM: festivalVM)
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
    
    //@ObservedObject var editorList: EditorListVM
    //var intent: EditorListViewIntent
    
    @ObservedObject var festivalVM : FestivalVM
    
    init(festivalVM : FestivalVM){
        self.festivalVM = festivalVM
    }
    
    /*
    init(editorList: EditorListVM) {
        self.editorList = editorList
        self.intent = EditorListViewIntent(editorList: editorList)
    }
 */
    
    var body: some View{
        TabView(selection: $selectedTab){
            StartView(festivalVM: self.festivalVM)
                .tag(0)
                .tabItem{
                    Text("Acceuil")
                    Image(systemName: "house.fill")
                }
            GameListView()
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
        HostingTabBar(festivalVM: FestivalVM(Festival(societes: [Societe]())))
    }
}
