import UIKit

protocol Coffee {
    var cost: Double { get }
}

class SimpleCoffee: Coffee {
    var cost: Double = 5.0
}

// Decorator

protocol CoffeeDecorator: Coffee {
    var baseCoffe: Coffee { get }
    init(base: Coffee)
}


class Milk: CoffeeDecorator {
    var baseCoffe: Coffee
    
    var cost: Double {
        return baseCoffe.cost + 0.9
    }
    
    required init(base: Coffee) {
        self.baseCoffe = base
    }
}

class Whip: CoffeeDecorator {
    var baseCoffe: Coffee
    
    var cost: Double {
        return baseCoffe.cost + 1.1
    }
    
    required init(base: Coffee) {
        self.baseCoffe = base
    }
    
}

class Sugar: CoffeeDecorator {
    var baseCoffe: Coffee
    
    var cost: Double {
        return baseCoffe.cost + 0.2
    }
    
    required init(base: Coffee) {
        self.baseCoffe = base
    }
}

class DoubleWhip: CoffeeDecorator {
    var baseCoffe: Coffee
    
    var cost: Double {
        return baseCoffe.cost + 2.0
    }
    
    required init(base: Coffee) {
        self.baseCoffe = base
    }
}




let simpleCoffee = SimpleCoffee()

let withMilk = Milk(base: simpleCoffee)
let withWhip = Whip(base: withMilk)
let withSugar = Sugar(base: withWhip)
let doubleWhip = DoubleWhip(base: withSugar)

print("Итого: $\(doubleWhip.cost)")
