//
//  ServerHelper.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/23/21.
//

import Foundation


struct FestivalData: Codable {
    //var fes_date: Date
    //fes_date.dateFormat("dd/MM/yyy")
    var societes: [ExhibitorData]
}

/*
struct EditorsListData: Codable {
    //var editors: [EditorData]
    //var societes
}
 */

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
    //var typJ_id: Int      --> pas besoin ?
    //var soc_id: Int      --> pas besoin ?
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

    static func festivalEditorToFestival(data: [FestivalData]) -> [Societe]?{
        var societes = [Societe]()
        //var societes = [Societe]()
        
        print("DATA", data)
        
        for fdata in data{
            for sdata in fdata.societes {

                var res = [Reservation]()
                for rdata in sdata.reservations {
                    
                    var suivJ = [SuiviJeu]()
                    for sjdata in rdata.suivi_jeus {
                        
                        
                        
                        let zone = Zone(zone_libelle: sjdata.zone.zo_libelle)
                        
                        let typeJeu = TypeJeu(libelle: sjdata.jeu.type_jeu.typJ_libelle)
                        let editor = Editor(nomEditeur: sjdata.jeu.societe.nomEditeur)
                        let game = Game(j_id: sjdata.jeu.j_id)
                       
                    
                        
                        let sj = SuiviJeu(suivJ_id: sjdata.suivJ_id, game: game, zone: zone)
                        suivJ.append(sj)
                    }

                    let tempo = Reservation(res_id: rdata.res_id, suiv_jeux: suivJ)
                    res.append(tempo)
                }
                let soc = Societe(soc_nom: sdata.soc_nom, reservations: res)
                societes.append(soc)
            }
            
        }
        return societes
    }
        
    
    //@Escaping -- Fait appel à une fonction ailleurs (asynchrone)
    static func loadEditorsFromAPI(url surl: String, endofrequest: @escaping (Result<[Editor], HttpRequestError>) -> Void){
        
        //vérifier l'url
        guard let url = URL(string: surl) else {
            endofrequest(.failure(.badURL(surl)))
            return
        }
        self.loadEditorsFromAPI(url: url, endofrequest: endofrequest) //appel la méthode d'en dessous
    }
    
    static func loadEditorsFromAPI(url: URL, endofrequest: @escaping (Result<[Editor], HttpRequestError>) -> Void){
        self.loadEditorsFromJsonData(url: url, endofrequest: endofrequest, ServerApiRequest: true) //appel la méthode d'en dessous
    }

    private static func loadEditorsFromJsonData(url: URL, endofrequest: @escaping (Result<[Editor], HttpRequestError>) -> Void, ServerApiRequest: Bool = true){
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                
                
                print("DATA", data)
                print("DATAS", String(data: data, encoding: .utf8)!)
                
                
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
                
                
                var festivalsListData : [FestivalData]
              
                festivalsListData = (decodedResponse as! [FestivalData])
                
                print("FESTIVALS", festivalsListData)
                   
                guard let societes = self.festivalEditorToFestival(data: festivalsListData) else{
                    DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                    return
                }
                
                print("MODEL", societes)
                
                /*DispatchQueue.main.async {
                    endofrequest(.success(societes))
                }*/
 
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

