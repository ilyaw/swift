import UIKit
import Foundation

enum Engine: String {
  case on = "Заведен"
  case off = "Заглушен"
}


//Базовый класс для разных видов транспорта
class Basic {
    var modelName: String
    var yearOfRelease: Int
    var seatingCapacity: Int
    var engine: Engine = Engine.off
    
    init (modelName: String, yearOfRelease: Int, seatingCapacity: Int) {
        self.modelName = modelName
        self.yearOfRelease = yearOfRelease
        self.seatingCapacity = seatingCapacity
    }
    
    func actionEngine(_ actionEngine:Engine) {
        engine = actionEngine
    }
}


class TrunkCar : Basic, CustomStringConvertible  {
    //тип прицепа
    enum TrailerType: String {
        case onboard = "Бортовый прицеп"
        case van = "Фургон"
        case refrigerator = "Рефрижераторный контейнер"
        case tilt  = "Тентованный прицеп"
    }
    var trailerType: TrailerType
    
    init(trailerType: TrailerType, modelName: String, yearOfRelease: Int, seatingCapacity: Int) {
        self.trailerType = trailerType
        
        super.init(modelName: modelName, yearOfRelease: yearOfRelease, seatingCapacity: seatingCapacity)
    }
    
    override func actionEngine(_ actionEngine: Engine) {
        print(actionEngine.rawValue)
        engine = actionEngine
    }
    
    var description: String {
        return "Инфромация о грузовом автомобиле:\nТип прицепа: \(self.trailerType.rawValue)\nНаименование: \(modelName)\nГод выпуска: \(yearOfRelease)\nКоличество мест: \(seatingCapacity)\nДвижок: \(engine.rawValue)";
    }
}

class SportCar : Basic, CustomStringConvertible {
    //тип двигателя
    enum SportEngineType: String {
        case turbo = "Турбированный"
        case atmospheric = "Атмосферный"
    }
    
    var sportEngineType: SportEngineType
    
    init(sportEngine: SportEngineType, modelName: String, yearOfRelease: Int, seatingCapacity: Int) {
        self.sportEngineType = sportEngine
        super.init(modelName: modelName, yearOfRelease: yearOfRelease, seatingCapacity: seatingCapacity)
    }
    
    var description: String {
        return "Инфромация о спорткаре:\nТип движка: \(self.sportEngineType.rawValue)\nНаименование: \(modelName)\nГод выпуска: \(yearOfRelease)\nКоличество мест: \(seatingCapacity)\nДвижок: \(engine.rawValue)";
    }
    
}

class Plane : Basic, CustomStringConvertible {
    enum PlaneType: String {
        case passenger = "Пассажирский лайнер"
        case cargo = "Грузовой борт"
        case training = "Учебный аэробус"
        case special = "Специального назначения"
    }
    var planeType: PlaneType
    
    init(planeType: PlaneType, modelName: String, yearOfRelease: Int, seatingCapacity: Int) {
        self.planeType = planeType
        super.init(modelName: modelName, yearOfRelease: yearOfRelease, seatingCapacity: seatingCapacity)
    }
    
    override func actionEngine(_ actionEngine: Engine) {
        print(actionEngine == Engine.on ? "Самолет готов к взлету" : "Двигатель заглушен" )
        engine = actionEngine
    }
    
    var description: String {
        return "Инфромация о самолете:\nТип: \(self.planeType.rawValue)\nНаименование: \(modelName)\nГод выпуска: \(yearOfRelease)\nКоличество мест: \(seatingCapacity)\nДвижок: \(engine.rawValue)";
    }
}

class Train : Basic, CustomStringConvertible  {
    var numberOfWagons: Int = 0
    
    init(numberOfWagons: Int, modelName: String, yearOfRelease: Int, seatingCapacity: Int) {
        self.numberOfWagons = numberOfWagons
        super.init(modelName: modelName, yearOfRelease: yearOfRelease, seatingCapacity: seatingCapacity)
    }
    
    override func actionEngine(_ actionEngine: Engine) {
        print(actionEngine == Engine.on ? "Поезд готов к отправке" : "Двигатель заглушен" )
        engine = actionEngine
    }
    
    var description: String {
        return "Инфромация о поезде:\nНаименование: \(modelName)\nГод выпуска: \(yearOfRelease)\nКоличество мест: \(seatingCapacity)\nКоличество вагонов: \(numberOfWagons)\nДвижок: \(engine.rawValue)";
    }
}


let trunk = TrunkCar(trailerType: .tilt, modelName: "Kamaz", yearOfRelease: 2000, seatingCapacity: 2)
print(trunk)

print("===")
let sportCar = SportCar(sportEngine: .atmospheric, modelName: "Aventodor", yearOfRelease: 2017, seatingCapacity: 2)
sportCar.actionEngine(.on)
print(sportCar)
print("===")
let plane = Plane(planeType: .passenger, modelName: "Ил-76", yearOfRelease: 2000, seatingCapacity: 70)
plane.actionEngine(.on)
print(plane)
print("===")
let train = Train(numberOfWagons: 10, modelName: "Сапсан", yearOfRelease: 2014, seatingCapacity: 200)
train.actionEngine(.on)
print(train)
