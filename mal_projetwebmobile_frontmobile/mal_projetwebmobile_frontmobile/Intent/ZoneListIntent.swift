//
//  ZoneListIntent.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 31/03/2021.
//

import Foundation
import SwiftUI

class ZoneListIntent {
    
    @ObservedObject var zoneList : ZoneListVM
    
    init(zoneList: ZoneListVM){
        self.zoneList = zoneList
    }
    
    func httpJsonLoaded(result: Result<ZoneList, HttpRequestError>){
        switch result{
        case let .success(data):
            print("success : \(data)")
            zoneList.zoneListState = .loaded(data)
        case let .failure(error):
            zoneList.zoneListState = .loadingError(error)
        }
    }
    
    func loadZones(url : String){
        print("Je suis dans ZoneListIntent, url : \(url)")
        zoneList.zoneListState = .loading(url)
        ServerHelper.loadZonesFromAPI(url: url, endofrequest: httpJsonLoaded)
    }
    
}
