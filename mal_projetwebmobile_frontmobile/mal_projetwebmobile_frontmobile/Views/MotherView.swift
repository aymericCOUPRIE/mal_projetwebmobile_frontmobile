//
//  MotherView.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 16/03/2021.
//

import SwiftUI

enum Page {
    case startView
    case loginView
}

struct MotherView: View {
   
    @EnvironmentObject var viewRouter: ViewRouter //pour que notre vue observe le ViewRouter
    
    var body: some View {
        VStack{
            switch viewRouter.currentPage {
                case .startView:
                StartView()
                case .loginView:
                LoginView()
            }
            
        }
       
    }
}


struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())//on lui passe une instance de ViewRouter
    }
}
