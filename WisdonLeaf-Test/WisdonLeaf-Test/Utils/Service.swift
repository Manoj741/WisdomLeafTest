//
//  Service.swift
//  WisdonLeaf-Test
//
//  Created by manoj kumar on 11/08/20.
//  Copyright © 2020 Manoj Kumar M. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service()
    let session = URLSession.shared
    private let baseUrl = "https://picsum.photos/v2/list?page=2&limit=20"
    
    private func singleObjectGetRequest<T:Decodable>( model:T.Type, completion: @escaping ([T]?, Error?) -> Void ){
        
        let endPointUrl = URL(string: baseUrl)
        
        let dataTask = session.dataTask(with: endPointUrl!) {
            (data, response, error) in
            
            guard let responseData = data else {
                completion(nil, error)
                return
            }
            
            print(responseData)
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let decodedModel = try decoder.decode([T].self, from: responseData)
                completion(decodedModel, nil)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                completion(nil, error)
            }
        }
    
        dataTask.resume()
    }
    
    // fetch photos information from the remote Url using JSONDecoder by passing the model type
    func fetchPhotos( handler: @escaping ([Photo]?, Error?) -> Void ){
        
        self.singleObjectGetRequest(model: Photo.self) { (res, err) in
            
            if err == nil {
                handler(res, nil)
            } else {
                handler(nil, err)
                print("Error: \(err?.localizedDescription ?? "Unknown error")")
            }
        }
    }
}
