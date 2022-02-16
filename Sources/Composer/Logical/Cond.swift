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

public func cond<T1, T2>(_ conditions: [((T1) -> Bool, T2)]) -> (T1) -> T2? {
    return { value in
        for (predicate, result) in conditions {
            guard predicate(value) else { continue }
            return result
        }
        return nil
    }
}

public func cond<T1, T2>(_ conditions: [((T1) -> Bool, T2)], `default`: T2) -> (T1) -> T2 {
    return { value in
        for (predicate, result) in conditions {
            guard predicate(value) else { continue }
            return result
        }
        return `default`
    }
}


public func cond<T1, T2>(_ conditions: [((T1) -> Bool, (T1) -> T2)]) -> (T1) -> T2? {
    return { value in
        for (predicate, action) in conditions {
            guard predicate(value) else { continue }
            return action(value)
        }
        return nil
    }
}

public func cond<T1, T2>(_ conditions: [((T1) -> Bool, (T1) -> T2)], `default`: @escaping (T1) -> T2) -> (T1) -> T2 {
    return { value in
        for (predicate, action) in conditions {
            guard predicate(value) else { continue }
            return action(value)
        }
        return `default`(value)
    }
}
