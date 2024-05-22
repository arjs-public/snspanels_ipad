import SwiftUI
import WebKit

struct BoardView: UIViewRepresentable {
    @EnvironmentObject var formData: FormData
    
    func makeUIView(context: Context) -> WKWebView {
        WKWebView(frame: .zero)
    }
    
    func updateUIView(_ view: WKWebView, context: UIViewRepresentableContext<BoardView>) {
        let request = URLRequest(url: URL(string: "https://statsnscore.online/overlay/game/\(formData.gameId)/iframe\(formData.leagueId)")!)
        
        view.load(request)
    }
    
}
