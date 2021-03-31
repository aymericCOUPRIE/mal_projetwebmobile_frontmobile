//
//  EditorVM.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/23/21.
//

import Foundation
import SwiftUI


class EditorVM: Identifiable {

    @ObservedObject private(set) var model: Editor
    
    
    var nomEditeur: String {
        return model.nomEditeur
    }
    
    init(_ editor: Editor) {
        self.model = editor
    }    
}
