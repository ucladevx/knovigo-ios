//
//  RecommendationsViewController.swift
//  Knovigo
//
//  Created by Abhishek Marda on 12/24/20.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var recommendationsTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var recommendations : [LocationInfo]?
    var searchResuls : [LocationInfo]?
    
    let numRecommendations = 3
    let numSearchResults = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recommendationsTable.dataSource = self
        recommendationsTable.layer.backgroundColor = UIColor.clear.cgColor
        recommendationsTable.backgroundColor = .clear
        recommendationsTable.register(UINib(nibName: "LocationTableViewCell", bundle: nil), forCellReuseIdentifier: "LocationCellIdentifier")
        loadRecommended(withInput: "")
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func viewMorePressed(_ sender: UIButton) {
        print("View More was pressed! Wow, such a useful function!")
    }
    
    func loadRecommended(withInput input: String){
        //ideally this function will use the API to get the information about a place
        //hard coded for testing purposes
        self.recommendations = [
            LocationInfo(name: "MyTreeHouse", address: "Nowhere", distancing: 40, density: 40, maskWearing: 40, image: #imageLiteral(resourceName: "q6_100"), priceRange: .LOW, tags: ["Funky", "Munky"]),
            LocationInfo(name: "Tatooine", address: "Idk", distancing: 40, density: 40, maskWearing: 60, image: #imageLiteral(resourceName: "knovigo-icon"), priceRange: .MEDIUM, tags: ["Dusty", "Sandy"]),
            LocationInfo(name: "Moon", address: "Right beside the Earth, in Solar System", distancing: 100, density: 0, maskWearing: 0, image: #imageLiteral(resourceName: "locationPic-1"), priceRange: .HIGH, tags: ["Rocky", "Satellite", "Recommended"])
        ]
        
        self.recommendationsTable.reloadData()
    }

}

//MARK:- TableView Delegate functions

extension SearchViewController : UITableViewDelegate {
    
}

//MARK:- TableView Data Source functions

extension SearchViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == recommendationsTable {
            return recommendations!.count
        }
        print("Error: neither table entered for row count in RecommendationsViewController")
        return 0;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCellIdentifier", for:indexPath) as! LocationInfoTableViewCell
        var locationInfo : LocationInfo
        locationInfo = self.recommendations![indexPath.row]
        cell.densityValue.text = String(locationInfo.density)+"%"
        cell.distancingValue.text = String(locationInfo.distancing)+"%"
        cell.maskWearingValue.text = String(locationInfo.maskWearing)+"%"
        
        cell.densitySlider.value = Float(locationInfo.density)
        cell.distancingSlider.value = Float(locationInfo.distancing)
        cell.maskWearingSlider.value = Float(locationInfo.maskWearing)
        
        cell.locationNameLabel.text = locationInfo.name
        cell.distanceLabel.text = String(0.30) + "mi" //temp hard code
        
        var tagsLine : String
        switch locationInfo.price {
        case .HIGH:
            tagsLine = "$$$"
        case .MEDIUM:
            tagsLine = "$$"
        case .LOW:
            tagsLine = "$"
        }
        tagsLine += " | "
        for tag in locationInfo.tags {
            tagsLine.append(tag)
            tagsLine.append(", ")
        }
        _ = tagsLine.popLast()
        _ = tagsLine.popLast()
        cell.tagsLabel.text = tagsLine
        cell.locationImage.image = locationInfo.profileImage
        
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.backgroundColor = .clear
        
        return cell
    }
    
    
}