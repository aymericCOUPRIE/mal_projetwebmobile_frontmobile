//
//  ServerHelper.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/23/21.
//

import Foundation


struct ListFestival: Codable {
    var closestFestival : [FestivalData]
}

struct FestivalData: Codable {
    var fes_date: String
}



struct ListZonesData: Codable{
    var zones : [ZoneData]
}


struct ZoneData: Codable {
    var zo_libelle: String
    var suivi_jeus: [Suivi_JeuxData]
}

struct Suivi_JeuxData : Codable {
    var jeu : GameData
}

struct GameData: Codable {
    //var j_id: Int     // --> pas besoin ?
    var j_titre: String
    var j_ageMin: Int
    var j_duree: String
    var j_nbMaxJoueurs: Int
    var j_nbMinJoueurs: Int
    //var j_lienNotice: String
    var type_jeu: GameTypeData
    var societe: EditorData
}

struct GameTypeData: Codable {
    var typJ_libelle: String
}

struct EditorData: Codable {
    var soc_nom: String
}







struct ExhibitorData: Codable {
    //var soc_id: Int      --> pas besoin ?
    var soc_nom: String // nomEditeur à remplacer par soc_nom
    var reservations: [ReservationData]
}

struct ReservationData: Codable {
    var res_id: Int      //--> pas besoin ?
    var suivi_jeus: [GameMonitoringData]
}

struct GameMonitoringData: Codable {
    var suivJ_id: Int     // --> pas besoin ?
    var jeu: GameData
    //var zone: ZoneData
}

struct EditorGameData: Codable {
    var nomEditeur: String
    var j_titre: String
    var j_ageMin: Int
    var j_duree: String
    var j_nbMaxJoueurs: Int
    var j_nbMinJoueurs: Int
    var j_lienNotice: String
    var type_jeu: String
}



struct FestivalGamesData : Codable {
    var suivi_jeus: [SuiviJeuData]
}

struct SuiviJeuData : Codable {
    var zone : ZoneNomData
    var jeu : GameData
}

struct ZoneNomData : Codable {
    var zo_libelle : String
}





struct ServerHelper {
      
    static func festivalDataToFestival(data: ListFestival) -> Festival? {
        for fdata in data.closestFestival {
            return Festival(date: fdata.fes_date)
        }
        return nil
    }

    //@Escaping -- Fait appel à une fonction ailleurs (asynchrone)
    static func loadFestivalFromAPI(url surl: String, endofrequest: @escaping (Result<Festival, HttpRequestError>) -> Void){
        
        //vérifier l'url
        guard let url = URL(string: surl) else {
            endofrequest(.failure(.badURL(surl)))
            return
        }
        self.loadFestivalFromAPI(url: url, endofrequest: endofrequest) //appel la méthode d'en dessous
    }
    
    static func loadFestivalFromAPI(url: URL, endofrequest: @escaping (Result<Festival, HttpRequestError>) -> Void){
        self.loadFestivalFromJsonData(url: url, endofrequest: endofrequest, ServerApiRequest: true) //appel la méthode d'en dessous
    }

    private static func loadFestivalFromJsonData(url: URL, endofrequest: @escaping (Result<Festival, HttpRequestError>) -> Void, ServerApiRequest: Bool = true){
        
        let request = URLRequest(url: url)
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                
                //print("DATA", String(data: data, encoding: .utf8))
                
                var decodedData : Decodable? = nil
                
                do {
                decodedData = try JSONDecoder().decode(ListFestival.self, from: data)
                } catch let jsonError as NSError {
                    print("JSON decode failed: \(jsonError.localizedDescription)")
                }
                                
                
                guard let decodedResponse = decodedData else {
                    DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                    return
                }
                
                
                let festivalData : ListFestival = (decodedResponse as! ListFestival)
                
                guard let festival = self.festivalDataToFestival(data : festivalData) else{
                    DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                    return
                }
                                
                DispatchQueue.main.async {
                    endofrequest(.success(festival))
                }
            }
            else{
                DispatchQueue.main.async {
                    if let error = error {
                        guard let error = error as? URLError else {
                            endofrequest(.failure(.unknown))
                            return
                        }
                        endofrequest(.failure(.failingURL(error)))
                    }
                    else{
                        guard let response = response as? HTTPURLResponse else{
                            endofrequest(.failure(.unknown))
                            return
                        }
                        guard response.statusCode == 200 else {
                            endofrequest(.failure(.requestFailed))
                            return
                        }
                        endofrequest(.failure(.unknown))
                    }
                }
            }
        }.resume()
    }


    
    
    
    
    //ZONES
 
    
    static func zoneListDataToZoneList(data: ListZonesData) -> ZoneList? {
        var zones = [Zone]() //Ce que je renvoie
        for zData in data.zones{
            
            var gameListe = [Game]()
            
            for gData in zData.suivi_jeus{
                
                let game : Game = Game(j_titre: gData.jeu.j_titre, j_duree: gData.jeu.j_duree, j_ageMin : gData.jeu.j_ageMin ,j_nbMaxJoueur: gData.jeu.j_nbMaxJoueurs, j_nbMinJoueurs: gData.jeu.j_nbMinJoueurs, j_editor: gData.jeu.societe.soc_nom, j_type: gData.jeu.type_jeu.typJ_libelle)
                
                
                gameListe.append(game)
            }
            
            let zone : Zone = Zone(zone_libelle: zData.zo_libelle, jeux: gameListe)
            
            zones.append(zone)
            
        }
        
        return ZoneList(zones: zones)
        
    }
 
    
     //@Escaping -- Fait appel à une fonction ailleurs (asynchrone)
     static func loadZonesFromAPI(url surl: String, endofrequest: @escaping (Result<ZoneList, HttpRequestError>) -> Void){
         
         //vérifier l'url
         guard let url = URL(string: surl) else {
             endofrequest(.failure(.badURL(surl)))
             return
         }
         self.loadZonesFromAPI(url: url, endofrequest: endofrequest) //appel la méthode d'en dessous
     }
     
     static func loadZonesFromAPI(url: URL, endofrequest: @escaping (Result<ZoneList, HttpRequestError>) -> Void){
         self.loadZonesFromJsonData(url: url, endofrequest: endofrequest, ServerApiRequest: true) //appel la méthode d'en dessous
     }

     private static func loadZonesFromJsonData(url: URL, endofrequest: @escaping (Result<ZoneList, HttpRequestError>) -> Void, ServerApiRequest: Bool = true){
         
         let request = URLRequest(url: url)
         
         
         URLSession.shared.dataTask(with: request) { data, response, error in
             if let data = data {
                 
                 //print("DATA", String(data: data, encoding: .utf8))
                 
                 var decodedData : Decodable? = nil
                 
                 do {
                 decodedData = try JSONDecoder().decode(ListZonesData.self, from: data)
                 } catch let jsonError as NSError {
                     print("JSON decode failed: \(jsonError.localizedDescription)")
                 }
                 
                //print("DECODED DATA",decodedData)
                 
                 guard let decodedResponse = decodedData else {
                     DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                     return
                 }
                 
                //print("DECODED RESPONSE", decodedResponse)
                 
                
                 let listZonesData : ListZonesData = (decodedResponse as! ListZonesData)
                 
                 guard let zones = self.zoneListDataToZoneList(data : listZonesData) else{
                     DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                     return
                 }
                      
                //print("CONVERSION ZONE", zones)
                
                 DispatchQueue.main.async {
                     endofrequest(.success(zones))
                 }
 
             }
             else{
                 DispatchQueue.main.async {
                     if let error = error {
                         guard let error = error as? URLError else {
                             endofrequest(.failure(.unknown))
                             return
                         }
                         endofrequest(.failure(.failingURL(error)))
                     }
                     else{
                         guard let response = response as? HTTPURLResponse else{
                             endofrequest(.failure(.unknown))
                             return
                         }
                         guard response.statusCode == 200 else {
                             endofrequest(.failure(.requestFailed))
                             return
                         }
                         endofrequest(.failure(.unknown))
                     }
                 }
             }
         }.resume()
     }

    
    
    
    
    
    
    
    
    static func gameDataToGame(data: [FestivalGamesData]) -> GameList? {
        var games = [Game]()
        
        for sdata in data {
            for gdata in sdata.suivi_jeus {
    games.append(Game(j_titre: gdata.jeu.j_titre, j_duree: gdata.jeu.j_duree, j_ageMin: gdata.jeu.j_ageMin, j_nbMaxJoueur: gdata.jeu.j_nbMaxJoueurs, j_nbMinJoueurs: gdata.jeu.j_nbMinJoueurs, j_editor: gdata.jeu.societe.soc_nom, j_type: gdata.jeu.type_jeu.typJ_libelle))

            }
        }
        
        return GameList(games: games)
    }
 
    
    
    
        
    
    //@Escaping -- Fait appel à une fonction ailleurs (asynchrone)
    static func loadGamesFromAPI(url surl: String, endofrequest: @escaping (Result<GameList, HttpRequestError>) -> Void){
        
        //vérifier l'url
        guard let url = URL(string: surl) else {
            endofrequest(.failure(.badURL(surl)))
            return
        }
        self.loadGamesFromAPI(url: url, endofrequest: endofrequest) //appel la méthode d'en dessous
    }
    
    static func loadGamesFromAPI(url: URL, endofrequest: @escaping (Result<GameList, HttpRequestError>) -> Void){
        self.loadGamesFromJsonData(url: url, endofrequest: endofrequest, ServerApiRequest: true) //appel la méthode d'en dessous
    }

    private static func loadGamesFromJsonData(url: URL, endofrequest: @escaping (Result<GameList, HttpRequestError>) -> Void, ServerApiRequest: Bool = true){
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                
                var decodedData : Decodable? = nil
                
                print("DATA GAMES", String(data: data, encoding: .utf8))

                
                do {
                decodedData = try JSONDecoder().decode([FestivalGamesData].self, from: data)
                } catch let jsonError as NSError {
                    print("JSON decode failed: \(jsonError.localizedDescription)")
                }
                        
                print("DECODED DATASSSS", decodedData)
                
                guard let decodedResponse = decodedData else {
                    DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                    return
                }
                
                
                var gameListData : [FestivalGamesData]
              
                gameListData = (decodedResponse as! [FestivalGamesData])
                
                print("FESTIVALS", gameListData)
                   
                guard let games = self.gameDataToGame(data: gameListData) else{
                    DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                    return
                }
                
                print("MODEL", games)
                
                DispatchQueue.main.async {
                    endofrequest(.success(games))
                }
 
 
            }
            else{
                DispatchQueue.main.async {
                    if let error = error {
                        guard let error = error as? URLError else {
                            endofrequest(.failure(.unknown))
                            return
                        }
                        endofrequest(.failure(.failingURL(error)))
                    }
                    else{
                        guard let response = response as? HTTPURLResponse else{
                            endofrequest(.failure(.unknown))
                            return
                        }
                        guard response.statusCode == 200 else {
                            endofrequest(.failure(.requestFailed))
                            return
                        }
                        endofrequest(.failure(.unknown))
                    }
                }
            }
        }.resume()
    }
    
    // EDITORS
    
    static func editorGameDataToEditorGame(data: [EditorGameData]) -> EditorList? {
        var editors = [Editor]()
        
        var nom : String = ""
        for edata in data {
            var games = [Game]()
            
            let nomEditeur: String = edata.nomEditeur
            for jdata in data {
                if(jdata.nomEditeur == nomEditeur) {
                    games.append(Game(j_titre: jdata.j_titre,
                                      j_duree: jdata.j_duree,
                                      j_ageMin: jdata.j_ageMin,
                                      j_nbMaxJoueur: jdata.j_nbMaxJoueurs,
                                      j_nbMinJoueurs: jdata.j_nbMinJoueurs,
                                      j_editor : jdata.nomEditeur,
                                      j_type: jdata.type_jeu
                    ))
                }
            }
            
            var bool : Bool = false
            for editor in editors {
                if(editor.nomEditeur == nomEditeur){
                    bool = true
                }
            }
            
            if(!bool) {
                editors.append(Editor(nomEditeur: edata.nomEditeur, games: games))
            }
            
        }
        var editorsList : EditorList = EditorList(editors: editors)
        return editorsList
    }
    
    //@Escaping -- Fait appel à une fonction ailleurs (asynchrone)
    static func loadEditorsFromAPI(url surl: String, endofrequest: @escaping (Result<EditorList, HttpRequestError>) -> Void){
        
        //vérifier l'url
        guard let url = URL(string: surl) else {
            endofrequest(.failure(.badURL(surl)))
            return
        }
        self.loadEditorsFromAPI(url: url, endofrequest: endofrequest) //appel la méthode d'en dessous
    }
    
    static func loadEditorsFromAPI(url: URL, endofrequest: @escaping (Result<EditorList, HttpRequestError>) -> Void){
        self.loadEditorsFromJsonData(url: url, endofrequest: endofrequest, ServerApiRequest: true) //appel la méthode d'en dessous
    }

    private static func loadEditorsFromJsonData(url: URL, endofrequest: @escaping (Result<EditorList, HttpRequestError>) -> Void, ServerApiRequest: Bool = true){
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                
                //print("Data", String(data:data,encoding: .utf8))
                
                var decodedData : Decodable? = nil
                
                do {
                decodedData = try JSONDecoder().decode([EditorGameData].self, from: data)
                } catch let jsonError as NSError {
                    print("JSON decode failed: \(jsonError.localizedDescription)")
                }
                
                guard let decodedResponse = decodedData else {
                    DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                    return
                }
                
                
                var editorGameListData : [EditorGameData]
              
                editorGameListData = (decodedResponse as! [EditorGameData])
                
                //print("FESTIVALS", gameListData)
                   
                guard let editorGames = self.editorGameDataToEditorGame(data: editorGameListData) else{
                    DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                    return
                }
                
                //print("MODEL", editorGames)
                
                DispatchQueue.main.async {
                    endofrequest(.success(editorGames))
                }
 
 
            }
            else{
                DispatchQueue.main.async {
                    if let error = error {
                        guard let error = error as? URLError else {
                            endofrequest(.failure(.unknown))
                            return
                        }
                        endofrequest(.failure(.failingURL(error)))
                    }
                    else{
                        guard let response = response as? HTTPURLResponse else{
                            endofrequest(.failure(.unknown))
                            return
                        }
                        guard response.statusCode == 200 else {
                            endofrequest(.failure(.requestFailed))
                            return
                        }
                        endofrequest(.failure(.unknown))
                    }
                }
            }
        }.resume()
    }
    
}
