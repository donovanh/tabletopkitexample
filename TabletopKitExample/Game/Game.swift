//
//  Game.swift
//  TabletopKitExample
//
//  Based on TabletopKit demo code
//  This sets up the game, with rendering and observers for interactions, and a way to reset the game
//

import TabletopKit
import SwiftUI

@Observable
class Game {
    let tabletopGame: TabletopGame
    let renderer: GameRenderer
    let observer: GameObserver
    let setup: GameSetup

    @MainActor
    init() async {
        renderer = GameRenderer()
        setup = GameSetup(root: renderer.root)

        tabletopGame = TabletopGame(tableSetup: setup.setup)

        observer = GameObserver(tabletop: tabletopGame, renderer: renderer)
        tabletopGame.addObserver(observer)

        tabletopGame.addRenderDelegate(renderer)
        renderer.game = self

        tabletopGame.claimAnySeat()
    }

    deinit {
        tabletopGame.removeObserver(observer)
        tabletopGame.removeRenderDelegate(renderer)
    }
}
