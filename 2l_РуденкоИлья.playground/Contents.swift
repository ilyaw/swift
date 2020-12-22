import UIKit
import Foundation

//1. Написать функцию, которая определяет, четное число или нет.
func isEven(value:Int) -> Bool {
    return value % 2 == 0
}

//2. Написать функцию, которая определяет, делится ли число без остатка на 3.
func isValueDivisible(value:Int) -> Bool {
    return value % 3 == 0
}

//3. Создать возрастающий массив из 100 чисел.
var arr = Array (1...100)

//4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.
arr = arr.filter {!isEven(value: $0) && !isValueDivisible(value: $0)}
print(arr)


//5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов.
//Числа Фибоначчи определяются соотношениями Fn=Fn-1 + Fn-2.
var arrFib: [Decimal] = [1, 1]
func addValueToFib(value: Int) -> [Decimal] {
    for i in 2...value {
        arrFib.append(arrFib[i - 1] + arrFib[i - 2])
    }
    return arrFib
}
print(addValueToFib(value: 100))


//6. * Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги:
//a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
//b. Пусть переменная p изначально равна двум — первому простому числу.
//c. Зачеркнуть в списке числа от 2 + p до n, считая шагом p..
//d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
//e. Повторять шаги c и d, пока возможно.
let n = 30
var p : Int = 2
var array = [Int] (2...n)
print(array)

while p*p < n {
    for i in 2...n {
        if let index = array.firstIndex(of: (i*p)) {
            array.remove(at: index)
        }
    }
   
    let index = array.firstIndex(of: p)
    
    if index != (array.endIndex-1) {
        p = array[index! + 1]
    } else {
        break
    }
}

print(array)

