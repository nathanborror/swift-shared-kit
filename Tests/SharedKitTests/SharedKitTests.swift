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
}
