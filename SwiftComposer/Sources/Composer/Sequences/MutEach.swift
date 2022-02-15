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

public func mutEach<S: MutableCollection, A>(_ f: @escaping (A) -> A)
-> (inout S) -> Void where S.Element == A, S.Index == Int {
    return { coll in
        for (index, element) in coll.enumerated() {
            coll[index] = f(element)
        }
    }
}

public func mutEach<S: Sequence, A: AnyObject>(_ f: @escaping (A) -> Void)
-> (S) -> Void where S.Element == A {
    return { $0.forEach(f) }
}

public func mutEach<S: Sequence, A: AnyObject>(_ f: @escaping (A) -> Void)
-> (S) -> S where S.Element == A {
    return { coll in
        coll.forEach(f)
        return coll
    }
}
