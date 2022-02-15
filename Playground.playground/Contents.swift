import UIKit
import Composer

var ints = [1, 2, 3, 4, 5, 6, 7]

let num: Int8 = -128

do {
    try dec(throwOverlow: num)
} catch {
    print(error.localizedDescription)
}

