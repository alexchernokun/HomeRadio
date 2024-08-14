//
//  ModuleBuilder.swift
//  
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import Foundation

/// Conformance protocol for all SwiftUI module builders
public protocol ModuleBuilder {
    associatedtype ViewType
    var container: DIContainer { get }
    func build() -> ViewType
}
