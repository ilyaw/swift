import UIKit

enum Action {
    enum Engine:String {
        case Run = "Двигатель запущен"
        case Stop = "Двигатель заглушен"
    }
    
    enum Window:String {
        case Open = "Окно открыто"
        case Close = "Окно закрыто"
    }
    
    enum Baggage {
        case Put(count: Int)
        case Unload(count: Int)
    }
}

struct TrunkCar {
    var carModel: String
    var yearOfIssue, baggageSize: Int
    private var engineRun, windowOpen, baggageFull: Bool
    private var currentSizeBaggage: Int
    
    init(carModel: String, yearOfIssue: Int, baggageSize: Int) {
        self.carModel = carModel
        self.yearOfIssue = yearOfIssue
        self.baggageSize = baggageSize
        self.currentSizeBaggage = 0
        self.engineRun = false
        self.windowOpen = false
        self.baggageFull = false
    }
      
    mutating func action(_ action: Action.Engine) -> String {
        let str = isRunEngine() && action == Action.Engine.Run ? "Двигатель уже запущен!" : action.rawValue
        engineRun = action == Action.Engine.Run ? true : false
        return str
    }
    
    mutating func action(_ action: Action.Window) -> String {
        let str = isOpenWindow() && action == Action.Window.Open ? "Окно уже откыто!" : action.rawValue
        windowOpen = action == Action.Window.Open ? true : false
        return str
    }
    
    func description() -> Void {
        print("===\nМарка машины: \(carModel)\n" +
                "Год выпуска: \(yearOfIssue)\n" +
                "Вместимость багажника: \(baggageSize)\n" +
                "Окно: \(isOpenWindow() ? "Окрыто" : "Закрыто")\n" +
                "Двигатель: \(isRunEngine() ? "Запущен" : "Заглушен")\n" +
                "Багажник заполнен: \(currentSizeBaggage)/\(baggageSize)\n===")
    }
    
    mutating func action(_ action: Action.Baggage) -> Void {
        switch action {
        case .Put( _) where checkFullBaggage():
                print("Багажник уже заполнен!")
        case .Put(count: let count) where count + currentSizeBaggage > baggageSize:
            print("Слишко много вещей!")
        case .Put(count: let count):
            currentSizeBaggage += count
            print("Положили в багажник \(count)")
        case .Unload(count: _) where currentSizeBaggage == 0:
            print("Вещей в багажнике нет")
        case .Unload(count: let count) where count > currentSizeBaggage:
            print("В багажнике столько вещей нет")
        case .Unload(count: let count):
            currentSizeBaggage -= count
            print("Взяли из багажника \(count)")
        }
        
        print("Багажник заполнен \(currentSizeBaggage)/\(baggageSize)")
    }
    
    func isOpenWindow() -> Bool {
        return windowOpen
    }
    
    func isRunEngine() -> Bool {
        return engineRun
    }
    
    mutating func checkFullBaggage() -> Bool {
        return currentSizeBaggage == baggageSize
    }
}


struct SportCar {
    var carModel: String
    var yearOfIssue, baggageSize: Int
    private var engineRun, windowOpen, baggageFull: Bool
    private var currentSizeBaggage: Int
    
    init(carModel: String, yearOfIssue: Int, baggageSize: Int) {
        self.carModel = carModel
        self.yearOfIssue = yearOfIssue
        self.baggageSize = baggageSize
        self.currentSizeBaggage = 0
        self.engineRun = false
        self.windowOpen = false
        self.baggageFull = false
    }
      
    mutating func action(_ action: Action.Engine) -> String {
        let str = isRunEngine() && action == Action.Engine.Run ? "Двигатель уже запущен!" : action.rawValue
        engineRun = action == Action.Engine.Run ? true : false
        return str
    }
    
    mutating func action(_ action: Action.Window) -> String {
        let str = isOpenWindow() && action == Action.Window.Open ? "Окно уже откыто!" : action.rawValue
        windowOpen = action == Action.Window.Open ? true : false
        return str
    }
    
    func description() -> Void {
        print("===\nМарка машины: \(carModel)\n" +
                "Год выпуска: \(yearOfIssue)\n" +
                "Вместимость багажника: \(baggageSize)\n" +
                "Окно: \(isOpenWindow() ? "Окрыто" : "Закрыто")\n" +
                "Двигатель: \(isRunEngine() ? "Запущен" : "Заглушен")\n" +
                "Багажник заполнен: \(currentSizeBaggage)/\(baggageSize)\n===")
    }
    
    mutating func action(_ action: Action.Baggage) -> Void {
        switch action {
        case .Put( _) where checkFullBaggage():
                print("Багажник уже заполнен!")
        case .Put(count: let count) where count + currentSizeBaggage > baggageSize:
            print("Слишко много вещей!")
        case .Put(count: let count):
            currentSizeBaggage += count
            print("Положили в багажник \(count)")
        case .Unload(count: _) where currentSizeBaggage == 0:
            print("Вещей в багажнике нет")
        case .Unload(count: let count) where count > currentSizeBaggage:
            print("В багажнике столько вещей нет")
        case .Unload(count: let count):
            currentSizeBaggage -= count
            print("Взяли из багажника \(count)")
        }
        
        print("Багажник заполнен \(currentSizeBaggage)/\(baggageSize)")
    }
    
    func isOpenWindow() -> Bool {
        return windowOpen
    }
    
    func isRunEngine() -> Bool {
        return engineRun
    }
    
    mutating func checkFullBaggage() -> Bool {
        return currentSizeBaggage == baggageSize
    }
}


let engine = Action.Engine.self
let window = Action.Window.self
let baggage = Action.Baggage.self


var lambo = SportCar(carModel: "Lamborghini", yearOfIssue: 2014, baggageSize: 10)
lambo.action(engine.Run)
lambo.action(engine.Run)
lambo.action(window.Open)
lambo.action(window.Open)
lambo.action(window.Close)
lambo.action(baggage.Put(count: 10))
lambo.action(baggage.Unload(count: 3))
lambo.action(baggage.Unload(count: 8))
lambo.description()
lambo.action(engine.Stop)

print("\n")

var volvo = TrunkCar(carModel: "Volvo", yearOfIssue: 2019, baggageSize: 10000)
print(volvo.action(window.Open))
volvo.action(baggage.Put(count: 99999999))
volvo.action(baggage.Put(count: 3405))
volvo.description()
