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

// MARK: - Construct

extension Array {
    public static func sized(capacity: Int) -> Array {
        var coll = Self()
        coll.reserveCapacity(capacity)
        return coll
    }
}

@inlinable
public func listOf<A>(_ a: A...) -> [A] {
    return a
}

// MARK: - Map

public func map<S: Sequence, A>(_ f: @escaping (S.Element) -> A) -> (S) -> [A] {
    return { $0.map(f) }
}

public func tryMap<S: Sequence, A>(_ f: @escaping (S.Element) throws -> A) -> (S) throws -> [A] {
    return { try $0.map(f) }
}

// MARK: - FlatMap

public func flatMap<S: Sequence, T>(_ transform: @escaping (S.Element) throws -> [T])
-> (S) throws -> [T] {
    return { try $0.flatMap(transform) }
}

// MARK: - CompactMap

/// Calls non error-throwing closure on passed sequence's elements
public func compactMap<S: Sequence, A>(_ f: @escaping (S.Element) -> A?) -> (S) -> [A] {
    return { $0.compactMap(f) }
}

/// Calls error-throwing closure on passed sequence's elements
public func tryCompactMap<S: Sequence, A>(_ f: @escaping (S.Element) throws -> A?) -> (S) throws -> [A] {
    return { try $0.compactMap(f) }
}

// MARK: - Monoid Folding

public func reduce<S: Monoid & Sequence>(_ combine: @escaping (S, S.Element) -> S) -> (S) -> S {
    return { $0.reduce(combine) }
}

public func reduce<S: Monoid & Sequence, R: Monoid>(_ combine: @escaping (R, S.Element) -> R) -> (S) -> R {
    return { $0.reduce(combine) }
}

// MARK: - Classic Folding

public func reduce<S, R, T>(into initialValue: R, _ f: @escaping (inout R, T) -> Void)
-> (S) -> R where S: Sequence, S.Element == T {
    return { $0.reduce(into: initialValue, f) }
}

public func reduce<S, R, T>(into initialValue: R, _ f: @escaping (inout R, T) throws -> Void)
-> (S) throws -> R where S: Sequence, S.Element == T {
    return { try $0.reduce(into: initialValue, f) }
}

public func reduce<S, R, T>(_ initialValue: R, _ f: @escaping (R, T) -> R)
-> (S) -> R where S: Sequence, S.Element == T {
    return { $0.reduce(initialValue, f) }
}

public func reduce<S, R, T>(_ initialValue: R, _ f: @escaping (R, T) throws -> R)
-> (S) throws -> R where S: Sequence, S.Element == T {
    return { try $0.reduce(initialValue, f) }
}

// MARK: - Get element

@inlinable
public func first<C: Collection>(_ coll: C) -> C.Element? {
    return coll.first
}

@inlinable
public func last<C>(_ coll: C) -> C.Element?
where C: Collection & BidirectionalCollection {
    return coll.last
}

public func firstWhere<C>(_ value: C.Element) -> (C) -> C.Element?
where C: Collection, C.Element: Equatable {
    return { $0.first(where: equals(value)) }
}

public func lastWhere<C>(_ value: C.Element) -> (C) -> C.Element?
where C: Collection & BidirectionalCollection, C.Element: Equatable {
    return { $0.last(where: equals(value)) }
}

// MARK: - Get subcollection

public func prefix<C: Collection>(_ count: Int) -> (C) -> C.SubSequence {
    return { $0.prefix(count) }
}

public func prefix<C: Collection>(while predicate: @escaping (C.Element) -> Bool) -> (C) -> C.SubSequence {
    return { $0.prefix(while: predicate) }
}

public func suffix<C: Collection>(_ count: Int) -> (C) -> C.SubSequence {
    return { $0.suffix(count) }
}

// MARK: - Contain


public func contains<S>(_ value: S.Element) -> (S) -> Bool
where S: Sequence, S.Element: Equatable {
    return { $0.contains(where: equals(value)) }
}

public func containsWhere<S>(_ predicate: @escaping (S.Element) -> Bool) -> (S) -> Bool
where S: Sequence, S.Element: Equatable {
    return { $0.contains(where: predicate) }
}

public func containsBy<S, R, T>(_ keyPath: KeyPath<R, T>, _ value: T) -> (S) -> Bool
where S: Sequence, S.Element == R, T: Equatable {
    return { $0.contains(where: get(keyPath) >>> equals(value)) }
}


// MARK: - Drops

@inlinable
public func dropFirst<C: Collection>(_ coll: C) -> C.SubSequence {
    coll.dropFirst()
}

public func dropFirst<C: Collection>(_ count: Int) -> (C) -> C.SubSequence {
    return { $0.dropFirst(count) }
}

public func dropLast<C: Collection>(_ coll: C) -> C.SubSequence {
    return coll.dropLast()
}

public func dropLast<C: Collection>(_ count: Int) -> (C) -> C.SubSequence {
    return { $0.dropLast(count) }
}

// MARK: - Mutable sorts

public func sort<S>(_ comparator: @escaping (S.Element, S.Element) -> Bool) -> (inout S) -> Void
where S: MutableCollection & RandomAccessCollection, S.Element: Comparable {
    return { collection in collection.sort(by: comparator)}
}

public func sort<S>(_ sequence: inout S) -> Void
where S: MutableCollection & RandomAccessCollection, S.Element: Comparable {
    return sequence.sort(by: <)
}

public func sortBy<S, R, V>(
    _ keyPath: KeyPath<R, V>,
    _ comparator: @escaping (V, V) -> Bool
) -> (inout S) -> Void
where S: MutableCollection & RandomAccessCollection, S.Element == R, V: Comparable {
    return { $0.sort(by: combineBy(keyPath, comparator)) }
}

// MARK: - Immutable sorts

public func sorted<S>(_ comparator: @escaping (S.Element, S.Element) -> Bool) -> (S) -> [S.Element]
where S: Collection, S.Element: Comparable {
    return { $0.sorted(by: comparator) }
}

public func sorted<S>(_ collection: S) -> [S.Element]
where S: Collection, S.Element: Comparable {
    return collection.sorted(by: <)
}

public func sortedBy<S, R, V>(
    _ keyPath: KeyPath<R, V>,
    _ comparator: @escaping (V, V) -> Bool
) -> (S) -> [S.Element]
where S: Collection, S.Element == R, V: Comparable {
    return { $0.sorted(by: combineBy(keyPath, comparator)) }
}

// MARK: - Change elements over mutable collection

public func mutEach<S>(_ f: @escaping (S.Element) -> S.Element) -> (inout S) -> Void
where S: MutableCollection, S.Index == Int {
    return { coll in
        for (index, element) in coll.enumerated() {
            coll[index] = f(element)
        }
    }
}

public func mutEach<S>(_ f: @escaping (S.Element) -> Void) -> (S) -> Void
where S: Sequence, S.Element: AnyObject {
    return { $0.forEach(f) }
}

public func mutEach<S>(_ f: @escaping (S.Element) -> Void) -> (S) -> S
where S: Sequence, S.Element: AnyObject {
    return { coll in
        coll.forEach(f)
        return coll
    }
}


// MARK: - Collection Props

@inlinable
public func count<C: Collection>(_ coll: C) -> Int {
    return coll.count
}

@inlinable
public func isEmpty<C: Collection>(_ coll: C) -> Bool {
    return coll.isEmpty
}

// MARK: - Monoidal Reducing

@inlinable
public func join<S>(_ seq: S) -> S.Element
where S: Sequence, S.Element: Monoid {
    seq |> reduce(.empty, <>)
}

public func join<S>(with separator: S.Element) -> (S) -> S.Element
where S: Sequence, S.Element: Monoid {
    reduce(.empty, { $0 <> $1 <> separator })
}

@inlinable
public func flatten<S>(_ seq: S) -> S.Element
where S: Sequence, S.Element: Sequence & Monoid {
    seq |> reduce(.empty, <>)
}

@inlinable
public func sum<S>(_ seq: S) -> S.Element
where S: Sequence, S.Element: Numeric & Monoid {
    seq |> reduce(.empty, <>)
}
