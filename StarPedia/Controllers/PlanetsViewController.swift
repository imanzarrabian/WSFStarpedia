//
//  PlanetsViewController.swift
//  StarPedia
//
//  Created by Louis Paicheur on 17/11/2017.
//  Copyright © 2017 WSF. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class PlanetsViewController: UIViewController {
    
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
                
                for (index, planetJson) in planetsArray.enumerated() {
                    
                    let name = planetJson["name"] as! String
                    let rotation_period = planetJson["rotation_period"] as! String
                    let orbital_period = planetJson["orbital_period"] as! String
                    let diameter = planetJson["diameter"] as! String
                    
                    let pictureURL = "\(Constants.Images.base_url)planets/\(index + 1).jpg"
                    
                    let planet = Planet()
                    planet.id = index + 1
                    planet.name = name
                    planet.rotation_period = rotation_period
                    planet.orbital_period = orbital_period
                    planet.diameter = diameter
                    planet.pictureURL = pictureURL
                    
                    let realm = try! Realm()
                    
                    // Add to the Realm inside a transaction
                    try! realm.write {
                        realm.add(planet, update: true)
                    }
                }
                
                self.getLocalPlanets()
                self.planetsTableView.reloadData()
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
            
            //4 - et je le passe au planet detail view controller
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

