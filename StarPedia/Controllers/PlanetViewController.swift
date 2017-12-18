//
//  PlanetViewController.swift
//  StarPedia
//
//  Created by Thibault Weiser on 22/11/2017.
//  Copyright © 2017 WSF. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class PlanetViewController: UIViewController {
    
    @IBOutlet weak var PlanetsTableView: UITableView!
    
    var planetsArray: [Planets] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PlanetsTableView.delegate = self
        PlanetsTableView.dataSource = self
        
        //affichage des données locales
        getLocalPlanets()
        
        //appel du WS avec alamofire
        getPlanets()
    }
    
    func getLocalPlanets() {
        let realm = try! Realm()
        planetsArray = Array(realm.objects(Planets.self))
    }
    
    func getPlanets() {
        let path = "planets"
        
        Alamofire.request(Constants.Api.base_url + path).responseJSON { (response) in
            
            if let jsonValue = response.result.value { // recupere le json à la racine
                let jsonObject = jsonValue as! [String: Any] // je tranforme ce json à la racine en un objet clef (String) et valeur (Any)
                
                let resultPlanetsArray = jsonObject["results"] as! [[String: Any]]// j'accede au champs "results" de ce dict et je transforme sa valeur en tableau de Any
                
                //MAPING
                //tableau de [String : Any] VERS tableau de People
                //[[String : Any]] VERS [People]
                
                for (index, planetsJson) in resultPlanetsArray.enumerated() {
                    
                    let name = planetsJson["name"] as! String
                    let diameter = planetsJson["diameter"] as! String
                    let population = planetsJson["population"] as! String
                    
                    let pictureURL = "https://img15.hostingpics.net/pics/954612PlanteVegeta.jpg"
                    
                    let planets = Planets()
                    planets.id = index + 1
                    planets.name = name
                    planets.diameter = diameter
                    planets.population = population
                    planets.pictureURL = pictureURL

                    
                    let realm = try! Realm()
                    
                    // Add to the Realm inside a transaction
                    try! realm.write {
                        realm.add(planets, update: true)
                    }
                }
                
                self.getLocalPlanets()
                self.PlanetsTableView.reloadData()
                
                for p in self.planetsArray {
                    print(p.name + " a un diametre de " + p.diameter + "km et abrite une population de " + p.population + " d'individus en tout genre ")
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "PlanetsDetailVC" {

            //1 - Je me sers du sender pour obtenir la cellule tappée
            let cell = sender as! UITableViewCell

            //2 - Je trouve l'index de cette cellule dans la tableView
            let index = PlanetsTableView.indexPath(for: cell)!.row

            //3 - Je trouve le people dans le tabeau de people
            let selectedPlanet = self.planetsArray[index]

            //4 - et je le passe au hero detail view controller
            let destVC = segue.destination as! PlanetDetailViewController

            destVC.planets = selectedPlanet //ICI QUE TOUT SE PASSE
        }
    }
}

extension PlanetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planetsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetCell", for: indexPath)
        
        let planets = planetsArray[indexPath.row]
        cell.textLabel?.text = planets.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}













