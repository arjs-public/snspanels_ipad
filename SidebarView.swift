import SwiftUI

struct SidebarView: View {
    @StateObject private var formData = FormData()
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: WelcomeView()) {
                    Label("Welcome", systemImage: "star")
                }
                
                Spacer()
                
                Text("CONTROLS")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                Group{
                    NavigationLink(
                        destination: SetupView()
                            .environmentObject(formData)
                    ) {
                        Label("Setup", systemImage: "square.grid.3x3.topleft.filled")
                    }
                    NavigationLink(
                        destination: GameView()
                            .environmentObject(formData)
                    ) {
                        Label("Game", systemImage: "rectangle.grid.3x2")
                    }
                    NavigationLink(
                        destination: ScoresView()
                            .environmentObject(formData)
                    ) {
                        Label("Scores", systemImage: "rectangle.lefthalf.filled")
                        
                    }
                    NavigationLink(
                        destination: ClockView()
                            .environmentObject(formData)
                    ) {
                        Label("Clock", systemImage: "clock")
                    }
                    NavigationLink(
                        destination: FullView()
                            .environmentObject(formData)
                    ) {
                        Label("Full", systemImage: "tablecells")
                    }
                }
                
                Spacer()
                
                Text("SETTINGS")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                Group {
                    NavigationLink(
                        destination: GeneralView()
                            .environmentObject(formData)) 
                    {
                        Label("General", systemImage: "gear")
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("S'nS Panels")
            .frame(minWidth: 150, idealWidth: 250, maxWidth: 300)
            
            WelcomeView()
        }
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
    }
}
