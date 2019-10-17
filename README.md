# BackspaceJSON

Codable has made consuming JSON much easier, but there are still cases where it's not suitable, such as a configuration file with arbitrary keys and values. In those cases, you just want type-safe access to values without a lot of fuss.

BackspaceJSON is a tiny (~100 lines) solution.

### initialization

```
init(data: Data, options: JSONSerialization.ReadingOptions = .allowFragments) throws
```

Create a JSON object from data.

```
let json = JSON(data: data)
```

### traversal

```swift
subscript(index: Int) -> JSON
subscript(key: String) -> JSON
```

Use string and integer subscripts to traverse any path through the JSON object. Subscripts always return another JSON object, so optional chaining isn't required.

```
json["first"][0]["second"][1]
```

### values

```swift
var dictionary: [String: JSON]?
var array: [JSON]?
var string: String?
var number: NSNumber?
var double: Double?
var int: Int?
var bool: Bool?
```

Extract the value from a JSON object using the optional properties.

```
json["key"][0].string
```

### existence

```
var exists: Bool
var existsNull: Bool
var existsNotNull: Bool
```

BackspaceJSON distinguishes between null and missing values.

```
json["one"]["two"].exists        // If true, a value exists at this path (possibly null).
json["one"]["two"].existsNull    // If true, a null value exists at this path.
json["one"]["two"].existsNotNull // If true, a non-null value exists at this path.
```

### license

MIT license.
