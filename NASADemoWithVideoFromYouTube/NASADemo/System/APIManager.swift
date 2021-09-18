//
//  APIManager.swift
//  NasaApiDemo
//
//  Created by Герман on 17.09.21.
//

import Foundation
import Alamofire

class APIManager{
    
    private init(){}
    
    static let shared = APIManager()
    
    func getContent(_ completion: @escaping(Astronomy?, String?) -> Void) {
        
        let apiLink = "https://api.nasa.gov/planetary/apod?api_key=OzTrIkurB7sN0bUaR7gdGo6VO0BN8IC10u2oa58Q"
        
        AF.request(apiLink).responseDecodable(of: Astronomy.self){
            
            (responce) in
            guard let object = responce.value
            else {
                completion(nil, "Parsing Error")
                return
            }
            
            completion(object, nil)
            
        }
    }
    
}
