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

    // TODO: Add Render `Composite` structures.

    // TODO: Create new directory for current target / test case
    func render(_ layer: CALayer, name: String) {
        layer.renderToPDF(at: artifactsDirectory.appendingPathComponent("\(name).pdf"))
    }

    func render(_ path: StyledPath, name: String) {
        let layer = CAShapeLayer(path)
        render(layer, name: name)
    }

    open override func tearDown() {
        super.tearDown()
        let bundleURL = Bundle(for: type(of: self)).bundleURL
        print("Test artifacts produced at: \(bundleURL)/Artifacts")
    }
}
