//
//  ListPlanet.swift
//  StarPedia
//
//  Created by Théo DUGAUTIER on 15/11/2017.
//  Copyright © 2017 WSF. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class ListPlanetController: UIViewController {
    
    @IBOutlet weak var planetTabelView: UITableView!
    var planetArray: [Planet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planetTabelView.delegate = self
        planetTabelView.dataSource = self
        
        getLocalPlanets()
        
        getPlanet()
    }
    
    func getLocalPlanets() {
        let realm = try! Realm()
        planetArray = Array(realm.objects(Planet.self))
    }
    
    func getPlanet() {
        let path = "planets"

        Alamofire.request(Constants.Api.base_url + path).responseJSON { (response) in

            if let jsonValue = response.result.value {
                let jsonObject = jsonValue as! [String: Any]

                let planetArray = jsonObject["results"] as! [[String: Any]]

                for (index, planetJson) in planetArray.enumerated() {

                    let name = planetJson["name"] as! String
                    let diameter = planetJson["diameter"] as! String

                    // let pictureURL = "http://www.jdubuzz.com/files/2015/12/landscape-1445356666-star-wars-luke-skywalker-tatooine.jpg"

                    let planet = Planet()
                    planet.id = index + 1
                    planet.name = name
                    planet.diameter = diameter
                    
                    let realm = try! Realm()

                    try! realm.write {
                        realm.add(planet, update: true)
                    }
                }
                
                self.getLocalPlanets()
                self.planetTabelView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PlanetSegue" {
            
            //1 - Je me sers du sender pour obtenir la cellule tappée
            let cell = sender as! UITableViewCell
            
            //2 - Je trouve l'index de cette cellule dans la tableView
            let index = planetTabelView.indexPath(for: cell)!.row
            
            //3 - Je trouve le people dans le tabeau de people
            let selectedPlanet = self.planetArray[index]
            
            //4 - et je le passe au hero detail view controller
            let destVC = segue.destination as! PlanetDetailedViewController
            
            destVC.planet = selectedPlanet //ICI QUE TOUT SE PASSE
        }
    }
}

extension ListPlanetController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planetArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "planetCell", for: indexPath)
        
        let planet = planetArray[indexPath.row]
        cell.textLabel?.text = planet.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}











