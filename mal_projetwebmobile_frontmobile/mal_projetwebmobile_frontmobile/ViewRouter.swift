//
//  ViewRouter.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 16/03/2021.
//

import Foundation
import SwiftUI

class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .HostingTabBar//startView = valeur par défaut
    //@Published pour que les vues qui observent viewRouter soient notifiées des changements et mises à jour
}
