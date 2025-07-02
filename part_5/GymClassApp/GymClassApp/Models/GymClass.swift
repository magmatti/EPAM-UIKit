import Foundation

struct GymClass: Equatable {
    let id: UUID
    let name: String
    let date: Date
    let time: String
    let duration: String
    let trainerName: String
    let trainerImageName: String
    var  isRegistered: Bool
}
