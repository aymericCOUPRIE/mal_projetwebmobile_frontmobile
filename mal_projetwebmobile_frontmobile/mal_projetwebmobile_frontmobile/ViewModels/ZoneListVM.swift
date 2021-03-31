//
//  ZoneListVM.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 31/03/2021.
//

import Foundation
import Combine

enum ZoneListState : CustomStringConvertible{
    case ready
    case loading(String)
    case loaded(ZoneList)
    case loadingError(Error)
    case new(ZoneList)

    var description: String{
        switch self {
        case .ready : return "ready"
        case .loading(let s) : return "loading: \(s)"
        case .loaded(let zones) : return "loaded: \(zones)" //changer par festival.date plus tard
        case .loadingError(let error) : return "loadingError: Error loading -> \(error)"
        case .new(let zones) : return " Festival's zones data was retrieved: \(zones)"
        }
    }
}

class ZoneListVM: ObservableObject{
    
    private(set) var model: ZoneList
    
    @Published var zoneListState : ZoneListState = .ready{
        didSet{
            switch self.zoneListState {
            case let .loaded(data):
                print(data)
                self.model.new(zones : data.zones)
                zoneListState = .new(model)
            case .loadingError:
                print("LOADING ERROR")
            default:
                return
            }
        }
    }
    
    init(_ zoneList : ZoneList) {
        self.model = zoneList
    }
    
}
