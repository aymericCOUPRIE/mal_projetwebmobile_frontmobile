//
//  ServerHelper.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/23/21.
//

import Foundation




struct FestivalData: Codable {
    var fes_date: Date
    
    
    
    //fes_date.dateFormat("dd/MM/yyy")
    //var societes: [ExhibitorData]
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
    var zone: ZoneData
}



struct GameData: Codable {
    var j_id: Int     // --> pas besoin ?
    var j_titre: String
    var j_ageMin: Int
    var j_duree: String
    var j_nbMaxJoueurs: Int
    var j_nbMinJoueurs: Int
    var j_lienNotice: String
    var type_jeu: GameTypeData
    var societe: EditorData
}

struct ZoneData: Codable {
    var zo_libelle: String
}

struct GameTypeData: Codable {
    var typJ_libelle: String
}

struct EditorData: Codable {
    var nomEditeur: String
}

struct ServerHelper {
    
    
    
    static func festivalDataToFestival(data: FestivalData) -> Festival? {
        print("DATE MCLC", data.fes_date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-JJ"
        if let date = dateFormatter.date(from: "2020-20-05") {
            return Festival(date: date)
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
                
                print("DATA", String(data: data, encoding: .utf8))
                
                
                var decodedData : Decodable? = nil
                
                do {
                decodedData = try JSONDecoder().decode(FestivalData.self, from: data)
                } catch let jsonError as NSError {
                    print("JSON decode failed: \(jsonError.localizedDescription)")
                }
                                
                print("DECODED DATA", decodedData)
                
                guard let decodedResponse = decodedData else {
                    DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                    return
                }
                
                
                var festivalData : FestivalData
              
                festivalData = (decodedResponse as! FestivalData)
                
                print("FESTIVAL", festivalData)
                   
                guard let festival = self.festivalDataToFestival(data: festivalData) else{
                    DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                    return
                }
                
                print("MODEL", festival)
                
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



    /*
    static func gameDataToGame(data: [GameData]) -> [Game]? {
            return
    }
 */
    
    
    
        
    
    //@Escaping -- Fait appel à une fonction ailleurs (asynchrone)
    static func loadGamesFromAPI(url surl: String, endofrequest: @escaping (Result<[Game], HttpRequestError>) -> Void){
        
        //vérifier l'url
        guard let url = URL(string: surl) else {
            endofrequest(.failure(.badURL(surl)))
            return
        }
        self.loadGamesFromAPI(url: url, endofrequest: endofrequest) //appel la méthode d'en dessous
    }
    
    static func loadGamesFromAPI(url: URL, endofrequest: @escaping (Result<[Game], HttpRequestError>) -> Void){
        self.loadGamesFromJsonData(url: url, endofrequest: endofrequest, ServerApiRequest: true) //appel la méthode d'en dessous
    }

    private static func loadGamesFromJsonData(url: URL, endofrequest: @escaping (Result<[Game], HttpRequestError>) -> Void, ServerApiRequest: Bool = true){
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                
                var decodedData : Decodable? = nil
                
                do {
                decodedData = try JSONDecoder().decode([FestivalData].self, from: data)
                } catch let jsonError as NSError {
                    print("JSON decode failed: \(jsonError.localizedDescription)")
                }
                                
                
                guard let decodedResponse = decodedData else {
                    DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                    return
                }
                
                
                var gameListData : [GameData]
              
                gameListData = (decodedResponse as! [GameData])
                
                print("FESTIVALS", gameListData)
                   
                /*guard let games = self.gameDataToGame(data: gameListData) else{
                    DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                    return
                }
                
                print("MODEL", games)
                
                DispatchQueue.main.async {
                    endofrequest(.success(games))
                }
 */
 
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







