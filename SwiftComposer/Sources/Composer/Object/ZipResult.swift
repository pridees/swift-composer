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

public func zip<R1, R2, E: Error>(
    _ r1: Result<R1, E>,
    _ r2: Result<R2, E>
) -> Result<(R1, R2), E> {
    return r1.flatMap { lhs in r2.flatMap { rhs in .success((lhs, rhs)) }}
}

public func zip<R1, R2, T, E: Error>(
    with transform: @escaping (R1, R2) -> T
) -> (Result<R1, E>, Result<R2, E>) -> Result<T, E> {
    return { r1, r2 in zip(r1, r2).map(transform) }
}

public func zip3<R1, R2, R3, E: Error>(
    _ r1: Result<R1, E>,
    _ r2: Result<R2, E>,
    _ r3: Result<R3, E>
) -> Result<(R1, R2, R3), E> {
    zip(zip(r1, r2), r3).map { ($0.0, $0.1, $1) }
}

public func zip3With<R1, R2, R3, T, E: Error>(
    transform: @escaping (R1, R2, R3) -> T
)
-> (Result<R1, E>, Result<R2, E>, Result<R3, E>)
-> Result<T, E> {
    return { r1, r2, r3 in zip3(r1, r2, r3).map(transform) }
}
    
public func zip4<R1, R2, R3, R4, E: Error>(
    _ r1: Result<R1, E>,
    _ r2: Result<R2, E>,
    _ r3: Result<R3, E>,
    _ r4: Result<R4, E>
) -> Result<(R1, R2, R3, R4), E> {
    zip(zip(r1, r2), zip(r3, r4 )).map { ($0.0, $0.1, $1.0, $1.1) }
}

public func zip4With<R1, R2, R3, R4, T, E: Error>(
    with transform: @escaping (R1, R2, R3, R4) -> T
)
-> (Result<R1, E>, Result<R2, E>, Result<R3, E>, Result<R4, E>)
-> Result<T, E> {
    return { r1, r2, r3, r4 in zip4(r1, r2, r3, r4).map(transform) }
}
