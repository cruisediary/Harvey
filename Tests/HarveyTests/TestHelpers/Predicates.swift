import Foundation
import Nimble

public func ==(lhs: [AnyHashable: Any], rhs: [AnyHashable: Any]) -> Bool {
    return NSDictionary(dictionary: lhs).isEqual(to: rhs)
}

public func ==(lhs: [AnyHashable: Any]?, rhs: [AnyHashable: Any]) -> Bool {
    guard let lhs = lhs else { return false }

    return lhs == rhs
}

public func ==(lhs: [AnyHashable: Any], rhs: [AnyHashable: Any]?) -> Bool {
    guard let rhs = rhs else { return false }

    return lhs == rhs
}

public func ==(lhs: [AnyHashable: Any]?, rhs: [AnyHashable: Any]?) -> Bool {
    switch (lhs, rhs) {
    case (.none, .none): return true
    case let (.some(lhs1), .some(lhs2)): return lhs1 == lhs2
    default: return false
    }
}

public func equal(_ expectedValue: [AnyHashable: Any]) -> Predicate<[AnyHashable: Any]> {
    return Predicate { expression -> PredicateResult in
        let test: Bool
        if let actualValue = try? expression.evaluate() {
            test = expectedValue == actualValue
        } else {
            test = false
        }

        return PredicateResult(bool: test, message: .expectedActualValueTo("<\(expectedValue)>"))
    }
}
