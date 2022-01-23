//
//  ViewController.swift
//  CountryApp
//
//  Created by Tarkan Ozturk on 1/19/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let parser = Parser()
    var data = [Datum]()
    
    var chosenCountry : Datum?
    
    var favoriteStar = [Int:Bool]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parser.parse {
            data in
            self.data = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        
        let favoriteHome = self.storyboard?.instantiateViewController(withIdentifier: "favoritehome") as! FavoriteViewController
        favoriteHome.favoriteList = favoriteStar
        self.navigationController?.pushViewController(favoriteHome, animated: true)
        
    }
    
    
    // Favorite Star Button
    
    func blankfavoriteStar() {
        
        for i in 0...data.count {
            
            favoriteStar[i] = false
        }
    }
    
    //DetailsVC Page Segue
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenCountry = data[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
        
        let cell = tableView.cellForRow(at: indexPath) as! CountryCell
        cell.myImage.image = UIImage(named: "filledstar")
        favoriteStar[indexPath.row] = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! CountryCell
        cell.myImage.image = UIImage(named: "star")
        favoriteStar[indexPath.row] = false
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! detailsVC
            destinationVC.selectedCountry = chosenCountry
        }
    }
    
    //TableView Configurations
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CountryCell
        cell.textLabel?.text = data[indexPath.row].name
      
        //Favorite Button Config
        
        if favoriteStar[indexPath.row] == true
        {
            
            cell.myImage.image = UIImage(named: "filledstar")
            
        }
        else
        {
            cell.myImage.image = UIImage(named: "star")
        }
        cell.selectionStyle = .none
        return cell
    }
    
    //Deleting Contries

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

