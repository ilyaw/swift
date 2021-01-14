import UIKit

//1. Решить квадратное уравнение.
let a:Double = 2
let b:Double = 6
let c:Double = 5

if a == 0 {
    print("a не может быть = 0")
} else {
    
    let d = pow(b, 2) - 4*a*c
    
    if d < 0 {
        print("Корней нет")
    } else if d == 0 {
        let x:Double = (-b/(2*a))
        print("Дискриминант = 0, корень равен \(x)")
    } else if d > 0 {
        let x1:Double = ((-b + sqrt(d)) / (2 * a))
        let x2:Double = ((-b - sqrt(d)) / (2 * a))
        
        print("Дискриминант = \(d)\nx1 = \(x1)\nx2 = \(x2)")
    }
}

//2. Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.
let cat1: Float = 10
let cat2: Float = 5
let square = (cat1 * cat2) / 2
let hypotenuse = sqrt(pow(cat1, 2) + pow(cat2, 2))
let perimeter = cat1 + cat2 + hypotenuse

print("Площадь = \(square)\nПериметр = \(perimeter)\nГипотенуза = \(hypotenuse)")


// 3. Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.
let deposit:Double = 1000
let percent:Double = 10
var year:Int = 5

print("Сумма вклада \(deposit) под \(percent)% через \(year) лет = \(getContribution(deposit: deposit))")

func getContribution(deposit:Double) -> Double{
    if year == 0 {
        return deposit
    }
    year-=1
    return getContribution(deposit: deposit + ((deposit/100) * percent))
}
