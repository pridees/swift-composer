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

let p1 = Just(true)
let p2 = Just(false)
let p3 = Just(true)

(p1 <> p2) |>
    { $0.sink(receiveValue: { print($0) }) }
