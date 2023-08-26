import Foundation
import UIKit

//indirect enum List<T> {
//    case empty
//    case cons(head: T, tail: List<T>)
//}
//
//func listOf<T>(_ t: T...) -> List<T> {
//    func go(array: [T]) -> List<T> {
//        if array.isEmpty {
//            return .empty
//        } else {
//            return .cons(
//                head: array[0],
//                tail: go (array: Array (array.dropFirst ()))
//            )
//        }
//    }
//    return go(array: t)
//}
//
//extension List {
//    func head() -> T? {
//        switch self {
//            case .empty: return .none
//            case .cons(head: let h, tail: _): return .some(h)
//        }
//    }
//}
//
//extension List {
//    func drop (n: Int) -> List<T> {
//        switch self {
//            case .empty: return self
//            case .cons (head: _, tail: let t):
//                if n == 0 {
//                    return self
//                } else {
//                    return t.drop (n: n-1)
//                }
//        }
//    }
//    func dropWhile(_ f: (T) -> Bool) -> List<T> {
//        switch self {
//            case .empty: return self
//            case .cons (head: let h, tail: let t):
//                if f(h) {
//                    return t.dropWhile(f)
//                } else {
//                    return self
//                }
//        }
//    }
//
//    func append(_ n: T) -> List<T> {
//        switch self {
//            case .empty:
//                return .cons (head: n, tail: .empty)
//            case .cons(head: let h, tail: let t):
//                return .cons (head: h, tail: t.append (n))
//        }
//    }
//
//    func foldLeft<C> (_ initialValue: C, _ f: (C, T) -> C) -> C {
//        switch self {
//            case .empty:
//                return initialValue
//            case .cons(head: let h, tail: let t):
//                return t.foldLeft(f(initialValue, h), f)
//        }
//    }
//
//    func foldRight<B> (_ initialValue: B, _ f: (T, B) -> B) -> B {
//        switch self {
//            case .empty:
//                return initialValue
//            case .cons(head: let h, tail: let t):
//                return f(h, t.foldRight(initialValue, f))
//        }
//    }
//
//    func appendInTermsFoldRight(_ n: T) -> List<T> {
//        foldRight(listOf(n)) { t, c in
//            return .cons(head: t, tail: c)
//        }
//    }
//
//    func appendInTermsFoldLeft(_ n: T) -> List<T> {
//        foldLeft(listOf(n)) { c, t in
//            switch c {
//                case .empty: return .empty
//                case .cons(let head, let tail):
//                    return .cons(
//                        head: head,
//                        tail: tail.appendInTermsFoldLeft(t)
//                    )
//            }
//        }
//    }
//
//    func print() {
//        Swift.print(self.foldLeft(Array<T>.init()) { b, t in
//            return b + [t]
//        })
//    }
//}
//
//var list = List.cons(
//    head: 10,
//    tail: .cons(
//        head: 20,
//        tail: .cons(
//            head: 30,
//            tail: .empty
//        )
//    )
//)
//
//list = list.appendInTermsFoldLeft(0)
//
//list.print()

import Foundation
import os

final class Atomic<A> {
    
    private let accessQueue = DispatchQueue(label: "ru.tinkoff.accessQueue")
    private var _value: A
    
    init(_ value: A) {
        self._value = value
    }
    
    var value: A {
        self._value
    }
    
    func mutate(_ work: @escaping (A) -> A) {
        accessQueue.sync {
            self._value = work(value)
        }
    }
}

var x = Atomic(0)
DispatchQueue.concurrentPerform(iterations: 100) { _ in
    x.mutate { $0 + 1 }
}
print(x.value)
