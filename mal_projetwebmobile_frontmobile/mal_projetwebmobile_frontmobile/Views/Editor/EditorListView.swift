//
//  EditorListView.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 23/03/2021.
//

import SwiftUI
import Combine



struct EditorListView: View {
  
    @State private var searchText = ""

    @ObservedObject var editorListVM : EditorListVM
    var intent : EditorListViewIntent
    
    init(editorListVM : EditorListVM){
        self.editorListVM = editorListVM
        self.intent = EditorListViewIntent(editorList: editorListVM)
        let _ = self.editorListVM.$editorListState.sink(receiveValue: stateChanged)
    }
    
    private var editorListState : EditorListState{
        return self.editorListVM.editorListState
    }
    
    var editors : [EditorVM] {
        return self.editorListVM.editors
    }
    
    func stateChanged(state: EditorListState){
        
        switch state {
        case .ready:
            self.intent.loadEditorList(url: url)
        case .new:
            break
        default:
            return
        }
    }
    
    var url : String = "https://mal-festival.herokuapp.com/server/festivals/gameByEditor"

 
    var body: some View {
    
        
        ZStack{
            VStack{
                
                NavigationView {
                    VStack {
                        EditorTitlePage()
                        
                       SearchBar(text: $searchText)
                            .padding(.top, -20)
                        List{
                            ForEach(editorListVM.model.editors.filter({ searchText.isEmpty ? true :
                                $0.nomEditeur.lowercased().contains(searchText.lowercased())})){ editor in
                        
                                NavigationLink(
                                    destination: GameListView(gameList: GameList(games: editor.games))
                                ){
                                    EditorItem(editor: editor)
                                }
                                
                            }
                        }
                    }
                }
                ErrorViewEditor(state: editorListState)
            }
        }
    }
    

}

/*
struct EditorListView_Previews: PreviewProvider {
    static var previews: some View {
        EditorListView(editorListVM: EditorListVM(EditorList()))
    }
}
*/
 

struct ErrorViewEditor : View{
    let state : EditorListState
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
                Text("\(data.editors.count) éditeur(s) trouvé(s)!")
            }
            Spacer()
        }
    }
}
 
/*
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
 */


struct EditorTitlePage : View {
    var body: some View{
        return Text("Editeurs du festival")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
            .foregroundColor(Color.init(red: 0/255, green: 32/255, blue: 101/255))
            .padding(.top, 10)
    }
}
