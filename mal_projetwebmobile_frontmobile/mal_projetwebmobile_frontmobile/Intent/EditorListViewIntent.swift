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
        switch result {
        case let .success(data):
            #if DEBUG
            debugPrint("SearchIntent: httpJsonLoaded -> success -> .loaded(editors)")
            #endif
            /*if let artist = artistFilter{
                let editors = data.filter( { track in track.artist.lowercased().contains(artist.lowercased()) } )
                playlist.playListState = .loaded(editors)
            }
            else{
                playlist.playListState = .loaded(data)
            }*/
        
            editorList.editorListState = .loaded(data)
        case let .failure(error):
            editorList.editorListState = .loadingError(error)
        }
    }
    
    func loadEditorList(url: String) {
        
        #if DEBUG
        debugPrint("EditorIntent: .loading(\(url))")
        debugPrint("EditorIntent: asyncLoadEditor")
        #endif
        
        print("Etape 2")
        editorList.editorListState = .loading(url)
        
        ServerHelper.loadEditorsFromAPI(url: url, endofrequest: httpJsonLoaded)
        
        

    }
}

