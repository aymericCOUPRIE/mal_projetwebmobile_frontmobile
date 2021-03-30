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

    static func festivalDataToFestival(data: [FestivalData]) -> Festival?{
        
        var societes = [Societe]()
       
        print("DATA", data)
        
        for fdata in data{
            for sdata in fdata.societes {

                var res = [Reservation]()
                for rdata in sdata.reservations {
                    
                    var suivJ = [SuiviJeu]()
                    for sjdata in rdata.suivi_jeus {
                        
                        
                        
                        let zone = Zone(zone_libelle: sjdata.zone.zo_libelle)
                        print("ZONE", zone)
                        
                        let typeJeu = TypeJeu(libelle: sjdata.jeu.type_jeu.typJ_libelle)
                        print("TYPEJEU", typeJeu)
                        
                        let editor = Editor(nomEditeur: sjdata.jeu.societe.nomEditeur)
                        print("EDITOR", editor)
                        
                        
                        let j_id: Int = sjdata.jeu.j_id
                        let j_titre: String = sjdata.jeu.j_titre
                        //let j_duree: String //PAS DE TYPE STRING
                        let j_nbMaxJoueur: Int = sjdata.jeu.j_nbMaxJoueurs
                        let j_nbMinJoueurs: Int = sjdata.jeu.j_nbMinJoueurs
                        let j_lienNotice: String = sjdata.jeu.j_lienNotice
                        
                        let game = Game(j_id: j_id, j_titre: j_titre, j_nbMaxJoueur: j_nbMaxJoueur, j_nbMinJoueurs: j_nbMinJoueurs, j_lienNotice: j_lienNotice, j_editor: editor, j_type: typeJeu)
                        
                        print("GAME", game)
                    
                        
                        let sj = SuiviJeu(suivJ_id: sjdata.suivJ_id, game: game, zone: zone)
                        suivJ.append(sj)
                        print("SUIVI JEU", sj)
                        
                    }

                    let tempo = Reservation(res_id: rdata.res_id, suiv_jeux: suivJ)
                    res.append(tempo)
                }
                let soc = Societe(soc_nom: sdata.soc_nom, reservations: res)
                societes.append(soc)
            }
            
        }
        return Festival(societes: societes)
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
                   
                guard let festival = self.festivalDataToFestival(data: festivalsListData) else{
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
}

