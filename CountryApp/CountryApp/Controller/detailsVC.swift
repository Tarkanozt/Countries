//
//  detailsVC.swift
//  CountryApp
//
//  Created by Tarkan Ozturk on 1/20/22.
//

import UIKit

class detailsVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var codeLabel: UILabel!
    
    @IBOutlet weak var currencyLabel: UILabel!
    
    let parser = Parser()
    var data = [Datum]()
    
    var selectedCountry : Datum?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeLabel.text = "Country Code: \(String(describing: selectedCountry!.code))"
        codeLabel.textColor = .black
        currencyLabel.text = "Currency: \(String(describing: selectedCountry!.currencyCodes))"
        currencyLabel.textColor = .black
    }

    // For More Information Button
    
    @IBAction func forMoreInfoButton(_ sender: Any) {
        
        UIApplication.shared.open(URL(string: "https://www.wikidata.org/wiki/" + (String(describing: selectedCountry!.wikiDataID)))! as URL, options: [:], completionHandler: nil)
        
    }
    
}
