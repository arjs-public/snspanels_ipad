import SwiftUI

struct SetupView: View {
    @EnvironmentObject var formData: FormData
    @State private var retValue: String = ""
    let buttonDataWrapper: ButtonDataWrapper? = loadButtonData("setup")
    
    var body: some View {
        VStack() {
            BoardView()
                .frame(width: 600)
        }
        .frame(height: 110)
//        VStack(alignment: .leading) {
//            Text("Game ID: \(formData.gameId)")
//            Text("League ID: \(formData.leagueId)")
//            Text("Token: \(formData.token)")
//        }
//        .frame(maxWidth: .infinity)
        
        if let buttonDataWrapper = buttonDataWrapper {
            VStack {
                ForEach(0..<buttonDataWrapper.pattern.count, id: \.self) { rowIndex in
                    HStack {
                        let rowCount = buttonDataWrapper.pattern[rowIndex]
                        if rowCount == 0 {
                            Spacer().frame(minHeight: 30).background(Color.clear)
                        } else {
                            ForEach(0..<buttonDataWrapper.pattern[rowIndex], id: \.self) { buttonIndex in
                                let index = buttonIndex + calculateCumulativeSum(array: buttonDataWrapper.pattern, upTo: rowIndex)
                                let buttonData = buttonDataWrapper.buttons[index]
                                Button(action: {
                                    print("sent", buttonData.command)
                                    Task {
                                        retValue = await sendRequest(command: buttonData.command, token: formData.token) ?? "No return."
                                    }
                                    print("got", retValue)
                                }) {
                                    Text(buttonData.title)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .font(rowCount == 6 ? .headline : .title)
                                        .background(colorFromString(buttonData.background))
                                        .foregroundColor(colorFromString(buttonData.color))
                                        .cornerRadius(8)
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        } else {
            Text("Failed to load button data")
        }
    }
}

struct SetupView_Previews: PreviewProvider {
    @StateObject static var formData = FormData()
    
    static var previews: some View {
        SetupView()
            .environmentObject(formData)
    }
}
