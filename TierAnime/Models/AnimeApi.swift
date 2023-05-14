//
//  AnimeApi.swift
//  TierAnime
//
//  Created by Elena Galluzzo on 2023-05-01.
//

import Foundation

class AnimeApi: NSObject {
    static let sharedInstance = AnimeApi()
    
    func callAnimeApi(title: String, completionHandler: @escaping(_ error : Error?, _ animeModel: AnimeModel?)->()) {
        
        guard let path = Bundle.main.path(forResource: "Keys", ofType: "plist"), let keysDict =  NSDictionary(contentsOfFile: path), let apiKey = keysDict["apiKey"] as? String else {
            completionHandler(nil, nil)
            return
        }
        
        let headers = [
            "X-RapidAPI-Key": apiKey,
            "X-RapidAPI-Host": "anime-db.p.rapidapi.com"
        ]
        let escapedAddress = title.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        guard let url = URL(string: "https://anime-db.p.rapidapi.com/anime?page=1&size=10&search=\(escapedAddress ?? "Hunter")")
        else {
            return
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error)  in
            if (error != nil) {
                completionHandler(error, nil)
            } else {
                guard let data = data else { return }
                do {
                    let animeObject = try JSONDecoder().decode(AnimeModel.self, from: data)
                    completionHandler(nil, animeObject)
                } catch let error {
                    completionHandler(error, nil)
                }
            }
        }
        dataTask.resume()
        
    }
    
}
    
