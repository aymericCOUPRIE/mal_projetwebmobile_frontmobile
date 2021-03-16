//
//  KeyboardResponder.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 16/03/2021.
//

import Foundation
import SwiftUI

//pour que le clavier ne cache pas les champs de texte à remplir

class KeyboardResponder: ObservableObject {
    @Published var currentHeight: CGFloat = 0 //clavier non affiché par défaut
    
    var _center: NotificationCenter

        init(center: NotificationCenter = .default) {
            _center = center
            //Tell the notification center to listen to the system keyboardWillShow and keyboardWillHide notification
                    _center.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
                    _center.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
                
        }
    
    @objc func keyBoardWillShow(notification: Notification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                withAnimation {
                   currentHeight = keyboardSize.height
                }
            }
        }
    @objc func keyBoardWillHide(notification: Notification) {
            withAnimation {
               currentHeight = 0
            }
        }
}

