//
//  TabletopKitExampleApp.swift
//  TabletopKitExample
//
//  Code adapted from demo project here: https://developer.apple.com/documentation/tabletopkit

import SwiftUI

@main
struct TabletopKitExampleApp: App {
    var body: some Scene {
        WindowGroup(id: "game") {
            GameView()
                .volumeBaseplateVisibility(.hidden)
        }
        .windowStyle(.volumetric)
        .volumeWorldAlignment(.gravityAligned)
        .defaultSize(width: 0.7, height: 2, depth: 0.7, in: .meters)
    }
}
