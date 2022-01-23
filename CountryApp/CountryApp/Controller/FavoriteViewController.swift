//
//  FavoriteViewController.swift
//  CountryApp
//
//  Created by Tarkan Ozturk on 1/22/22.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var favoriteTableView: UITableView!
    
    var favoriteList = [Int:Bool]()
    var tempList = [Int]()
    
    var data = [Datum]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteTableView?.tableFooterView = UIView()
        
        for i in 0...favoriteList.count {
            
            if favoriteList[i] == true
            {
                tempList.append(i)
            }
        }
        
        favoriteTableView.reloadData()
    }
    
    //Favorite TableView Config
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        cell.textLabel?.text = "Item" //data[tempList[indexPath.row]].name
        return cell
    }
}


