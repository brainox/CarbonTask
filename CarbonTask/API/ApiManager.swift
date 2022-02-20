//
//  ApiManager.swift
//  CarbonTask
//
//  Created by Decagon on 17/02/2022.
//

import Foundation


class ApiManager {
    
    
    func fetchFilms(completionHandler: @escaping (Movie?, Error?) -> Void) {
        let urlString = "https://www.omdbapi.com/?s=Batman&page=2&apikey=3f48dc1c"
        
        fetchGenericJSON(urlString: urlString, completion: completionHandler)
    }
    
    func fetchSearchMovie(searchTerm: String, completionHandler: @escaping (Movie?, Error?) -> Void) {
        
        let urlString =  "https://www.omdbapi.com/?s=\(searchTerm)&apikey=3f48dc1c"
        
        fetchGenericJSON(urlString: urlString, completion: completionHandler)
    }
    
    func fetchGenericJSON <T: Decodable>(urlString: String, completion: @escaping (T?, Error?)->Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url){ data, resp, err in
            if let err = err {
                completion(nil, err)
                return
            }
            guard let data = data else { return }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data)
                completion(objects, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
