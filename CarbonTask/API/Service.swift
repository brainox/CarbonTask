//
//  Service.swift
//  CarbonTask
//
//  Created by Decagon on 18/02/2022.
//

import Foundation
final class Service {
    
    private static let shared = Service()
    
    func fetchBatmanMovies(urlString: String, completion: @escaping (Movie?, Error?) -> Void) {
        fetchGenericJSON(urlString: urlString, completion: completion)
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
