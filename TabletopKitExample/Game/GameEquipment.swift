//
//  GameEquipment.swift
//  TabletopKitExample
//

 import TabletopKit
 import RealityKit
 import Spatial

 extension EquipmentIdentifier {
     static var tableID: Self { .init(0) }
 }

struct Table: EntityTabletop {
    var shape: TabletopShape
    var entity: Entity
    var id: EquipmentIdentifier

    init() {
        let newTableEntity = ModelEntity(
            mesh: .generateCylinder(height: GameMetrics.tableThickness, radius: GameMetrics.radius),
            materials: [SimpleMaterial(color: .brown, isMetallic: false)]
        )
        newTableEntity.name = "table"

        self.entity = newTableEntity
        self.shape = .round(entity: entity)
        self.id = .tableID
    }
}

struct Block: EntityEquipment {
    var id: EquipmentIdentifier
    var entity: Entity
    var initialState: BaseEquipmentState

    @MainActor
    init(index: Int = 0, position: TableVisualState.Point2D, orientation: Float = 0) {
        id = EquipmentIdentifier(index)

        let newEntity = generateBlock()
        newEntity.name = "Block-\(index)"

        let rotation = Angle2D(radians: orientation)

        initialState = State(
            parentID: .tableID,
            pose: .init(position: position, rotation: rotation),
            entity: newEntity
        )
        entity = newEntity
    }
}

 struct PlayerSeat: TableSeat {
     let id: ID
     var initialState: TableSeatState

     @MainActor static let seatPoses: [TableVisualState.Pose2D] = [
         .init(position: .init(x: 0, z: Double(GameMetrics.tableEdge)), rotation: .degrees(0)),
         .init(position: .init(x: -Double(GameMetrics.tableEdge), z: 0), rotation: .degrees(-90)),
         .init(position: .init(x: Double(GameMetrics.tableEdge), z: 0), rotation: .degrees(90))
     ]

     init(id: TableSeatIdentifier, pose: TableVisualState.Pose2D) {
         self.id = id
         let spatialSeatPose: TableVisualState.Pose2D = .init(position: pose.position,
                                                              rotation: pose.rotation)
         initialState = .init(pose: spatialSeatPose)
     }
 }
