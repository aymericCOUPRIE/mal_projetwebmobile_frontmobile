//
//  ServerHelper.swift
//  mal_projetwebmobile_frontmobile
//
//  Created by user190207 on 3/23/21.
//

import Foundation


struct EditorsListData: Codable {
    var editors: [EditorData]
}

struct EditorData: Codable {
    var nomEditeur: String
    var j_id: Int //A supprimer plus tard
    //var listGames: [GameData]
}

struct GameData: Codable {
    var j_id: Int
    var j_title: String
}

struct ServerHelper {

    static func editorDataToEditor(data: [EditorData]) -> [Editor]?{
        var editors = [Editor]()
        for edata in data{
            let editor = Editor(j_id: edata.j_id, nomEditeur: edata.nomEditeur)
            editors.append(editor)
        }
        return editors
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
                                               
                let decodedData : Decodable?
                
                if ServerApiRequest{
                    decodedData = try? JSONDecoder().decode([EditorData].self, from: data)
                }
                else{
                    decodedData = try? JSONDecoder().decode([EditorData].self, from: data)
                }
                guard let decodedResponse = decodedData else {
                    DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                    return
                }
                var editorsListData : [EditorData]
              
                    editorsListData = (decodedResponse as! [EditorData])
                   
                guard let editors = self.editorDataToEditor(data: editorsListData) else{
                    DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                    return
                }
                
                print("Editors ", editors[0].nomEditeur)
                
                DispatchQueue.main.async {
                    endofrequest(.success(editors))
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

