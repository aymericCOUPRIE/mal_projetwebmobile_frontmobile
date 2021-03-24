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
    var j_id: Int //A supprimer plus tard
    var nomEditeur: String
    var listGames: [GameData]
}

struct GameData: Codable {
    var j_id: Int
    var j_title: String
}

struct ServerHelper {

    static func editorDataToEditor(data: [EditorData]) -> [Editor]?{
        var editors = [Editor]()
        for edata in data{
            let id : Int = edata.j_id
            let editor = Editor(j_id: id, nomEditeur: edata.nomEditeur)
            editors.append(editor)
        }
        return editors
    }
        
    
    //@Escaping -- Fait appel à une fonction ailleurs (asynchrone)
    static func loadEditorsFromAPI(url surl: String, endofrequest: @escaping (Result<[Editor], HttpRequestError>) -> Void){
        
        print("Etape 3")
        guard let url = URL(string: surl) else {
            endofrequest(.failure(.badURL(surl)))
            return
        }
        self.loadEditorsFromAPI(url: url, endofrequest: endofrequest)
    }
    
    static func loadEditorsFromAPI(url: URL, endofrequest: @escaping (Result<[Editor], HttpRequestError>) -> Void){
        print("Etape 4")
        self.loadEditorsFromJsonData(url: url, endofrequest: endofrequest, ServerApiRequest: true)
    }

    private static func loadEditorsFromJsonData(url: URL, endofrequest: @escaping (Result<[Editor], HttpRequestError>) -> Void, ServerApiRequest: Bool = true){
        
        print("Etape 5")
        let request = URLRequest(url: url)
        
        print("Etape 5.1")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                
                print("Etape 5.2")
                let decodedData : Decodable?
                if ServerApiRequest{
                    print("Etape 5.3")
                    decodedData = try? JSONDecoder().decode(EditorsListData.self, from: data)
                }
                else{
                    print("Etape 5.4")
                    decodedData = try? JSONDecoder().decode([EditorData].self, from: data)
                }
                print("Etape 5.5")
                guard let decodedResponse = decodedData else {
                    DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                    return
                }
                print("Etape 5.6")
                var editorsListData : [EditorData]
                /*if ServerApiRequest{
                    editorsListData = (decodedResponse as! EditorsListData).editors
                }
                else{*/
                    editorsListData = (decodedResponse as! [EditorData])
                //}
                
                print("Etape 6", editorsListData)
                
                guard let editors = self.editorDataToEditor(data: editorsListData) else{
                    DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                    return
                }
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

