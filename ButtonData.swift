import SwiftUI

struct ButtonData: Codable {
    let title: String // Titel des Buttons
    let command: String // Befehl beim Tippen auf den Button
    let color: String // Vordergrund Farbe
    let background: String // Hintergrund Farbe
}

struct ButtonDataWrapper: Codable {
    let buttons: [ButtonData]
    let pattern: [Int]
}
