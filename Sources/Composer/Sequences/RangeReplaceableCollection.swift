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

@discardableResult
public func append<S: RangeReplaceableCollection, T>(_ value: T) -> (inout S) -> Void
where S.Element == T {
    return { $0.append(value) }
}

@discardableResult
public func append<S: RangeReplaceableCollection>(_ sequence: S) -> (inout S) -> Void {
    return { $0.append(contentsOf: sequence) }
}

public func filter<S: RangeReplaceableCollection>(_ predicate: @escaping (S.Element) throws -> Bool) -> (S) throws -> S {
    return {
        try $0.filter(predicate)
    }
}

@discardableResult
public func insert<S: RangeReplaceableCollection>(_ newElement: S.Element, at index: S.Index) -> (inout S) -> Void {
    return { $0.insert(newElement, at: index) }
}

public func removeLast<S: RangeReplaceableCollection & BidirectionalCollection>(_ sequence: inout S) -> Void {
    _ = sequence.popLast()
}

@discardableResult
public func popLast<S: RangeReplaceableCollection & BidirectionalCollection>(_ sequence: inout S) -> S.Element? {
   sequence.popLast()
}

//@discardableResult
//public func popLast<S: RangeReplaceableCollection & BidirectionalCollection>(_ sequence: inout S) -> S.Element? where S.SubSequence == S {
//    sequence.popLast()
//}

@discardableResult
public func popFirst<S: RangeReplaceableCollection>(_ sequence: inout S) -> S.Element? where S.SubSequence == S {
    sequence.popFirst()
}

@discardableResult
public func remove<S: RangeReplaceableCollection>(at index: S.Index) -> (inout S) -> Void {
    return { _ = $0.remove(at: index) }
}
