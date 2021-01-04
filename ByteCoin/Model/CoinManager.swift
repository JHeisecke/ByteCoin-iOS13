//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "rest.coinapi.io"
    let apiKey = "\(Bundle.main.object(forInfoDictionaryKey: "apiKey") as! String)"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    
    func getCoinPrice(for currency: String) -> Double{
        if var urlComps = URLComponents(string: baseURL) {
            let queryItems = [URLQueryItem(name: "apikey", value: apiKey)]
            urlComps.scheme = "https"
            urlComps.host = baseURL
            urlComps.path = "/v1/exchangerate/BTC/\(currencyArray[19])"
            urlComps.queryItems = queryItems
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: urlComps.url!) { (data, response, error) in
                if(error != nil) {
                    print(error!)
                }
                
                if let responseData = data {
                    self.parseJSON(response: responseData)
                }
            }
            
            task.resume()
        }
        return 0.0
    }
    
    func parseJSON(response: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: response)
            
            let coin = CoinModel(rate: decodedData.rate, from: decodedData.asset_id_base, to: decodedData.asset_id_quote)
            print(coin)
        } catch {
            print(error)
        }
    }
}
