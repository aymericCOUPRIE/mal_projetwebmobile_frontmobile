//
//  ContentView.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 16/03/2021.
//

import SwiftUI

struct StartView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter //je lie ma vue au viewRouter
 
    
    var body: some View {
        NavigationView {
            VStack {
                WelcomeText()
                LogoImage()
                /*
                WhoAreYouText()
               //lien vers page login si organisateur
                Button(action: {
                    viewRouter.currentPage = .loginView //je change la page courante dans le viewRouter
                }){
                    organisateurButtonContent()
                }
                //lien vers page???? si visiteur
                Button(action: {
                    viewRouter.currentPage = .loginView //A CHANGER !!!!!
                   
               }){
                visiteurButtonContent()
                }
 */
                
            }.padding()
            
        }
    }
        
}

#if DEBUG
struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView().environmentObject(ViewRouter())//passe un router en paramètres
    }
}
#endif

struct WelcomeText : View {
    var body: some View{
        return Text("Bienvenue!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct LogoImage : View {
    var body: some View{
        return Image("logo")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 250, height: 150)
            .clipped()
            .padding(.bottom, 75)
            }
}
    
struct WhoAreYouText : View {
    var body: some View{
        return Text("Qui êtes vous?")
            .font(.title3)
            .fontWeight(.semibold)
            
    }
}

struct organisateurButtonContent: View {
    var body: some View {
    Text("Organisateur")
        .foregroundColor(.white)
        .frame(width: 150, height: 25)
        .background(Color.init(red: 0, green: 38/255, blue: 99/255))
        .cornerRadius(15)
        .padding(.top, 10)
    }
}
struct visiteurButtonContent: View {
    var body: some View {
    Text("Visiteur")
        .foregroundColor(.white)
        .frame(width: 150, height: 25)
        .background(Color.init(red: 146/255, green: 212/255, blue: 0/255))
        .cornerRadius(15)
        .padding(.top, 10)
    }
}

