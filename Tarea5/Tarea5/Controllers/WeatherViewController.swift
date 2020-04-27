//
//  WeatherViewController.swift
//  Tarea5
//
//  Created by admin on 4/26/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class WeatherViewController: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet weak var weatherTableView: UITableView!
    
    var weather = Weather(dt: 0, sunrise: 0, sunset: 0, temp: 0.0, feels_like: 0.0, pressure: 0, humidity: 0, dew_point: 0.0, uvi: 0.0, clouds: 0, visibility: 0, wind_speed: 0.0, wind_deg: 0) {
        didSet {
            self.weatherTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.weatherTableView.delegate = self
        self.weatherTableView.dataSource = self
        
        registerCustomCells()
        startAnimating()
        getWeatherInfo()
    }
    
    private func registerCustomCells() {
        self.weatherTableView.register(UINib(resource: R.nib.weatherTableViewCell), forCellReuseIdentifier: R.nib.weatherTableViewCell.name)
    }
    
    private func getWeatherInfo() {
        WeatherAPIManager.getAllWeather { (error, weather) in
            self.stopAnimating()
            if let error = error {
                self.handleError(error: error)
            }
            if let weather = weather {
                self.weather = weather
            }
        }
    }
    
    private func handleError(error: WeatherAPIError) {
        var message = ""
        switch error {
        case .invalidURL, .serverError, .wrongAnswer:
            message = "Server issues, please try again later"
        case .noInternetConnection:
            message = "Please check internet connection"
        }
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }


}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.weatherTableView.dequeueReusableCell(withIdentifier: R.nib.weatherTableViewCell.name) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(weather: self.weather)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        450.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("")
    }
    
}
