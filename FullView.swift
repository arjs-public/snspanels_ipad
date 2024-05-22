import SwiftUI


struct FullView: View {
    @EnvironmentObject var formData: FormData
    @State private var retValue: String = ""
    let buttonDataWrapper: ButtonDataWrapper? = loadButtonData("full")
    
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

struct FullView_Previews: PreviewProvider {
    @StateObject static var formData = FormData()
    
    static var previews: some View {
        FullView()
            .environmentObject(formData)
    }
}

