import SwiftUI

struct GameView: View {
    @EnvironmentObject var formData: FormData
    @State private var retValue: String = ""
    @State private var isToGoShow: Bool = true
    let buttonDataWrapper: ButtonDataWrapper? = loadButtonData("game")
    
    var body: some View {
        VStack() {
            BoardView()
                .frame(width: 600)
        }
        .frame(height: 110)
        
        if let buttonDataWrapper = buttonDataWrapper {
            VStack {
                //let _ = print(buttonDataWrapper.pattern.count)
                ForEach(0..<buttonDataWrapper.pattern.count, id: \.self) { rowIndex in
                    HStack {
                        //let _ = print("rowIndex", rowIndex)
                        let rowCount = buttonDataWrapper.pattern[rowIndex]
                        //let _ = print("rowCount", rowCount)
                        if rowCount == 0 {
                            Spacer().frame(minHeight: 30).background(Color.clear)
                            //let _ = print("Spacer")
                        } else {
                            ForEach(0..<buttonDataWrapper.pattern[rowIndex], id: \.self) { buttonIndex in
                                let limit = calculateCumulativeSum(array: buttonDataWrapper.pattern, upTo: rowIndex)
                                //let _ = print("limit", limit)
                                let index = buttonIndex + limit
                                //let _ = print("index", index)
                                let buttonData = buttonDataWrapper.buttons[index]
                                //let _ = print("title", buttonData.title)
                                Button(action: {
                                    print("sent", buttonData.command)
                                    Task {
                                        // Split the commands by comma and trim any whitespace
                                        let commands = buttonData.command.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                                        
                                        // Iterate over each command, handle downShow logic, send the request, print the result, and add a delay
                                        for command in commands {
                                            if command.hasPrefix("distanceSh") {
                                                var shouldSendRequest = false
                                                
                                                if command.contains(":True") {
                                                    if !isToGoShow {
                                                        isToGoShow = true
                                                        shouldSendRequest = true
                                                    }
                                                } else if command.contains(":False") {
                                                    if isToGoShow {
                                                        isToGoShow = false
                                                        shouldSendRequest = true
                                                    }
                                                } else {
                                                    isToGoShow.toggle()
                                                    shouldSendRequest = true
                                                }
                                                
                                                // Remove the ":True" or ":False" from the command
                                                let modifiedCommand = command.replacingOccurrences(of: ":True", with: "").replacingOccurrences(of: ":False", with: "")
                                                
                                                if shouldSendRequest {
                                                    retValue = await sendRequest(command: modifiedCommand, token: formData.token) ?? "No return."
                                                    print("got", retValue)
                                                }
                                            } else {
                                                retValue = await sendRequest(command: command, token: formData.token) ?? "No return."
                                                print("got", retValue)
                                            }
                                            
                                            // Add a delay of 100ms between commands
                                            try? await Task.sleep(nanoseconds: 100_000_000) // 100ms = 100,000,000 nanoseconds
                                        }
                                    }
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

struct GameView_Previews: PreviewProvider {
    @StateObject static var formData = FormData()
    
    static var previews: some View {
        GameView()
            .environmentObject(formData)
    }
}

