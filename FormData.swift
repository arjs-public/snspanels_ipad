import SwiftUI
import Combine

class FormData: ObservableObject {
    @Published var gameId: String = "6633d99fd56048341f1f2427"
    @Published var leagueId: String = "gflj"
    @Published var token: String = ""
}
