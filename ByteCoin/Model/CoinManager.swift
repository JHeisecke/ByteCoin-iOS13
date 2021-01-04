//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoinData(response : CoinModel)
    func didFindError(error : Error)
}

struct CoinManager {
    
    let baseURL = "rest.coinapi.io"
    let apiKey = "\(Bundle.main.object(forInfoDictionaryKey: "apiKey") as! String)"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    var delegate : CoinManagerDelegate?
    
    func getCoinPrice(for currency: String) {
        if var urlComps = URLComponents(string: baseURL) {
            let queryItems = [URLQueryItem(name: "apikey", value: apiKey)]
            urlComps.scheme = "https"
            urlComps.host = baseURL
            urlComps.path = "/v1/exchangerate/BTC/\(currency)"
            urlComps.queryItems = queryItems
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: urlComps.url!) { (data, response, error) in
                if(error != nil) {
                    self.delegate?.didFindError(error: error!)
                }
                
                if let responseData = data {
                    self.parseJSON(response: responseData)
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(response: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: response)
            
            let coin = CoinModel(rate: decodedData.rate, from: decodedData.asset_id_base, to: decodedData.asset_id_quote)
            self.delegate?.didUpdateCoinData(response: coin)
        } catch {
            self.delegate?.didFindError(error: error)
        }
    }
}
