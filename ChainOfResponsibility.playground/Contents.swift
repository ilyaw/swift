import UIKit

struct Person {
    let name: String
    let age: Int
    let isDeveloper: Bool
}

protocol ParseHandler {
    var next: ParseHandler? { get set}
    func parseHandler(from file: String) -> [Person]?
}

func data(from file: String) -> Data {
    let path1 = Bundle.main.path(forResource: file, ofType: "json")!
    let url = URL(fileURLWithPath: path1)
    let data = try! Data(contentsOf: url)
    
    return data
}

func getArray(from array: [Any]) -> [Person]?  {
    var arr: [Person] = []
    
    for userJson in array {
        guard let userJson = userJson as? [String: Any],
              let name = userJson["name"] as? String,
              let age = userJson["age"] as? Int,
              let isDeveloper = userJson["isDeveloper"] as? Bool else { return nil }
        
        arr.append(Person(name: name, age: age, isDeveloper: isDeveloper))
    }
    
    return arr
}

class FirstTryParseJSON: ParseHandler {
    var next: ParseHandler?
    
    func parseHandler(from file: String) -> [Person]? {
        let data = data(from: file)
        
        let json = try? JSONSerialization.jsonObject(with: data,
                                                     options: JSONSerialization.ReadingOptions.mutableContainers)
        
        guard let result = json as? [String: Any],
              let array = result["data"] as? [Any],
              let persons = getArray(from: array) else {
            return next?.parseHandler(from: file)
        }
        
        return persons
    }
}

class SecondTryParseJSON: ParseHandler {
    var next: ParseHandler?
    
    func parseHandler(from file: String) -> [Person]? {
        let data = data(from: file)
        
        let json = try? JSONSerialization.jsonObject(with: data,
                                                     options: JSONSerialization.ReadingOptions.mutableContainers)
        
        guard let result = json as? [String: Any],
              let array = result["result"] as? [Any],
              let persons = getArray(from: array) else {
            return next?.parseHandler(from: file)
        }
        
        return persons
    }
}

class ThirdTryParseJSON: ParseHandler {
    var next: ParseHandler?
    
    func parseHandler(from file: String) -> [Person]? {
        let data = data(from: file)
        
        let json = try? JSONSerialization.jsonObject(with: data,
                                                     options: JSONSerialization.ReadingOptions.mutableContainers)
        
        guard let array = json as? [Any],
              let persons = getArray(from: array) else {
            return next?.parseHandler(from: file)
        }
        
        return persons
    }
}

let firstTry = FirstTryParseJSON()
let secondTry = SecondTryParseJSON()
let thirdTry = ThirdTryParseJSON()

firstTry.next = secondTry
secondTry.next = thirdTry

if let persons = firstTry.parseHandler(from: "3") {
    persons.forEach {
        print("Name: \($0.name) | Age: \($0.age) | Develop \($0.isDeveloper ? "Yes" : "No")")
    }
}
