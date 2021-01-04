//
//  CoinBaseViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CoinBaseViewController: UIViewController  {
    
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
    }

    
}

extension CoinBaseViewController : UIPickerViewDataSource, UIPickerViewDelegate {
 
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
 
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let pickedCurrency = coinManager.currencyArray[row]
        currency.text = pickedCurrency
        amount.text = String(coinManager.getCoinPrice(for: pickedCurrency))
    }
}