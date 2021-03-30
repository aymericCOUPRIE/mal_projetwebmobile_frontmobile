//
//  FestivalVM.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 29/03/2021.
//

import Foundation
import Combine

enum FestivalState : CustomStringConvertible{
    case ready
    case loading(String)
    case loaded(Festival)
    case loadingError(Error)
    case new(Festival)

    var description: String{
        switch self {
        case .ready : return "ready"
        case .loading(let s) : return "loading: \(s)"
        case .loaded(let festival) : return "loaded: \(festival)" //changer par festival.date plus tard
        case .loadingError(let error) : return "loadingError: Error loading -> \(error)"
        case .new(let festival) : return " The festival data was retrieved: \(festival)"
        }
    }
}

class FestivalVM: ObservableObject{
    
    private(set) var model: Festival
    
    @Published var FestivalState : FestivalState = .ready{
        didSet{
            switch self.FestivalState {
            case let .loaded(data):
                print(data)
                self.model.new(festival: data)
                FestivalState = .new(model)
            case .loadingError:
                print("LOADING ERROR")
            default:
                return
            }
        }
    }
    
    init(_ festival : Festival) {
        self.model = festival
    }
    
}
