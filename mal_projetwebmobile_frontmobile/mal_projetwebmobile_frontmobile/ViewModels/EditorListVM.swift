//
//  EditorListVM.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/23/21.
//

import Foundation
import Combine



enum EditorListState {
    case ready
    case loading(String)
    case loaded(EditorList)
    case loadingError(Error)
    case new(EditorList)
    
    var description: String{
        switch self {
            case .ready                     : return "ready"
            case .loading(let s)            : return "loading: \(s)"
            case .loaded(let editors)       : return "loaded: \(editors) editors"
            case .loadingError(let error)   : return "loadingError: Error loading -> \(error)"
            case .new(let editors)          : return "Editor data was retreived \(editors)"
        }
    }
}


class EditorListVM: ObservableObject, EditorListDelegate {
    
    private(set) var model: EditorList
    
    @Published private(set) var editors = [EditorVM]()
    
    
    @Published var editorListState: EditorListState = .ready{

        didSet {
            //data -- tableau d'editor
            switch self.editorListState {
            case .loaded(let data):
                self.model.new(editors: data.editors)
                editorListState = .new(model)
            case .loadingError:
                print("LOADING ERROR")
            default:
                return
            }
        }
    }
    
    init(_ editorList: EditorList) {
        self.model = editorList
        self.model.delegate = self
    }
    
    func new(editors: [Editor]) {
        print("Bonjour", editors)
        self.model.new(editors: editors)
    }
    
    func newEditorList() {
        for editor in self.model.editors{
            self.editors.append(EditorVM(editor))
        }
       
    }
    
    
}

