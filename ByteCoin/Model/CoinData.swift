//
//  CoinData.swift
//  ByteCoin
//
//  Created by Javier Heisecke  Echeverria on 1/4/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData : Codable {
    var asset_id_base : String
    var asset_id_quote : String
    var rate : Double
}
