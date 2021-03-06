//
//  FestivalIntent.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by marine teroitin on 29/03/2021.
//

import Foundation
import SwiftUI

class FestivalIntent {
    
    @ObservedObject var festival : FestivalVM

    
    init(festival: FestivalVM) {
        self.festival = festival
    }
    
    func festivalLoaded(){
        festival.festivalState = .ready
    }
    
    func httpJsonLoaded(result: Result<Festival, HttpRequestError>){
        switch result{
        case let .success(data):
            print("success : \(data)")
            festival.festivalState = .loaded(data)
        case let .failure(error):
            festival.festivalState = .loadingError(error)
        }
    }
    
    func loadFestival(url : String){
        print("Je suis dans FestivalIntent, url : \(url)")
        festival.festivalState = .loading(url)
        ServerHelper.loadFestivalFromAPI(url: url, endofrequest: httpJsonLoaded)
    }
}

