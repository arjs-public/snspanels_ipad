import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to S'nS Panels").font(.largeTitle)
            Image("snspanels")
                .resizable()
                .frame(width: 500, height: 300)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.accentColor)
                .cornerRadius(10)
            VStack(alignment: .leading, spacing: 2) {
                Text("1. Set paremeters for the game in Settings.")
                Text("2. Goto the Control panel you need")
                Text("3. Start using the control buttons")
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
