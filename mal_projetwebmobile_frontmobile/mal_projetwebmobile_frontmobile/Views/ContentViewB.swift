//
//  ContentViewB.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 16/03/2021.
//

import SwiftUI

struct ContentViewB: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
           Text("view B")
            Button(action: {
                viewRouter.currentPage = .page1
            }) {
                BackButtonContent()
            }
        }
    }
}

struct ContentViewB_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewB().environmentObject(ViewRouter())
    }
}

 

struct BackButtonContent : View {
    var body: some View {
        return Text("Back")
            .foregroundColor(.white)
            .frame(width: 200, height: 50)
            .background(Color.blue)
            .cornerRadius(15)
            .padding(.top, 50)
    }
}
