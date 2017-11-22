//
//  PlanetsViewController.swift
//  StarPedia
//
//  Created by Nina Queuche on 15/11/2017.
//  Copyright © 2017 WSF. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class PlanetsViewController : UIViewController {
    @IBOutlet weak var planetsTableView: UITableView!
    var planetsArray: [Planet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planetsTableView.delegate = self
        planetsTableView.dataSource = self
        
        //affichage des données locales
        getLocalPlanets()
        
        //appel du WS avec alamofire
        getPlanets()
    }
    
    func getLocalPlanets() {
        let realm = try! Realm()
        planetsArray = Array(realm.objects(Planet.self))
    }
    
    func getPlanets() {
        let path = "planets"
        
        Alamofire.request(Constants.Api.base_url + path).responseJSON { (response) in
            
            if let jsonValue = response.result.value { // recupere le json à la racine
                let jsonObject = jsonValue as! [String: Any] // je tranforme ce json à la racine en un objet clef (String) et valeur (Any)
                
                let planetsArray = jsonObject["results"] as! [[String: Any]]// j'accede au champs "results" de ce dict et je transforme sa valeur en tableau de Any
                
                //MAPING
                //tableau de [String : Any] VERS tableau de People
                //[[String : Any]] VERS [People]
                
                for (index, planetsJson) in planetsArray.enumerated() {
                    
                    let name = planetsJson["name"] as! String
                    let rotationPeriod = planetsJson["rotation_period"] as! String
                    let orbitalPeriod = planetsJson["orbital_period"] as! String
                    
                    let pictureURL = "http://www.jdubuzz.com/files/2015/12/landscape-1445356666-star-wars-luke-skywalker-tatooine.jpg"
                    let diameter = planetsJson["diameter"] as! String
                    let climate = planetsJson["climate"] as! String
                    let population = planetsJson["population"] as! String

                    
                    let planet = Planet()
                    
                    
                    planet.id = index + 1
                    planet.name = name
                    planet.rotationPeriod = rotationPeriod
                    planet.orbitalPeriod = orbitalPeriod
                    planet.pictureURL = pictureURL
                    planet.diameter = diameter
                    planet.climate = climate
                    planet.population = population
                    
                    let realm = try! Realm()
                    
                    // Add to the Realm inside a transaction
                    try! realm.write {
                        realm.add(planet, update: true)
                    }
                }
                
                self.getLocalPlanets()
                self.planetsTableView.reloadData()
                
                for p in self.planetsArray {
                    print(p.name + " met " + p.orbitalPeriod + "à faire un tour et mesure " + p.diameter + "cm")
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PlanetDetailVC" {
            
            //1 - Je me sers du sender pour obtenir la cellule tappée
            let cell = sender as! UITableViewCell
            
            //2 - Je trouve l'index de cette cellule dans la tableView
            let index = planetsTableView.indexPath(for: cell)!.row
            
            //3 - Je trouve le people dans le tabeau de people
            let selectedPlanet = self.planetsArray[index]
            
            //4 - et je le passe au hero detail view controller
            let destVC = segue.destination as! PlanetDetailViewController
            
            destVC.planet = selectedPlanet //ICI QUE TOUT SE PASSE
        }
    }
}

extension PlanetsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planetsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetCell", for: indexPath)
        
        let planet = planetsArray[indexPath.row]
        cell.textLabel?.text = planet.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
