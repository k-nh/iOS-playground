//
//  ViewController.swift
//  Weather
//
//  Created by 김나희 on 2021/10/02.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescritionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var weatherStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapWeatherButton(_ sender: Any) {
        if let cityName = self.cityNameTextField.text{
            self.getCurrentWeather(cityName: cityName)
            // 키보드 사라지게
            self.view.endEditing(true)
        }
    }
    
    func configureView(weatherInformation: WeatherInformation){
        self.cityNameLabel.text = weatherInformation.name
        if let weather = weatherInformation.weather.first {
            self.weatherDescritionLabel.text = weather.description
            // 섭씨 온도로 표현
            self.tempLabel.text = "\(Int(weatherInformation.temp.temp - 273.15))°C"
            self.minTempLabel.text = "최저 : \(Int(weatherInformation.temp.minTemp - 273.15))°C"
            self.maxTempLabel.text = "최저 : \(Int(weatherInformation.temp.maxTemp - 273.15))°C"
        }
    }
    
    func getCurrentWeather(cityName:String){
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=72bc5ab091015269f74f5b9b18526805") else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url){ data, response, error in
            let successRange = (200..<300)
            guard let data = data, error == nil else { return }
            // json형태를 weatherinformation 형태로 가져오기
            let decorder = JSONDecoder()
            // 응답이 200번대 인지 확인
            if let response = response as? HTTPURLResponse,successRange.contains(response.statusCode) {
                guard let weatherInfo = try? decorder.decode(WeatherInformation.self, from: data) else { return }
                DispatchQueue.main.async {
                    // 날씨 정보 보여주게하기
                    self.weatherStackView.isHidden = false
                    self.configureView(weatherInformation: weatherInfo)
                }
            } else {
                guard let errorMessage = try? decorder.decode(ErrorMessage.self, from: data) else { return }
                DispatchQueue.main.async {
                    self.showAlert(message: errorMessage.message)
                }
            }
        }.resume()
    }
    
    func showAlert(message:String){
        let alert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

