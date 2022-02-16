//    Copyright (c) <2022> Alexandr Ovcharenko
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

import Foundation

public func zip<T1, T2>(_ t1: T1?, _ t2: T2?) -> (T1, T2)? {
    guard let t1 = t1, let t2 = t2 else { return nil }
    return (t1, t2)
}

public func zip<T1, T2, R>(with transform: @escaping (T1, T2) -> R) -> (T1?, T2?) -> R? {
    return { t1, t2 in
        zip(t1, t2).map(transform)
    }
}

public func zip<T1, T2, T3>(_ t1: T1?, _ t2: T2?, _ t3: T3?) -> (T1, T2, T3)? {
    guard let t1 = t1, let t2 = t2, let t3 = t3 else { return nil }
    return (t1, t2, t3)
}

public func zip<T1, T2, T3, R>(with transform: @escaping (T1, T2, T3) -> R) -> (T1?, T2?, T3?) -> R? {
    return { t1, t2, t3 in
        zip(t1, t2, t3).map(transform)
    }
}

public func zip<T1, T2, T3, T4>(_ t1: T1?, _ t2: T2?, _ t3: T3?, _ t4: T4?) -> (T1, T2, T3, T4)? {
    return zip(zip(t1, t2), zip(t3, t4)).map { ($0.0, $0.1, $1.0, $1.1) }
}

public func zip<T1, T2, T3, T4, R>(with transform: @escaping (T1, T2, T3, T4) -> R) -> (T1?, T2?, T3?, T4?) -> R? {
    return { t1, t2, t3, t4 in
        zip(t1, t2, t3, t4).map(transform)
    }
}

public func zip<T1, T2, T3, T4, T5>(_ t1: T1?, _ t2: T2?, _ t3: T3?, _ t4: T4?, _ t5: T5?) -> (T1, T2, T3, T4, T5)? {
    return zip(zip(t1, t2), zip(t3, t4, t5)).map { ($0.0, $0.1, $1.0, $1.1, $1.2) }
}

public func zip<T1, T2, T3, T4, T5, R>(with transform: @escaping (T1, T2, T3, T4, T5) -> R) -> (T1?, T2?, T3?, T4?, T5?) -> R? {
    return { t1, t2, t3, t4, t5 in
        zip(t1, t2, t3, t4, t5).map(transform)
    }
}
