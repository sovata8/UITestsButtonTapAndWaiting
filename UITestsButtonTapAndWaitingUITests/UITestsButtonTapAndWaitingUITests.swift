//
//  UITestsButtonTapAndWaitingUITests.swift
//  UITestsButtonTapAndWaitingUITests
//
//  Created by Nikolay Suvandzhiev on 30/05/2022.
//

import XCTest

class UITestsButtonTapAndWaitingUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }


    // ✔ exists
    // ✔ isHittable
    // ✔ isEnabled
    // ✔ isVisible
    func test1() throws {
        let buttonGo = app.buttons["button_go_1"].firstMatch
        printProperties(button: buttonGo)
        buttonGo.strictTap()
    }

    // ✔ exists
    // ✔ isHittable
    // ✘ isEnabled
    // ✔ isVisible
    func test2() throws {
        let buttonGo = app.buttons["button_go_2"].firstMatch
        printProperties(button: buttonGo)
        buttonGo.strictTap()
    }

    // ✔ exists
    // ✘ isHittable
    // ✔ isEnabled
    // ✔ isVisible
    func test3() throws {
        let buttonGo = app.buttons["button_go_3"].firstMatch
        printProperties(button: buttonGo)
        buttonGo.strictTap()
    }

    // ✔ exists
    // ✘ isHittable
    // ✘ isEnabled
    // ✔ isVisible
    func test4() throws {
        let buttonGo = app.buttons["button_go_4"].firstMatch
        printProperties(button: buttonGo)
        buttonGo.strictTap()
    }

    // ✔ exists
    // ✔ isHittable
    // ✔ isEnabled
    // ✔ isVisible
    func test5() throws {
        let buttonGo = app.buttons["button_go_5"].firstMatch
        printProperties(button: buttonGo)
        buttonGo.strictTap()
    }

    // ✔ exists
    // ✘ isHittable
    // ✔ isEnabled
    // ✘ isVisible
    func test6() throws {
        let buttonGo = app.buttons["button_go_6"].firstMatch
        printProperties(button: buttonGo)
        buttonGo.strictTap()
    }

    // ✔ exists
    // ✘ isHittable
    // ✔ isEnabled
    // ✘ isVisible
    func test7() throws {
        let buttonGo = app.buttons["button_go_7"].firstMatch
        printProperties(button: buttonGo)
        buttonGo.strictTap()
    }

    // ✔ exists
    // ✔ isHittable
    // ✔ isEnabled
    // ✘ isVisible
    func test8() throws {
        let buttonGo = app.buttons["button_go_8"].firstMatch
        printProperties(button: buttonGo)
        buttonGo.strictTap()
    }

    // ✘ exists
    // ✘ isHittable
    // ⦻ isEnabled
    // ✘ isVisible
    func test9() throws {
        let buttonGo = app.buttons["button_go_9"].firstMatch
        printProperties(button: buttonGo)
        buttonGo.strictTap()
    }



    // MARK: - ======== Modified ========


    // In this one we press the "unhide Go button" button manually
    func test9_modified() throws {
        let buttonGo = app.buttons["button_go_9"].firstMatch

        XCTAssertEqual(app.waitFor(element: buttonGo, predicate: .exists, timeout: 5), .completed)

        printProperties(button: buttonGo)
        buttonGo.tap()
    }

    // In this one we press the "hide blocker view button" manually
    func test3_modified() throws {
        let buttonGo = app.buttons["button_go_3"].firstMatch

        XCTAssertEqual(app.waitFor(element: buttonGo, predicate: .hittable, timeout: 5), .completed)

        printProperties(button: buttonGo)
        buttonGo.tap()
    }

    // In this one we press the "enable Go button button" manually
    func test2_modified() throws {
        let buttonGo = app.buttons["button_go_2"].firstMatch

        XCTAssertEqual(app.waitFor(element: buttonGo, predicate: .enabled, timeout: 5), .completed)

        printProperties(button: buttonGo)
        buttonGo.tap()
    }
}


private extension UITestsButtonTapAndWaitingUITests {
    func printProperties(button: XCUIElement) {
        return;
        print(">> \(button.exists.asString) exists")
        print(">> \(button.isHittable.asString) isHittable")
        print(">> \(button.isEnabled.asString) isEnabled")
        print(">> \(button.isVisible.asString) isVisible")
    }
}


private extension Bool {
    var asString: String {
        switch self {
        case true: return "✔"
        case false: return "✘"
        }
    }
}


extension NSPredicate {
    static let exists = NSPredicate(format: "\(#keyPath(XCUIElement.exists)) == \(true)")
    static let doesNotExist = NSPredicate(format: "\(#keyPath(XCUIElement.exists)) == \(false)")
    static let hittable = NSPredicate(format: "\(#keyPath(XCUIElement.isHittable)) == \(true)")
    static let notHittable = NSPredicate(format: "\(#keyPath(XCUIElement.isHittable)) == \(false)")
    static let enabled = NSPredicate(format: "\(#keyPath(XCUIElement.isEnabled)) == \(true)")
    static let disabled = NSPredicate(format: "\(#keyPath(XCUIElement.isEnabled)) == \(false)")
}



extension XCUIElement {
    func strictTap(app: XCUIApplication = XCUIApplication(),
                   file: StaticString = #file,
                   line: UInt = #line) {
        XCTAssertTrue(self.isVisible, file: file, line: line)
        XCTAssertTrue(self.isEnabled, file: file, line: line)
        self.tap()
    }

    func strictTapWithWait(timeout: TimeInterval = 1,
                           app: XCUIApplication = XCUIApplication(),
                           file: StaticString = #file,
                           line: UInt = #line) {
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [.exists,
                                                                            .enabled])
        XCTAssertEqual(app.waitFor(element: self, predicate: predicate, timeout: timeout), .completed, file: file, line: line)
        XCTAssertTrue(self.isVisible, file: file, line: line)

        self.tap()
    }

    var isVisible: Bool {
        guard exists && !frame.isEmpty else { return false }
        let frameOfWindow = XCUIApplication().windows.element(boundBy: 0).frame
        return frameOfWindow.contains(frame)
    }
}


extension XCUIApplication {
    func waitFor(element: XCUIElement,
                 predicate: NSPredicate,
                 timeout: TimeInterval = 1) -> XCTWaiter.Result {
        let expectation = XCTNSPredicateExpectation(predicate: predicate,
                                                    object: element)
        return XCTWaiter().wait(for: [expectation],
                                timeout: timeout)
    }
}
