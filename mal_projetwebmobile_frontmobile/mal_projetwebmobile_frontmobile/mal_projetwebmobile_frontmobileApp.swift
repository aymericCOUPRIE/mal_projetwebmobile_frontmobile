//
//  mal_projetwebmobile_frontmobileApp.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/10/21.
//

import SwiftUI

@main
struct mal_projetwebmobile_frontmobileApp: App {
    
    //@StateObject var festivalVM : FestivalVM = FestivalVM(Festival(date: "2020-05-06"))

    
    init() {}
    
    //@StateObject var viewRouter = ViewRouter()
    

    var body: some Scene {
        WindowGroup {
         
            
            //vue au lancement de l'application
           // MotherView().environmentObject(viewRouter) //on crée une instance de ViewRouter et on l'injecte dans toute la hiérarchie des vues en tant qu'EnvironmentObject au lancement de l'application.
           
            //StartView(festivalVM: festivalVM)
            
            HostingTabBar()
        }
    }
}
