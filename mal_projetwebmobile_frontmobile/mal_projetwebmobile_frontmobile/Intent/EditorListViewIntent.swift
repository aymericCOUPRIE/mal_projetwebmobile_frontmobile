//
//  EditorIntent.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/23/21.
//

import Foundation
import SwiftUI


class EditorListViewIntent {
    
    @ObservedObject var editorList : EditorListVM
    
    init(editorList: EditorListVM) {
        self.editorList = editorList
    }
    
    func httpJsonLoaded(result: Result<[Editor],HttpRequestError>){
        switch 	result {
        case let .success(data):
       
            editorList.editorListState = .loaded(data)
        case let .failure(error):
            editorList.editorListState = .loadingError(error)
        }
    }
    
    func loadEditorList(url: String) {
        editorList.editorListState = .loading(url)
        ServerHelper.loadEditorsFromAPI(url: url, endofrequest: httpJsonLoaded)
    }
}

