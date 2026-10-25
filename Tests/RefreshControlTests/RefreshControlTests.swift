import XCTest
import UIKit
@testable import RefreshControl

final class RefreshControlTests: XCTestCase {
    @MainActor
    func testReplacingContentRemovesPreviousViewAndDelegate() {
        let control = ContentHostingRefreshControl()
        let originalContent = control.contentView
        let firstContent = RecordingContentView()
        let secondContent = RecordingContentView()

        control.setContentView(firstContent)
        control.setContentView(secondContent)
        control.endRefreshing()

        XCTAssertNil(originalContent.superview)
        XCTAssertNil(firstContent.superview)
        XCTAssertTrue(secondContent.superview === control)
        XCTAssertEqual(firstContent.finishCount, 0)
        XCTAssertEqual(secondContent.finishCount, 1)
    }

    @MainActor
    func testReinstallingSameContentDoesNotDuplicateNotifications() {
        let control = ContentHostingRefreshControl()
        let content = RecordingContentView()

        control.setContentView(content)
        control.setContentView(content)
        control.endRefreshing()

        XCTAssertTrue(content.superview === control)
        XCTAssertEqual(content.finishCount, 1)
    }
}

@MainActor
private final class RecordingContentView: UIView, RefreshControlContentView {
    var attributedText: NSAttributedString?
    var finishCount = 0

    func refreshControl(_ refreshControl: UIRefreshControl, updated revealedFraction: Double) {}
    func didTriggered(_ refreshControl: UIRefreshControl) {}
    func didFinishRefreshing(_ refreshControl: UIRefreshControl) {
        finishCount += 1
    }
}
