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

class PlanetController: UIViewController {
    
    @IBOutlet weak var planetTableView: UITableView!
    
    var planetArray: [Planet] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        planetTableView.delegate = self
        planetTableView.dataSource = self
        
        //affichage des données locales
        getLocalPlanets()
        
        //appel du WS avec alamofire
        getPlanets()
        
    }
    
    func getLocalPlanets() {
        let realm = try! Realm()
        planetArray = Array(realm.objects(Planet.self))
    }
    
    func getPlanets() {
        
        let path = "planets"
        
        Alamofire.request(Constants.Api.base_url + path).responseJSON { (response) in
            
            print(response)
            
            if let jsonValue = response.result.value { // recupere le json à la racine
                let jsonObject = jsonValue as! [String: Any] // je tranforme ce json à la racine en un objet clef (String) et valeur (Any)
                
                let planetArray = jsonObject["results"] as! [[String: Any]]// j'accede au champs "results" de ce dict et je transforme sa valeur en tableau de Any
                
                //MAPING
                //tableau de [String : Any] VERS tableau de People
                //[[String : Any]] VERS [People]
                
                for (index, planetJson) in planetArray.enumerated() {
                    
                    let name = planetJson["name"] as! String
                    let orbital_period = planetJson["orbital_period"] as! String
                    let rotation_period = planetJson["rotation_period"] as! String
                    let climate = planetJson["climate"] as! String
                    let diameter = planetJson["diameter"] as! String
                    let population = planetJson["population"] as! String
                    
                    // get Picture and replace whitespaces with underscores
                    let nameTrim = name.components(separatedBy: .whitespacesAndNewlines)
                        .filter { !$0.isEmpty }
                        .joined(separator: "_")
                    let pictureURL = "http://176.31.121.178/swift/swapi/" + nameTrim + ".png"
                    
                    let planet = Planet()
                    planet.id = index + 1
                    planet.name = name
                    planet.orbital = orbital_period
                    planet.rotation = rotation_period
                    planet.pictureURL = pictureURL
                    planet.climate = climate
                    planet.diameter = diameter
                    planet.population = population
                    
                    let realm = try! Realm()
                    
                    // Add to the Realm inside a transaction
                    try! realm.write {
                        realm.add(planet, update: true)
                    }
                }
                
                self.getLocalPlanets()
                self.planetTableView.reloadData()
                
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "planetSegue" {
            
            //1 - Je me sers du sender pour obtenir la cellule tappée
            let cell = sender as! UITableViewCell
            
            //2 - Je trouve l'index de cette cellule dans la tableView
            let index = planetTableView.indexPath(for: cell)!.row
            
            //3 - Je trouve la planete dans le tabeau de people
            let selectedPlanet = self.planetArray[index]
            
            //4 - et je le passe au planet detail view controller
            let destVC = segue.destination as! PlanetDetailViewController
            
            destVC.planet = selectedPlanet //ICI QUE TOUT SE PASSE
        }
    }
}

extension PlanetController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planetArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetCell", for: indexPath)
        
        let planet = planetArray[indexPath.row]
        cell.textLabel?.text = planet.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}













