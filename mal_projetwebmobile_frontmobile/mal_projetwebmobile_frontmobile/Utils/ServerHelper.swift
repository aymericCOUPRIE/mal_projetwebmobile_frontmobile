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
    var j_id: Int
    var nomEditeur: String
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
        
    

    static func loadEditorsFromAPI(url surl: String, endofrequest: @escaping (Result<[Editor], HttpRequestError>) -> Void){
        guard let url = URL(string: surl) else {
            endofrequest(.failure(.badURL(surl)))
            return
        }
        self.loadTracksFromAPI(url: url, endofrequest: endofrequest)
    }
    
    static func loadEditorsFromAPI(url: URL, endofrequest: @escaping (Result<[Editor], HttpRequestError>) -> Void){
        self.loadEditorsFromJsonData(url: url, endofrequest: endofrequest, ServerApiRequest: true)
    }

    private static func loadEditorsFromJsonData(url: URL, endofrequest: @escaping (Result<[Editor], HttpRequestError>) -> Void, ServerApiRequest: Bool = true){
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decodedData : Decodable?
                if ServerApiRequest{
                    decodedData = try? JSONDecoder().decode(EditorsListData.self, from: data)
                }
                else{
                    decodedData = try? JSONDecoder().decode([EditorData].self, from: data)
                }
                guard let decodedResponse = decodedData else {
                    DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                    return
                }
                var editorsListData : [EditorData]
                if ServerApiRequest{
                    editorsListData = (decodedResponse as! EditorsListData).editors
                }
                else{
                    editorsListData = (decodedResponse as! [EditorData])
                }
                
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

