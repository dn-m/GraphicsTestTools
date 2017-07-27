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
            .appendingPathComponent("Artifacts")
    }()

    lazy var testCaseDirectory: URL = {
        return self.artifactsDirectory.appendingPathComponent("\(type(of: self))")
    }()

    open override func setUp() {
        super.setUp()
        print("set up: create dir at: \(artifactsDirectory)")
        do {
            try FileManager.default.createDirectory(
                at: testCaseDirectory,
                withIntermediateDirectories: true,
                attributes: nil
            )
        } catch {
            print(error)
        }
    }

    open override func tearDown() {
        super.tearDown()
        let path = artifactsDirectory.absoluteString
        _ = shell("open", path)
        print("tear down: open dir at: \(path)")
        print("Test artifacts produced at: \(path)")
    }

    // TODO: Add Render `Composite` structures.

    // TODO: Create new directory for current target / test case
    public func render(_ layer: CALayer, name: String) {
        layer.renderToPDF(at: testCaseDirectory.appendingPathComponent("\(name).pdf"))
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
        #else
            return 0
        #endif
    }
}
