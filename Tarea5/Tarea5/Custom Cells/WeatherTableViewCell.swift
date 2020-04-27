//
//  WeatherTableViewCell.swift
//  Tarea5
//
//  Created by admin on 4/26/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Kingfisher

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dtLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var feels_likeLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var dew_pointLabel: UILabel!
    @IBOutlet weak var uviLabel: UILabel!
    @IBOutlet weak var cloudsLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var wind_speedLabel: UILabel!
    @IBOutlet weak var wind_degLabel: UILabel!
    @IBOutlet weak var countryFlagImageView: UIImageView!
    
    var countryFlagCode: String = "CR"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func setupCell(weather: Weather) {
        if let imageUrl = URL(string: "https://www.countryflags.io/\(self.countryFlagCode)/shiny/64.png") {
            self.countryFlagImageView.kf.indicatorType = .activity
            let processor = DownsamplingImageProcessor(size: self.countryFlagImageView.frame.size)
            let placeHolderImage = R.image.default()
            self.countryFlagImageView.kf.setImage(with: imageUrl, placeholder: placeHolderImage, options: [.processor(processor), .scaleFactor(UIScreen.main.scale), .transition(.fade(1)), .cacheOriginalImage])
        }
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.none
        dateFormatter.timeZone = .current
        var date = Date(timeIntervalSince1970: TimeInterval(weather.dt))
        var localDate = dateFormatter.string(from: date)
        self.dtLabel.text = "Local Time: \(localDate)"
        date = Date(timeIntervalSince1970: TimeInterval(weather.sunrise))
        localDate = dateFormatter.string(from: date)
        self.sunriseLabel.text = "Sunrise Time: \(localDate)"
        date = Date(timeIntervalSinceReferenceDate: TimeInterval(weather.sunset))
        localDate = dateFormatter.string(from: date)
        self.sunsetLabel.text = "Sunset Time: \(localDate)"
        self.tempLabel.text = "Temperature: \(weather.temp) °C"
        self.feels_likeLabel.text = "Feels Like: \(weather.feels_like) °C"
        self.pressureLabel.text = "Atmospheric Pressure: \(weather.pressure) hPa"
        self.humidityLabel.text = "Humidity: \(weather.humidity)%"
        self.dew_pointLabel.text = "Dew Point: \(weather.dew_point) °C"
        self.uviLabel.text = "UV Index: \(weather.uvi)"
        self.cloudsLabel.text = "Cloudiness: \(weather.clouds)%"
        self.visibilityLabel.text = "Average Visibility: \(weather.visibility) m"
        self.wind_speedLabel.text = "Wind Speed: \(weather.wind_speed) m/s"
        self.wind_degLabel.text = "Wind Direction: \(weather.wind_deg)°"
    }
    
}
