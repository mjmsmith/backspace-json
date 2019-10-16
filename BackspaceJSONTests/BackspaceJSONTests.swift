import XCTest
@testable import BackspaceJSON

class BackspaceJSONTests: XCTestCase {
  func data(_ utf8String: String) -> Data {
    return utf8String.data(using: .utf8) ?? Data()
  }


  override func setUp() {
  }

  override func tearDown() {
  }

  func testString() {
    try XCTAssertEqual(JSON(data: data("\"123\"")).string, "123")

    try XCTAssertNil(JSON(data: data("123")).string)
  }

  func testNumber() {
    try XCTAssertEqual(JSON(data: data("123")).number, 123)
    try XCTAssertEqual(JSON(data: data("123")).int, 123)
    try XCTAssertEqual(JSON(data: data("123")).double, 123.0)

    try XCTAssertEqual(JSON(data: data("123.1")).number, 123.1)
    try XCTAssertEqual(JSON(data: data("123.1")).int, 123)
    try XCTAssertEqual(JSON(data: data("123.1")).double, 123.1)

    try XCTAssertNil(JSON(data: data("\"abc\"")).number)
    try XCTAssertNil(JSON(data: data("true")).number)
  }

  func testBool() {
    try XCTAssertEqual(JSON(data: data("false")).bool, false)
    try XCTAssertEqual(JSON(data: data("true")).bool, true)

    try XCTAssertNil(JSON(data: data("0")).bool)
    try XCTAssertNil(JSON(data: data("\"abc\"")).bool)
  }

  func testExistsNull() {
    try XCTAssertTrue(JSON(data: data("null")).existsNull)
    try XCTAssertTrue(JSON(data: data("{\"a\": null}"))["a"].existsNull)

    try XCTAssertFalse(JSON(data: data("123")).existsNull)
    try XCTAssertFalse(JSON(data: data("{\"a\": 0}"))["a"].existsNull)
    try XCTAssertFalse(JSON(data: data("{\"b\": null}"))["a"].existsNull)
  }

  func testExistsNotNull() {
    try XCTAssertTrue(JSON(data: data("123")).existsNotNull)
    try XCTAssertTrue(JSON(data: data("{\"a\": 0}"))["a"].existsNotNull)

    try XCTAssertFalse(JSON(data: data("null")).existsNotNull)
    try XCTAssertFalse(JSON(data: data("{\"a\": null}"))["a"].existsNotNull)
    try XCTAssertFalse(JSON(data: data("{\"b\": null}"))["a"].existsNotNull)
  }

  func testArray() {
    let array = data("""
                     [123, "123"]
                     """)

    try XCTAssertEqual(JSON(data: array)[0].number, 123)
    try XCTAssertEqual(JSON(data: array)[1].string, "123")
    try XCTAssertFalse(JSON(data: array)[2].exists)
  }

  func testDictionary() {
    let dict = data(
      """
        {
          "a": 123,
          "b": "123",
          "c": {
            "d": 789,
            "e": "789",
            "f": [123, "123", true, null]
          }
        }
      """
    )

    try! print(JSON(data: dict))

    try XCTAssertEqual(JSON(data: dict)["a"].number, 123)
    try XCTAssertEqual(JSON(data: dict)["b"].string, "123")
    try XCTAssertEqual(JSON(data: dict)["c"]["d"].number, 789)
    try XCTAssertEqual(JSON(data: dict)["c"]["e"].string, "789")
    try XCTAssertEqual(JSON(data: dict)["c"]["f"][0].number, 123)
    try XCTAssertEqual(JSON(data: dict)["c"]["f"][1].string, "123")
    try XCTAssertEqual(JSON(data: dict)["c"]["f"][2].bool, true)
    try XCTAssertTrue(JSON(data: dict)["c"]["f"][3].existsNull)

    try XCTAssertFalse(JSON(data: dict)["d"].exists)
    try XCTAssertFalse(JSON(data: dict)["c"]["f"][4].exists)
    try XCTAssertFalse(JSON(data: dict)["c"]["g"].exists)
  }
}
