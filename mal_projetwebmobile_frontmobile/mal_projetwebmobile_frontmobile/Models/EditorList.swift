//
//  EditorList.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/23/21.
//

import Foundation

protocol EditorListDelegate {
    func newEditorList()
}


class EditorList: ObservableObject {
    
    var delegate: EditorListDelegate?
    
    private(set) var editors = [Editor]()
    
    func new(editors: [Editor]) {
        self.editors = editors
        self.delegate?.newEditorList()
    }
}

