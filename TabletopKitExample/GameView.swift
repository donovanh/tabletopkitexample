//
//  ContentView.swift
//  TabletopKitExample
//

import RealityKit
import RealityKitContent
import SwiftUI
import TabletopKit

@MainActor
struct GameView: View {
    @State private var game: Game?
    @State private var activityManager: GroupActivityManager?

    var body: some View {
        ZStack {
            if let loadedGame = game {
                RealityView { (content: inout RealityViewContent) in
                    content.entities.append(loadedGame.renderer.root)
                }.tabletopGame(loadedGame.tabletopGame, parent: loadedGame.renderer.root) { _ in
                    GameInteraction(game: loadedGame)
                }
            }
        }
        .task {
            self.game = await Game()
            self.activityManager = .init(tabletopGame: game!.tabletopGame)
        }
    }
}
