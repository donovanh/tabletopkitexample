//
//  Block.swift
//  TabletopKitExample
//
//  Function for generating a block
//
import RealityKit

func generateBlock() -> ModelEntity {

    let pieceWidth: Float = 0.0375
    let pieceHeight: Float = 0.0225
    let pieceLength: Float = 0.1125

    var metallicMaterial = SimpleMaterial(color: .gray, isMetallic: true)
    metallicMaterial.metallic = MaterialScalarParameter(floatLiteral: 1.0)
    metallicMaterial.roughness = MaterialScalarParameter(floatLiteral: 0.3)

    let boxShape: MeshResource = .generateBox(
        width: pieceWidth,
        height: pieceHeight,
        depth: pieceLength,
        cornerRadius: 0.0025
    )
    let piece = ModelEntity(
        mesh: boxShape,
        materials: [metallicMaterial]
    )

    // Physics
    let physicsMaterial = PhysicsMaterialResource.generate(
        staticFriction: 0.8,
        dynamicFriction: 0.8,
        restitution: 0
    )

    piece.components[PhysicsBodyComponent.self] = .init(
        massProperties: .init(
            shape: .generateBox(
                width: pieceWidth,
                height: pieceHeight,
                depth: pieceLength
            ),
            mass: 1
        ),
        material: physicsMaterial,
        mode: .static
    )

    // Shadow
    piece.components.set(GroundingShadowComponent(castsShadow: true))

    // Input
    piece.components.set(InputTargetComponent())

    // Sound
    piece.spatialAudio = SpatialAudioComponent()

    // Collisions
    piece.generateCollisionShapes(recursive: false)

    return piece
}
