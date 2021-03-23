//
//  EditorVM.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/23/21.
//

import Foundation
import SwiftUI


class EditorVM: Identifiable, Equatable {
    
    static func == (lhs: EditorVM, rhs: EditorVM) -> Bool {
        lhs.j_id == rhs.j_id
    }

    @ObservedObject private(set) var model: Editor
    
    var j_id: Int {
        return model.j_id
    }
    
    var nomEditeur: String {
        return model.nomEditeur
    }
    
    init(_ editor: Editor) {
        self.model = editor
    }    
}
