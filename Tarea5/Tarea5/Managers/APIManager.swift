//
//  APIManager.swift
//  Tarea5
//
//  Created by admin on 4/26/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import Alamofire

class WeatherAPIManager {
    
    static let latitude = "9.83228027673567"
    static let longitude = "-83.91017021487139"
    static let appid = "308a78b4a0e54e1b8a8dbcb781f4179b"
    static let rootURL = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&appid=\(appid)&units=metric"
    
    class func getAllWeather(completionHandler: @escaping (_ error: WeatherAPIError?, _ weather: Weather?) -> Void) {
        guard let isNetworkReachable = NetworkReachabilityManager()?.isReachable else {
            completionHandler(WeatherAPIError.noInternetConnection, nil)
            return
        }
        
        if isNetworkReachable {
            makeRequestToGetAllMemesToAPI(completionHandler: completionHandler)
        } else {
            completionHandler(WeatherAPIError.noInternetConnection, nil)
        }
    }
    
    private class func makeRequestToGetAllMemesToAPI(completionHandler: @escaping (_ error: WeatherAPIError?, _ weather: Weather?) -> Void) {
        guard let request = AlamofireHelper.createRequest(parameters: nil, requestPath: WeatherAPIManager.rootURL, httpMethod: HTTPMethod.get) else {
            return completionHandler(WeatherAPIError.invalidURL, nil)
        }
        AF.request(request).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                guard let jsonAnswer = response.value as? [String: Any], let weatherData = jsonAnswer["current"] as? [String: Any] else {
                    completionHandler(WeatherAPIError.wrongAnswer, nil)
                    return
                }
                let weather = Weather(dictionary: weatherData)
                completionHandler(nil, weather)
            case .failure:
                completionHandler(WeatherAPIError.serverError, nil)
            }
        }
    }
}
