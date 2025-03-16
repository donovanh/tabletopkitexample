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

    }

    func onPhaseStarted(interaction: TabletopInteraction) {
    
    }

    func onGesturePhaseEnded(interaction: TabletopInteraction) {

    }

    func onPhaseEnded(interaction: TabletopInteraction) {

    }
}

