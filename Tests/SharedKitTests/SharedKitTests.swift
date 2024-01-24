import XCTest
@testable import SharedKit

final class SharedKitTests: XCTestCase {
    
    func testStringApply() throws {
        
        let str1 = "This is my".apply(with: " content")
        XCTAssertEqual(str1, "This is my content")
        
        let nilStr: String? = nil
        let str2 = nilStr.apply(with: "This is my content")
        XCTAssertEqual(str2, "This is my content")
    }
    
    func testURLQueryParameterExtension() {
        var url = URL(string: "https://www.google.com/search?q=swift")!
        let queryParameters = url.queryParameters
        XCTAssertEqual(queryParameters["q"], "swift")
        
        url.queryParameters["test"] = "foo"
        XCTAssertEqual(url.queryParameters["test"], "foo")
        XCTAssertEqual(url.queryParameters["q"], "swift")
    }
}
