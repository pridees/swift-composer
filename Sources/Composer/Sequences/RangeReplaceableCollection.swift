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
public func mutConcat<S: RangeReplaceableCollection>(_ sequence: S) -> (inout S) -> Void {
    return { $0 += sequence }
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

@discardableResult
public func popLast<S: RangeReplaceableCollection & BidirectionalCollection>(_ sequence: inout S) -> S.Element? {
   sequence.popLast()
}

@discardableResult
public func popFirst<S: RangeReplaceableCollection>(_ sequence: inout S) -> S.Element? where S.SubSequence == S {
    sequence.popFirst()
}

@discardableResult
public func remove<S: RangeReplaceableCollection>(at index: S.Index) -> (inout S) -> S.Element {
    return { $0.remove(at: index) }
}

public func remove<S: RangeReplaceableCollection & MutableCollection>(atOffsets: IndexSet) -> (inout S) -> Void {
    return { $0.remove(atOffsets: atOffsets) }
}

public func removeAll<S: RangeReplaceableCollection>(keepingCapacity: Bool) -> (inout S) -> Void {
    return { $0.removeAll(keepingCapacity: keepingCapacity) }
}

public func removeAll<S: RangeReplaceableCollection>(where predicate: @escaping (S.Element) -> Bool)
-> (inout S) -> Void {
    return { $0.removeAll(where: predicate) }
}

@discardableResult
func removeFirst<S: RangeReplaceableCollection>() -> (inout S) -> S.Element {
    return { $0.removeFirst() }
}

func removeFirst<S: RangeReplaceableCollection>(count: Int) -> (inout S) -> Void {
    return { $0.removeFirst(count) }
}

public func removeLast<S: RangeReplaceableCollection & BidirectionalCollection>(_ sequence: inout S) -> Void {
    _ = sequence.popLast()
}

@discardableResult
func removeLast<S>() -> (inout S) -> S.Element
where S: RangeReplaceableCollection & BidirectionalCollection {
    return { $0.removeLast() }
}

@discardableResult
public func removeLast<S>()
-> (inout S) -> S.Element where S: RangeReplaceableCollection & BidirectionalCollection, S.SubSequence == S {
    return { $0.removeLast() }
}

public func removeLast<S>(count: Int) -> (inout S) -> Void
where S: RangeReplaceableCollection & BidirectionalCollection {
    return { $0.removeLast(count) }
}

@discardableResult
public func removeLast<S>(count: Int) -> (inout S) -> Void
where S: RangeReplaceableCollection & BidirectionalCollection, S.SubSequence == S {
    return { $0.removeLast(count) }
}

public func removeSubrange<S>(_ bounds: Range<S.Index>) -> (inout S) -> Void
where S: RangeReplaceableCollection {
    return { $0.removeSubrange(bounds) }
}

public func replaceSubrange<S, C>(_ subrange: Range<S.Index>, with newElements: C) -> (inout S) -> Void
where S: RangeReplaceableCollection, C: Collection, S.Element == C.Element {
    return { $0.replaceSubrange(subrange, with: newElements) }
}

