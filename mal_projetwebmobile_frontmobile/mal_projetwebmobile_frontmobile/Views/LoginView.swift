//
//  login.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 16/03/2021.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

//pour tester
let storedEmail = "m@me.com"
let storedPassword = "a"

struct LoginView: View {
    @EnvironmentObject var viewRouter: ViewRouter //je lie ma vue au viewRouter
    
    @State var email: String="" //stocker ce que l'utilisateur va mettre dans le textfield
    //le @State permet à la vue d'afficher automatique le contenu de la var quand il change
    
    @State var mdp: String=""
    
    @State var authenticationDidFail: Bool = false //voir si j'ai mis les mauvais identifiants
    @State var authenticationDidSucceed: Bool = false
    
    @ObservedObject var keyboardResponder = KeyboardResponder() //pour que le clavier ne cache pas les champs de texte à remplir

    
    var body: some View {
        NavigationView {
        ZStack{ //pour empiler les objets de la VStack et le pop up les un sur les autres
            VStack {
                LogoImage()
                if authenticationDidFail {
                                Text("Mauvais email/mot de passe.")
                                    .offset(y: -10)
                                    .foregroundColor(.red)
                }
                EmailTextField(email: $email)
                PasswordSecureField(mdp: $mdp)
                Button(action: {
                                    if self.email == storedEmail && self.mdp == storedPassword {
                                        self.authenticationDidSucceed = true
                                        self.authenticationDidFail = false
                                    } else {
                                        self.authenticationDidFail = true
                                    }
                                }) {
                    LogicButtonContent()
                }
                
              
            }.padding()
       
            if authenticationDidSucceed {
                            Text("Connexion réussie!")
                                .font(.headline)
                                .frame(width: 250, height: 80)
                                .background(Color.init(red: 146/255, green: 212/255, blue: 0/255))
                                .cornerRadius(20.0)
                                .foregroundColor(.white)
                                .animation(Animation.default) //pour effet pop up
                        }
        
        }
                   .offset(y: -keyboardResponder.currentHeight*0.9) //pour le clavier
            
        }
     
        
}

#if DEBUG

struct login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(ViewRouter())//passe un router en paramètres
    }
}
#endif

struct LogoImage : View {
    var body: some View{
        return Image("logo")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 250, height: 150)
            .clipped()
            .padding(.bottom, 50)
            }
    }
    
    struct LogicButtonContent: View {
        var body: some View{
            return Text("LOGIN")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 200, height: 40)
                .background(Color.init(red: 0, green: 38/255, blue: 99/255))
                .cornerRadius(15.0)
                }
    }
    
    struct EmailTextField: View {
        @Binding var email: String //binding pour créer une connexion de données entre une vue (ici : notre EmailTextField externalisé) et sa source de données (ici : notre Email State).
        var body: some View{
            return  TextField("Email", text:$email) //$ pour lier notre propriété au TextField
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
        }
    }
    
    struct PasswordSecureField: View{
        @Binding var mdp: String
        
        var body: some View{
            return SecureField("Mot de passe", text: $mdp)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)

        }
    }
        
}
