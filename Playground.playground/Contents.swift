import Foundation
import Combine
import Composer

var arr: [Int] = [1, 2, 3, 4, 5]

let incr: (Int) -> Int = { $0 + 1 }
let sqrt: (Int) -> Int = { $0 * $0 }

let optionalValue: Int? = 2

//optionalValue |> incr <?> sqrt
//
//optionalValue |> flatMap(incr >>> sqrt)

class User {
    var name: String
    
    init(_ name: String) {
        self.name = name
    }
}

var arr2: [User] = [User("Alex"), User("Boris"), User("Michael")]
     |> mutEach { $0.name += " Ovcharenko" }
     <*> Array<User>.init
                                    
