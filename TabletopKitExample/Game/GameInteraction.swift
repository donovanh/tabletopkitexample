//
//  GameInteraction.swift
//  TabletopKitExample
//

import RealityKit
import TabletopKit

struct GameInteraction: TabletopInteraction.Delegate {
    let game: Game

    mutating func update(interaction: TabletopKit.TabletopInteraction) {
        let equipment = interaction.value.controlledEquipmentID
        guard let destination = interaction.value.proposedDestination else {
            return
        }

        if interaction.value.phase == .ended {
            interaction.addAction(.moveEquipment(matching: equipment, childOf: destination.equipmentID, pose: destination.pose))
        }

        // print("Update called, \(interaction)")
//        var destination = interaction.value.proposedDestination?.equipmentID
//
//        if interaction.value.phase == .started {
//            onPhaseStarted(interaction: interaction)
//        }
//
//        if interaction.value.gesture?.phase == .ended {
//            onGesturePhaseEnded(interaction: interaction)
//        }
//
//        if interaction.value.phase == .ended {
//            destination = nil
//            onPhaseEnded(interaction: interaction)
//        }

        // TODO: game.renderer.updateCursor(destination)
    }

    func onPhaseStarted(interaction: TabletopInteraction) {
        if let block = game.tabletopGame.equipment(of: Block.self, matching: interaction.value.startingEquipmentID) {
            print("Starting movement of \(block.id)")
        }
    }

    func onGesturePhaseEnded(interaction: TabletopInteraction) {

    }

    func onPhaseEnded(interaction: TabletopInteraction) {

    }
}

