import Foundation

public enum JSON {
  case dictionary([String: JSON])
  case array([JSON])
  case string(String)
  case number(NSNumber)
  case bool(Bool)
  case null
  case none

  private static let boolNumberType = type(of: NSNumber(value: true))

  public init(data: Data, options: JSONSerialization.ReadingOptions = .allowFragments) throws {
    self = try JSON(JSONSerialization.jsonObject(with: data, options: options))
  }

  public subscript(index: Int) -> JSON {
    guard case let .array(array) = self, index >= 0, index < array.count else {
      return .none
    }

    return array[index]
  }

  public subscript(key: String) -> JSON {
    guard case let .dictionary(dict) = self, let value = dict[key] else {
      return .none
    }

    return value
  }

  public var dictionary: [String: JSON]? {
    guard case let .dictionary(value) = self else {
      return nil
    }

    return value
  }

  public var array: [JSON]? {
    guard case let .array(value) = self else {
      return nil
    }

    return value
  }

  public var string: String? {
    guard case let .string(value) = self else {
      return nil
    }

    return value
  }

  public var number: NSNumber? {
    guard case let .number(value) = self else {
      return nil
    }

    return value
  }

  public var double: Double? {
    return self.number?.doubleValue
  }

  public var int: Int? {
    return self.number?.intValue
  }

  public var bool: Bool? {
    guard case let .bool(value) = self else {
      return nil
    }

    return value
  }

  public var exists: Bool {
    if case .none = self {
      return false
    }

    return true
  }

  public var existsNull: Bool {
    if case .null = self {
      return true
    }

    return false
  }

  public var existsNotNull: Bool {
    return self.exists && !self.existsNull
  }

  private init(_ object: Any) {
    switch object {
      case let dictionary as [String: Any]:
        self = .dictionary(dictionary.mapValues({ JSON($0) }))
      case let array as [Any]:
        self = .array(array.map({ JSON($0) }))
      case let string as String:
        self = .string(string)
      case let number as NSNumber:
        self = (type(of: number) == Self.boolNumberType) ? .bool(number != 0) : .number(number)
      case let bool as Bool:
        self = .bool(bool)
      case _ as NSNull:
        self = .null
      default:
        self = .none
    }
  }
}
