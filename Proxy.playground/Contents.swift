import UIKit

struct Weather {
    let city: String
    let temperature: Double
    let date: Date
}

class User {
    static let shared = User()
    private init() { }
    var accessGranted = false
}

protocol WeatherServiceInterface {
    func getWeathers(for city: String, completion: @escaping ([Weather]) -> Void)
}

class WeatherService: WeatherServiceInterface {
    
    func getWeathers(for city: String, completion: @escaping ([Weather]) -> Void) {
        // имитируем запрос в сеть задержкой в 0.5 сек
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let weather1 = Weather(city: city, temperature: 0.0, date: Date())
            let weather2 = Weather(city: city, temperature: -1.0, date: Date(timeIntervalSinceNow: 3600))
            let weather3 = Weather(city: city, temperature: +2.0, date: Date(timeIntervalSinceNow: 2 * 3600))
            completion([weather1, weather2, weather3])
        }
    }
}

class WeatherServiceProxy: WeatherServiceInterface {
    let weatherService: WeatherService
    init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    func getWeathers(for city: String, completion: @escaping ([Weather]) -> Void) {
        guard User.shared.accessGranted else { return }
        self.weatherService.getWeathers(for: city, completion: completion)
    }
}

let weatherService = WeatherService()
let proxy = WeatherServiceProxy(weatherService: weatherService)

User.shared.accessGranted = false

proxy.getWeathers(for: "Moscow") { weathers in
    print(weathers)
}

User.shared.accessGranted = true

proxy.getWeathers(for: "Moscow") { weathers in
    print(weathers)
}
