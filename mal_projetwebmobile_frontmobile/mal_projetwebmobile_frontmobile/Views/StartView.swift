//
//  ContentView.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 16/03/2021.
//

import SwiftUI

struct StartView: View {
    
    //@EnvironmentObject var viewRouter: ViewRouter //je lie ma vue au viewRouter
    
    @ObservedObject var festivalVM: FestivalVM
    
    var intent : FestivalIntent
    
    var url : String = "https://mal-festival.herokuapp.com/server/festivals/closest"
    
    init(festivalVM : FestivalVM){
        self.festivalVM = festivalVM
        self.intent = FestivalIntent(festival: festivalVM)
        let _ = self.festivalVM.$festivalState.sink(receiveValue: stateChanged)
        //loadInit()
    }

    
    func loadInit() {
        self.intent.loadFestival(url : url)//au tout début je charge mon festival
    }
    
    private var festivalState : FestivalState{
        return self.festivalVM.festivalState
    }

    /*var festival : Festival {
        return self.festivalVM.festival
    }*/

    func stateChanged(state: FestivalState){
        
        switch state {
        case .ready:
            self.intent.loadFestival(url : url)//au tout début je charge mon festival
            break
        /*
        case .new:
            intent.festivalLoaded()
            break
        */
        default:
            return
        }
    }



    
    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    WelcomeText()
                    LogoImage()
                    RDV(festivalVM : festivalVM)
                    
                    ErrorView(state: festivalState)
                    
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
        
}



/*
struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
        //StartView(festivalVM: FestivalVM(Festival(societes: [Societe]))).environmentObject(ViewRouter())//passe un router en paramètres
    }
}
 */



struct WelcomeText : View {
    var body: some View{
        return Text("Bienvenue!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
            .foregroundColor(Color.init(red: 0/255, green: 32/255, blue: 101/255))
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


struct RDV : View {
    
    @ObservedObject var festival : FestivalVM
    
    init(festivalVM : FestivalVM) {
        self.festival = festivalVM
        print("FESTIVAL COURANT", festival.model.date)
    }
    
    var body: some View {
        return Text("Rendez-vous le \(festival.model.date)")
            .foregroundColor(Color.init(red: 232/255, green: 111/255, blue: 184/255))
        
    }
}
 

struct ErrorView : View{
    let state : FestivalState
    var body: some View{
        VStack{
            Spacer()
            switch state{
            case .loading:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(3)
            case .loadingError(let error):
                ErrorMessage(error: error)
            default:
                EmptyView()
            }
            if case let .loaded(data) = state{
              Text("Festival found!");
            }
            Spacer()
        }
    }
}

struct ErrorMessage : View{
    let error :  Error
    var body: some View{
        VStack{
            Text("Error in search request")
                .foregroundColor(.red)
                .font(.title)
            if let error = error  as? HttpRequestError {
                Text("\(error.description)")
                    .italic()
                    .foregroundColor(.gray)

            }
            else{
                Text("Unknown error")
                    .foregroundColor(.red)
                    .font(.title)
            }
        }
    }
    
}
    
/*
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
*/
