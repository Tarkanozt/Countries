//
//  Parser.swift
//  CountryApp
//
//  Created by Tarkan Ozturk on 1/19/22.
//

import Foundation

struct Parser {
    
    func parse(comp : @escaping ([Datum])->())  {
        
        let api = URL(string:"https://wft-geo-db.p.rapidapi.com/v1/geo/countries?offset=190&limit=10&rapidapi-key=04335bebfamshb7a2bb81a89102cp1da48ejsn38f1e210adf6")
        
        URLSession.shared.dataTask(with: api!) {
            data, response, error in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            do {
            let result = try JSONDecoder().decode(Welcome.self, from: data!)
                comp(result.data)
            
            } catch {
                
            }
        }.resume()
    }
}
