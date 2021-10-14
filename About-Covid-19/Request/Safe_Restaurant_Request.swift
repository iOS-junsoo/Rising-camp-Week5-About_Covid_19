//
//  Request.swift
//  About-Covid-19
//
//  Created by 준수김 on 2021/10/14.
//

import Foundation

protocol RestaurantModelProtocol {
    func RestaurantsRetrieved(row : [Row])
}

class RestaurantModel {
    
    var delegate:RestaurantModelProtocol?
    
    func getRestaurants() {
        
        var urlString = ""
        
        switch global.dropdownSelected {
        case "경기도":
            urlString = "http://211.237.50.150:7080/openapi/57c98321a0a1a87daac8477bfa1863558b3c7163cd54c0cd3b9e58e9058dc6d0/json/Grid_20200713000000000605_1/1/100?RELAX_SI_NM=%EA%B2%BD%EA%B8%B0%EB%8F%84"
        case "강원도":
            urlString = "http://211.237.50.150:7080/openapi/57c98321a0a1a87daac8477bfa1863558b3c7163cd54c0cd3b9e58e9058dc6d0/json/Grid_20200713000000000605_1/1/100?RELAX_SI_NM=%EA%B0%95%EC%9B%90%EB%8F%84"
        case "전라북도":
            urlString = "http://211.237.50.150:7080/openapi/57c98321a0a1a87daac8477bfa1863558b3c7163cd54c0cd3b9e58e9058dc6d0/json/Grid_20200713000000000605_1/1/100?RELAX_SI_NM=%EC%A0%84%EB%9D%BC%EB%B6%81%EB%8F%84"
        case "전라남도":
            urlString = "http://211.237.50.150:7080/openapi/57c98321a0a1a87daac8477bfa1863558b3c7163cd54c0cd3b9e58e9058dc6d0/json/Grid_20200713000000000605_1/1/100?RELAX_SI_NM=%EC%A0%84%EB%9D%BC%EB%82%A8%EB%8F%84"
        case "충청북도":
            urlString = "http://211.237.50.150:7080/openapi/57c98321a0a1a87daac8477bfa1863558b3c7163cd54c0cd3b9e58e9058dc6d0/json/Grid_20200713000000000605_1/1/100?RELAX_SI_NM=%EC%B6%A9%EC%B2%AD%EB%B6%81%EB%8F%84"
        case "경상북도":
            urlString = "http://211.237.50.150:7080/openapi/57c98321a0a1a87daac8477bfa1863558b3c7163cd54c0cd3b9e58e9058dc6d0/json/Grid_20200713000000000605_1/1/100?RELAX_SI_NM=%EA%B2%BD%EC%83%81%EB%B6%81%EB%8F%84"
        case "경상남도":
            urlString = "http://211.237.50.150:7080/openapi/57c98321a0a1a87daac8477bfa1863558b3c7163cd54c0cd3b9e58e9058dc6d0/json/Grid_20200713000000000605_1/1/100?RELAX_SI_NM=%EA%B2%BD%EC%83%81%EB%82%A8%EB%8F%84"
        case "충청남도":
            urlString = "http://211.237.50.150:7080/openapi/57c98321a0a1a87daac8477bfa1863558b3c7163cd54c0cd3b9e58e9058dc6d0/json/Grid_20200713000000000605_1/1/100?RELAX_SI_NM=%EC%B6%A9%EC%B2%AD%EB%82%A8%EB%8F%84"
        default:
            print("error")
        }
        
        let url = URL(string: urlString)
        
        guard url != nil else {
            print("Couldn't create url object")
            return
        }
        
        let session = URLSession.shared
        
        let datatask = session.dataTask(with: url!) { (data, response, error) in
        
        if error == nil && data != nil {
            let decoder = JSONDecoder()
            do {
                let restaurantService = try decoder.decode(ResponseService.self, from: data!)
                
                DispatchQueue.main.async {
                    self.delegate?.RestaurantsRetrieved(row: restaurantService.Grid_20200713000000000605_1.row)
                }
            }
            catch {
                print("Error parsing the json")
            }
       }
        }
        datatask.resume()
    }

}
