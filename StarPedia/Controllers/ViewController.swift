//
//  ViewController.swift
//  StarPedia
//
//  Created by Iman Zarrabian on 19/10/2017.
//  Copyright © 2017 WSF. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var heroesTableView: UITableView!
    var peopleArray: [People] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heroesTableView.delegate = self
        heroesTableView.dataSource = self
        
        //affichage des données locales
        getLocalHeroes()
        
        //appel du WS avec alamofire
        getHeroes()
    }
    
    func getLocalHeroes() {
        let realm = try! Realm()
        peopleArray = Array(realm.objects(People.self))
    }
    
    func getHeroes() {
        let path = "people"
        
        Alamofire.request(Constants.Api.base_url + path).responseJSON { (response) in
            
            if let jsonValue = response.result.value { // recupere le json à la racine
                let jsonObject = jsonValue as! [String: Any] // je tranforme ce json à la racine en un objet clef (String) et valeur (Any)
                
                let heroesArray = jsonObject["results"] as! [[String: Any]]// j'accede au champs "results" de ce dict et je transforme sa valeur en tableau de Any
                
                //MAPING
                //tableau de [String : Any] VERS tableau de People
                //[[String : Any]] VERS [People]
            
                for (index, peopleJson) in heroesArray.enumerated() {
                    
                    let name = peopleJson["name"] as! String
                    let mass = peopleJson["mass"] as! String
                    let height = peopleJson["height"] as! String
                    
                    let pictureURL = "\(Constants.Images.base_url)heroes/\(index + 1).jpg"
                    let homeWorld = peopleJson["homeworld"] as! String
                    
                    let people = People()
                    people.id = index + 1
                    people.name = name
                    people.mass = mass
                    people.height = height
                    people.pictureURL = pictureURL
                    people.homeWorld = homeWorld
                    
                    let realm = try! Realm()
                    
                    // Add to the Realm inside a transaction
                    try! realm.write {
                        realm.add(people, update: true)
                    }
                }
                
                self.getLocalHeroes()
                self.heroesTableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "HeroDetailVC" {
            
            //1 - Je me sers du sender pour obtenir la cellule tappée
            let cell = sender as! UITableViewCell
            
            //2 - Je trouve l'index de cette cellule dans la tableView
            let index = heroesTableView.indexPath(for: cell)!.row
            
            //3 - Je trouve le people dans le tabeau de people
            let selectedHero = self.peopleArray[index]
            
            //4 - et je le passe au hero detail view controller
            let destVC = segue.destination as! HeroDetailViewController
            
            destVC.people = selectedHero //ICI QUE TOUT SE PASSE
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath)
        
        let people = peopleArray[indexPath.row]
        cell.textLabel?.text = people.name

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}












