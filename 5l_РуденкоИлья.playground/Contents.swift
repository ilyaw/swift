import UIKit

enum Engine: String {
    case on = "Заведен"
    case off = "Заглушен"
}

enum Windows: String {
    case open = "Открыты"
    case close = "Закрыты"
}

//ускорение для спорткара
enum TurboAcceleration: String {
    case on = "Ускорение включено"
    case off = "Ускорение выключено"
}

//действие над цистерной
enum FillCistern: String {
    case full = "Цистерна заполнена"
    case empty = "Цистерна разгружена"
}

protocol Car: class {
    var brand: String {get}
    var yearOfRelease: Int {get}
    var engine: Engine {get set}
    var window: Windows {get set}
    
    func actWindow(_ window: Windows) -> Void
    func actEngine(_ engine: Engine) -> Void
}

extension Car {
    func actWindow(_ window: Windows) -> Void {
        self.window = window
    }
    
    func actEngine(_ engine: Engine) -> Void {
        self.engine = engine
    }
}

//расширение для спорткара
extension SportCar: CustomStringConvertible {
    var description: String {
        return "Спорткар: \(brand)\nГод выпуска: \(yearOfRelease)\nСостояние двигателя: \(engine.rawValue)\nСостояние окон: \(window.rawValue)\n\(turbo.rawValue)\n"
    }
    
    func actTurbo(_ turbo: TurboAcceleration) -> Void {
        self.turbo = turbo
    }
}

class SportCar: Car {
    var engine: Engine = .off
    var window: Windows = .close
    var turbo: TurboAcceleration = .off
    var brand: String
    var yearOfRelease: Int
    
    init(brand: String, yearOfRelease: Int) {
        self.brand = brand
        self.yearOfRelease = yearOfRelease
    }
}


//расширение для грузового авто
extension TrunkCar: CustomStringConvertible {
    var description: String {
        return "Грузовой авто: \(brand)\nГод выпуска: \(yearOfRelease)\nСостояние двигателя: \(engine.rawValue)\nСостояние окон: \(window.rawValue)\n\(fillCistern.rawValue)\n"
    }
    
    func actCistern(_ fillCistern: FillCistern) -> Void {
        self.fillCistern = fillCistern
    }
}

class TrunkCar: Car {
    var engine: Engine = .off
    var window: Windows = .close
    var fillCistern: FillCistern = .empty
    var brand: String
    var yearOfRelease: Int
    
    init(brand: String, yearOfRelease: Int) {
        self.brand = brand
        self.yearOfRelease = yearOfRelease
    }
}



var sportCar = SportCar(brand: "Ferrari", yearOfRelease: 2010)
sportCar.actEngine(.on)
sportCar.actWindow(.open)
sportCar.actTurbo(.on)
print(sportCar)

var trunkCar = TrunkCar(brand: "Kamaz", yearOfRelease: 2000)
trunkCar.actEngine(.on)
trunkCar.actCistern(.full)
print(trunkCar)
