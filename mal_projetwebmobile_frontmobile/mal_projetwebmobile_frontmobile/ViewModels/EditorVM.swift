//
//  EditorVM.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/23/21.
//

import Foundation
import SwiftUI

enum EditorListState {
    case ready
    case loading(String)
    case loaded([Editor])
    case loadingError(Error)
    
    var description: String{
        switch self {
            case .ready                   : return "ready"
            case .loading(let s)          : return "loading: \(s)"
            case .loaded(let editors)     : return "loaded: \(editors.count) editors"
            case .loadingError(let error) : return "loadingError: Error loading -> \(error)"
        }
    }
}


class EditorVM: Identifiable, Equatable {
    
    static func == (lhs: EditorVM, rhs: EditorVM) -> Bool {
        lhs.j_id == rhs.j_id
    }

    @ObservedObject private(set) var model: Editor

    @Published var editorListState: EditorListState = .ready{
        didSet {
            switch self.editorListState {
            case .loaded(data):
                self.model.new(editors: data)
            case .loadingError:
                print("LOADING ERROR")
            default:
                return
            }
        }
    }
    
    var j_id: Int {
        return model.j_id
    }
    
    var nomEditeur: String {
        return model.nomEditeur
    }
    
    init(_ editor: Editor) {
        self.model = editor
    }
    
    
    func new(editors: [Editor]) {
        self.model.new(editors: editors)
    }
    
    
}
