//
//  ContentViewA.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 16/03/2021.
//

import SwiftUI

struct ContentViewA: View {
    @EnvironmentObject var viewRouter: ViewRouter //je lie ma vue au viewRouter
    
    var body: some View {
        VStack {
           Text("View A")
            Button(action: {
                viewRouter.currentPage = .page2 //je change la page courante dans le viewRouter
            }) {
                NextButtonContent()
            }
        }
    }
}

struct ContentViewA_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewA().environmentObject(ViewRouter())//passe un router en paramètres
    }
}



struct NextButtonContent : View {
    var body: some View {
        Text("Next")
            .foregroundColor(.white)
            .frame(width: 200, height: 50)
            .background(Color.blue)
            .cornerRadius(15)
            .padding(.top, 50)
    }
}
