//
//  RecommendationsViewController.swift
//  Knovigo
//
//  Created by Abhishek Marda on 12/24/20.
//

import UIKit
import DropDown
import GoogleMapsUtils

struct LocationResponse:Decodable {
    let name:String
    let distance:Double
    let address:String
    let types:[String]
    let price_level:Int
    let agg_density:Int
    let agg_social:Int
    let agg_mask:Int
    let agg_density_n:Int?
    let agg_social_n:Int?
    let agg_mask_n:Int?
}

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
    let menu: DropDown = DropDown();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recommendationsTable.dataSource = self
        recommendationsTable.delegate = self
        recommendationsTable.layer.backgroundColor = UIColor.clear.cgColor
        recommendationsTable.backgroundColor = .clear
        recommendationsTable.register(UINib(nibName: "LocationTableViewCell", bundle: nil), forCellReuseIdentifier: "LocationCellIdentifier")
        
        loadRecommended(withInput: "")
        searchBar.delegate = self
        
        menu.dataSource = [
            "Least Crowded",
            "Nearest Me"
        ];
        menu.cellNib = UINib(nibName: "DropDownCell", bundle: nil);
        menu.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
           guard let cell = cell as? FilterViewCell else {
                return
            }
            cell.delegate = self
        }
        menu.cornerRadius = 15;
        menu.width = 200;
        menu.cellHeight = 50;
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func viewMorePressed(_ sender: UIButton) {
        menu.anchorView = sender;
        menu.bottomOffset = CGPoint(x:0, y:sender.frame.size.height);
        menu.show();
    }
    
    func loadRecommended(withInput input: String){
        self.recommendations = [];
        //ideally this function will use the API to get the information about a place
        attemptLoadAPI { (success) in
            DispatchQueue.main.async {
                self.recommendationsTable.reloadData();
            }
            print(success)
        }
        
        self.recommendationsTable.reloadData();
    }
    
    func attemptLoadAPI(_ completion:@escaping (Bool)->()) {
        let url = URL(string: "http://localhost:3000/test") //Change this to actual endpoint
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                completion(false)
                return
            }
            do {
                var temp:[LocationInfo] = []
                if let locationDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    let locationArray = locationDict["data"] as! [[String:Any]];
                    for location in locationArray {
                        let locationStruct:LocationResponse? = try JSONDecoder().decode(LocationResponse.self, from: JSONSerialization.data(withJSONObject: location))
                        var priceVal : PriceRange
                        switch locationStruct!.price_level {
                            case 0:
                                priceVal = .LOW
                            case 1:
                                priceVal = .MEDIUM
                            case 2:
                                priceVal = .HIGH
                            default:
                                priceVal = .HIGH
                        }
                        temp.append(
                            LocationInfo(name: locationStruct!.name, address: locationStruct!.address, distancing: locationStruct!.agg_social, density: locationStruct!.agg_density, maskWearing: locationStruct!.agg_mask, image: #imageLiteral(resourceName: "q6_100"), priceRange: priceVal, tags: locationStruct!.types, distance: (locationStruct!.distance * 1000).rounded()/1000)
                        );
                    }
                    self.recommendations = temp;
                    completion(true)
                    return
                }
            } catch let error as NSError {
               print(error.localizedDescription)
               completion(false)
            }
        }
        task.resume()
    }
    
    func convertLocationInfoToMarker(location : LocationInfo) -> GMSMarker {
        var marker: GMSMarker;
        marker =  GMSMarker();
        marker.title = location.name
        marker.snippet = location.address
        return marker;
    }
    
    func filterRecommendations() {
        if(filters["Least Crowded"]! || filters["Nearest Me"]!) {
            filterResuls = recommendations?.filter({ (location) -> Bool in
                print(location.distance < 100)
                if(filters["Least Crowded"]! && filters["Nearest Me"]!) {
                    return location.density < 30 && location.distance < 100.0;
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

//MARK:- DropDownCell Delegate functions

extension SearchViewController : ToggleDelegate {
    func toggleWasSwitched(_ item: String, toggleval: Bool) {
        self.filters[item] = toggleval
        self.filterRecommendations()
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var locationInfo : LocationInfo
        if (searchActive) {
            locationInfo = self.searchResuls![indexPath.row]
        } else if (filterActive) {
            locationInfo = self.filterResuls![indexPath.row]
        } else {
            locationInfo = self.recommendations![indexPath.row]
        }
        let sb = UIStoryboard(name:"Main",bundle: Bundle.main)
        let locViewController = sb.instantiateViewController(withIdentifier: "LocationPage") as! LocationViewController
        let marker = convertLocationInfoToMarker(location: locationInfo);
        locViewController.locMarker = marker
        present(locViewController, animated: true)
    }
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
        cell.distanceLabel.text = String(locationInfo.distance) + "mi"
        
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
