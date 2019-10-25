# BackspaceJSON

Codable has made consuming JSON on iOS much easier, but there are still cases where it's not suitable, such as a configuration file with arbitrary keys and values. In those cases, you just want type-safe access to values without a lot of fuss.

BackspaceJSON is a tiny (single enum, ~100 lines) framework written in Swift.

### Initialization

```
init(data: Data, options: JSONSerialization.ReadingOptions = .allowFragments) throws
```

Create a JSON object from data.

```
let json = JSON(data: data)
```

### Traversal

```swift
subscript(index: Int) -> JSON
subscript(key: String) -> JSON
```

Use string and integer subscripts to traverse any path through the JSON object. Subscripts always return another JSON object, so optional chaining isn't required.

```
json["first"][0]["second"][1]
```

### Values

```swift
var dictionary: [String: JSON]?
var array: [JSON]?
var string: String?
var number: NSNumber?
var double: Double?
var int: Int?
var bool: Bool?
```

Extract the value from a JSON object using optional properties.

```
json["key"][0].string
```

### Existence

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

### Example

This code fetches the current version of an app from the App Store.

```
let url = URL(string: "http://itunes.apple.com/lookup?id=<YOUR_APP_ID>")!
let task = URLSession.shared.dataTask(with: url) { data, response, error in
  guard let data = data,
        let json = try? JSON(data: data),
        let currentVersion = json["results"][0]["version"].string else {
    print("Lookup failed.")
    return
  }

  print("Current version is \(currentVersion).")
}

task.resume()
```

### Installation

Install via CocoaPods:

```
pod "BackspaceJSON"
```

Alternatively, just copy the single file `BackspaceJSON/JSON.swift` into your project.

### License

MIT license.
