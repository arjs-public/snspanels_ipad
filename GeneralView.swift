import SwiftUI


struct GeneralView: View {
    @EnvironmentObject var formData: FormData
    
    var body: some View {
        Form {
            Section(
                header: Text("Game ID (from the overlay)")
                    .foregroundColor(.white)) 
            {
                TextField("Game ID", text: $formData.gameId)
            }
            
            Section(
                header: Text("League ID (from the overlay)")
                    .foregroundColor(.white)) 
            {
                TextField("League ID", text: $formData.leagueId)
            }
            
            Section(
                header: Text("Token (from the Token section, use the StreamDeck token)")
                    .foregroundColor(.white)) 
            {
                TextField("Token", text: $formData.token)
            }
        }
    }
}

struct GeneralView_Previews: PreviewProvider {
    @StateObject static var formData = FormData()
    
    static var previews: some View {
        GeneralView()
            .environmentObject(formData)
    }
}
