import UIKit

struct Queue<T> {
    private var _array = [T]()
    
    subscript(index: Int) -> T? {
        get {
            if index >= _array.count {
                return nil
            } else {
                return _array[index]
            }
            
        } set(newValue) {
            _array[index] = newValue!
        }
    }
    
    mutating func add(_ element: T) {
        _array.append(element)
    }
    
    
    mutating func filter(_ predicate: (T) -> Bool) -> [T] {
        var result = [T]()
        for i in _array {
            if predicate(i) {
                result.append(i)
            }
        }
        
        return result
    }
    
    
    mutating func count(_ fn: (T) -> Bool) -> Int {
        var result = [T]()
        for i in _array {
            if fn(i) {
                result.append(i)
            }
        }
        return result.count
    }
    
    mutating func aggregate(_ fn: (T, T) -> T) -> T? {
        if _array.count == 0 {
            return nil
        } else if _array.count == 1 {
            return _array.first
        }
        
        var res = _array[0]
        for i in _array.dropFirst() {
            res = fn(res, i)
        }
        return res
    }
}

var queue = Queue<Int>()

for i in 1...100 {
    queue.add(i)
}

print(queue[10000] ?? "за пределами границ массива")


var filterArray = queue.filter() {$0 % 2 == 0}

print(filterArray)

var count = queue.count({(x: Int) -> Bool in
    return x > 10 && x < 20
})

print("Количество элементов > 10 и < 20 = \(count)")

var sum = queue.aggregate() {$0 + $1}

print("Подсчет всех чисел = \(sum!)")
