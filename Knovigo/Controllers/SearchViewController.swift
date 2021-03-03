//
//  RecommendationsViewController.swift
//  Knovigo
//
//  Created by Abhishek Marda on 12/24/20.
//

import UIKit
import DropDown

class SearchViewController: UIViewController {

    @IBOutlet weak var recommendationsTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var recommendations : [LocationInfo]?
    var filterResuls : [LocationInfo]?
    var searchResuls : [LocationInfo]?
    
    var filterActive : Bool = false
    var searchActive : Bool = false
    var filters: [String: Bool] = ["Least Crowded":false, "Nearest Me":false];
    
    let numRecommendations = 3
    let numSearchResults = 3
    let menu: DropDown = {
        let menu = DropDown();
        menu.dataSource = [
            "Least Crowded",
            "Nearest Me"
        ];
        menu.cellNib = UINib(nibName: "DropDownCell", bundle: nil);
        menu.cornerRadius = 15;
        menu.width = 200;
        menu.cellHeight = 50;
        return menu;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recommendationsTable.dataSource = self
        recommendationsTable.layer.backgroundColor = UIColor.clear.cgColor
        recommendationsTable.backgroundColor = .clear
        recommendationsTable.register(UINib(nibName: "LocationTableViewCell", bundle: nil), forCellReuseIdentifier: "LocationCellIdentifier")
        loadRecommended(withInput: "")
        searchBar.delegate = self
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func viewMorePressed(_ sender: UIButton) {
        menu.selectionAction = { [unowned self](in: Int, it: String) in
            menu.customCellConfiguration = {index, title, cell in
                guard let cell = cell as? FilterViewCell else {
                    return
                }
                filters[title] = cell.toggleswitch.isOn;
                filterRecommendations()
            }
        }
        menu.cancelAction = { [unowned self] in
            menu.customCellConfiguration = {index, title, cell in
                guard let cell = cell as? FilterViewCell else {
                    return
                }
                filters[title] = cell.toggleswitch.isOn;
                filterRecommendations()
            }
            filterRecommendations()
        };
        menu.anchorView = sender;
        menu.bottomOffset = CGPoint(x:0, y:sender.frame.size.height);
        menu.show();
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
    
    func filterRecommendations() {
        if(filters["Least Crowded"]! || filters["Nearest Me"]!) {
            filterResuls = recommendations?.filter({ (location) -> Bool in
                if(filters["Least Crowded"]! && filters["Nearest Me"]!) {
                    return location.density < 30 && location.distancing < 100;
                } else if(filters["Least Crowded"]!) {
                    return location.density < 30;
                } else {
                    return location.distancing < 100;
                }
            });
            filterActive = true;
        } else {
            filterActive = false;
        }
        self.recommendationsTable.reloadData()
    }
}

//MARK:- SearchBar Delegate functions

extension SearchViewController : UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (filterActive) {
            searchResuls = filterResuls?.filter({ (location) -> Bool in
                let tmp: NSString = location.name as NSString;
                let range = tmp.range(of: searchText, options: .caseInsensitive);
                return range.location != NSNotFound;
            });
        } else {
            searchResuls = recommendations?.filter({ (location) -> Bool in
                let tmp: NSString = location.name as NSString;
                let range = tmp.range(of: searchText, options: .caseInsensitive);
                return range.location != NSNotFound;
            });
        }
        if (searchResuls!.count == 0) {
            searchActive = false;
        } else {
            searchActive = true;
        }
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
            if (searchActive) {
                return searchResuls!.count;
            }
            if (filterActive) {
                return filterResuls!.count;
            }
            return recommendations!.count
        }
        print("Error: neither table entered for row count in RecommendationsViewController")
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCellIdentifier", for:indexPath) as! LocationInfoTableViewCell
        var locationInfo : LocationInfo
        if (searchActive) {
            locationInfo = self.searchResuls![indexPath.row]
        } else if (filterActive) {
            locationInfo = self.filterResuls![indexPath.row]
        } else {
            locationInfo = self.recommendations![indexPath.row]
        }
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
