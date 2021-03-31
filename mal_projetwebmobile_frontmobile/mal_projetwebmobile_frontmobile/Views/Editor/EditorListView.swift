//
//  EditorListView.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 23/03/2021.
//

import SwiftUI
import Combine
/*
struct EditorListView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct EditorListView_Previews: PreviewProvider {
    static var previews: some View {
        EditorListView()
    }
}


struct EditorListView: View {
  
    

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
        default:
            return
        }
    }
    
    var url : String = "/server/festivals/allInfosNextFestival"

 
    var body: some View {
    
        VStack{
            ZStack{
                List{
                    ForEach(self.editorListVM.editors){ editor in
                        /*
                         Plus tard quand on voudra voir le détail d'un éditeur -> la liste de tous ces jeux
                         NavigationLink(
                            destination: EditorDetail(editor)
                        )
                         */

                            EditorItem(editor)
                    }
                }
            }
            ErrorView(state: editorListState)
        }
    }
    

}

struct EditorListView_Previews: PreviewProvider {
    static var previews: some View {
        EditorListView(editorListVM: EditorListVM(EditorList()))
    }
}

struct ErrorView : View{
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
                Text("\(data.count) editors found!")
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


*/
