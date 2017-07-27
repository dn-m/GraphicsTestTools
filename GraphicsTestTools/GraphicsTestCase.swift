//
//  GraphicsTestCase.swift
//  GraphicsTestTools
//
//  Created by James Bean on 7/27/17.
//
//

import XCTest
import GraphicsTools

open class GraphicsTestCase: XCTestCase {

    lazy var artifactsDirectory: URL = {
        return Bundle(for: type(of: self)).bundleURL
            .deletingLastPathComponent()
            .appendingPathComponent("Artifacts/\(type(of: self))")
    }()

    open override func setUp() {
        super.setUp()
        try? FileManager.default.createDirectory(
            at: artifactsDirectory,
            withIntermediateDirectories: true,
            attributes: nil
        )
    }

    open override func tearDown() {
        super.tearDown()
        let bundlePath = Bundle(for: type(of: self)).bundlePath
        _ = shell("open", "\(bundlePath)/Artifacts")
        print("Test artifacts produced at: \(bundlePath)/Artifacts")
    }

    // TODO: Add Render `Composite` structures.

    // TODO: Create new directory for current target / test case
    public func render(_ layer: CALayer, name: String) {
        layer.renderToPDF(at: artifactsDirectory.appendingPathComponent("\(name).pdf"))
    }

    public func render(_ path: StyledPath, name: String) {
        let layer = CAShapeLayer(path)
        render(layer, name: name)
    }

    private func shell(_ args: String...) -> Int32 {
        #if os(OSX)
            let task = Process()
            task.launchPath = "/usr/bin/env"
            task.arguments = args
            task.launch()
            task.waitUntilExit()
            return task.terminationStatus
        #endif
        return 0
    }
}
