import UIKit

enum AccountError: Error {
    case wrongLoginOrPassword       //неверный логин или пароль
    case numberOfAttemptsExceeded   //превышено количество попыток входа
    case noAccess                   //нет доступа
    case invalidPasswordFormat      //неверный формат пароля
    case invalidLoginFormat         //неверный формат логина
    case notAuthorized              //не авторизован
}

enum Roles {
    case admin      //админ
    case simpleUser //обычный пользователь
}

class User {
    var login: String
    var password: String
    var role: Roles?
    
    init(_ login: String, _ password: String) {
        self.login = login
        self.password = password
    }
    
    init(_ login: String, _ password: String, _ role: Roles) {
        self.login = login
        self.password = password
        self.role = role
    }
}

//база
var users = [
    User.init("Ilya", "qweqwe", .admin),
    User.init("Michael", "987654321", .admin),
    User.init("Sasha", "2020", .admin),
    User.init("Daniel", "abc123", .simpleUser),
    User.init("Pavel", "123456", .simpleUser)
]


class Account {
    private var numberOfAttempts = 0  //количество попыток входа
    private let loginAttempts = 2     //максимальное количество попыток входа
    private var currentUser: User?    //текущий юзер
    
    private func findUser(_ login: String) -> User? {
        for user in users {
            if user.login == login {
                return user
            }
        }
        return nil
    }
    
    //авторизация
    func login(_ userModel: User) throws -> Bool {
        if numberOfAttempts == loginAttempts {
            throw AccountError.numberOfAttemptsExceeded
        }
    
        if let user = findUser(userModel.login) {
            if user.password == userModel.password {
                currentUser = user
                return true
            }
        }
        
        numberOfAttempts += 1
        throw AccountError.wrongLoginOrPassword
    }
    
    //регистрация
    func register(_ user: User) throws -> Bool {
        if user.login.isEmpty {
            throw AccountError.invalidLoginFormat
        }
        
        if user.password.isEmpty {
            throw AccountError.invalidPasswordFormat
        }
        
        let user = User.init(user.login, user.password, .simpleUser)
        users.append(user)
        currentUser = user
        
        return true
    }
    
    //изменить роль у пользователя. Доступно только админам
    func changeRole(_ login: String, _ role: Roles) throws -> Bool {
        if currentUser == nil {
            throw AccountError.notAuthorized
        }
        
        if currentUser?.role == Roles.simpleUser {
            throw AccountError.noAccess
        }
        
        if let user = findUser(login) {
            user.role = role
            return true
        }
        
        return false
    }
    
    //выйти с аккаунта
    func logout() throws {
        if currentUser == nil {
            throw AccountError.notAuthorized
        }
        
        currentUser = nil
    }
}

var acc1 = Account()
do {
    try acc1.register(User.init("", "123123"));
} catch AccountError.invalidLoginFormat {
    print("Введите логин!")
} catch AccountError.invalidPasswordFormat {
    print("Введите пароль!")
}

if try acc1.register(User.init("Vanya", "123123")) {
    print("Зарегистрировались!")
}

var ilya = Account()
do {
    try ilya.login(User.init("Ilya", "00000"))
} catch AccountError.wrongLoginOrPassword {
    print("Неверный логин или пароль!")
}

if try ilya.login(User.init("Ilya", "qweqwe")) {
    print("Авторизовались!")
}

try ilya.changeRole("Ilya", .simpleUser)
do {
try ilya.changeRole("Ilya", .admin)
} catch AccountError.noAccess {
    print("Нет доступа")
}


var pavel = Account()

try? pavel.login(User.init("Pavel", "123123"))
try? pavel.login(User.init("Pavel", "111111"))

do {
    try pavel.login(User.init("Pavel", "qqqqqqq"))
} catch AccountError.numberOfAttemptsExceeded {
    print("Превышено количество попыток входа")
}
