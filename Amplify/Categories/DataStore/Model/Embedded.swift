//
// Copyright 2018-2020 Amazon.com,
// Inc. or its affiliates. All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

// MARK: - Embeddable

/// A `Embeddable` type can be used in a `Model` as an embedded type. All types embedded in a `Model` as an
/// `embedded(type:)` or `embeddedCollection(of:)` must comform to the `Embeddable` protocol except for Swift's Basic
/// types embedded as a collection. A collection of String can be embedded in the `Model` as
/// `embeddedCollection(of: String.self)` without needing to conform to Embeddable. 
public protocol Embeddable: Codable {

    /// A reference to the `ModelSchema` associated with this embedded type.
    static var schema: ModelSchema { get }
}

extension Embeddable {
    public static func defineSchema(name: String? = nil,
                                    attributes: ModelAttribute...,
                                    define: (inout ModelSchemaDefinition) -> Void) -> ModelSchema {
        var definition = ModelSchemaDefinition(name: name ?? "",
                                               attributes: attributes)
        define(&definition)
        return definition.build()
    }
}
