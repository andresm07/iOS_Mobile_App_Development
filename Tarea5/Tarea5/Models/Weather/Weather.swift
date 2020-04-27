//
//  Weather.swift
//  Tarea5
//
//  Created by admin on 4/26/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct WeatherKeys {
    static let dt = "dt"
    static let sunrise = "sunrise"
    static let sunset = "sunset"
    static let temp = "temp"
    static let feels_like = "feels_like"
    static let pressure = "pressure"
    static let humidity = "humidity"
    static let dew_point = "dew_point"
    static let uvi = "uvi"
    static let clouds = "clouds"
    static let visibility = "visibility"
    static let wind_speed = "wind_speed"
    static let wind_deg = "wind_deg"
}

struct Weather {
    var dt: Int
    var sunrise: Int
    var sunset: Int
    var temp: Double
    var feels_like: Double
    var pressure: Int
    var humidity: Int
    var dew_point: Double
    var uvi: Double
    var clouds: Int
    var visibility: Int
    var wind_speed: Double
    var wind_deg: Int
}

extension Weather {
    init(dictionary: [String: Any]) {
        self.dt = dictionary[WeatherKeys.dt] as? Int ?? -1
        self.sunrise = dictionary[WeatherKeys.sunrise] as? Int ?? -1
        self.sunset = dictionary[WeatherKeys.sunset] as? Int ?? -1
        self.temp = dictionary[WeatherKeys.temp] as? Double ?? -1.0
        self.feels_like = dictionary[WeatherKeys.feels_like] as? Double ?? -1.0
        self.pressure = dictionary[WeatherKeys.pressure] as? Int ?? -1
        self.humidity = dictionary[WeatherKeys.humidity] as? Int ?? -1
        self.dew_point = dictionary[WeatherKeys.dew_point] as? Double ?? -1.0
        self.uvi = dictionary[WeatherKeys.uvi] as? Double ?? -1.0
        self.clouds = dictionary[WeatherKeys.clouds] as? Int ?? -1
        self.visibility = dictionary[WeatherKeys.visibility] as? Int ?? -1
        self.wind_speed = dictionary[WeatherKeys.wind_speed] as? Double ?? -1.0
        self.wind_deg = dictionary[WeatherKeys.wind_deg] as? Int ?? -1
    }
}



