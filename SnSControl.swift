import SwiftUI
import Foundation

// load data from given button layout file
func loadButtonData(_ buttons: String) -> ButtonDataWrapper? {
    if let url = Bundle.main.url(forResource: buttons, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let buttonData = try decoder.decode(ButtonDataWrapper.self, from: data)
            return buttonData
        } catch {
            print("Error decoding button data: \(error)")
        }
    } else {
        print("JSON file not found.")
    }
    return nil
}

// simple color string to color conversion
func colorFromString(_ colorString: String) -> Color {
    switch colorString.lowercased() {
    case "black":
        return Color.black
    case "white":
        return Color.white
    case "red":
        return Color.red
    case "orange":
        return Color.orange
    case "yellow":
        return Color.yellow
    case "green":
        return Color.green
    case "blue":
        return Color.blue
    case "purple":
        return Color.purple
    case "pink":
        return Color.pink
    case "gray":
        return Color.gray
    case "brown":
        return Color.brown
    case "cyan":
        return Color.cyan
    default:
        return Color.clear // Default to black if color string is unrecognized
    }
}

// helper function to sum up the buttons for a given row
func calculateCumulativeSum(array: [Int], upTo index: Int) -> Int {
    return array.prefix(index).reduce(0, +)
}

// helper function
func sendRequest(command: String, token: String) async -> String? {
    guard let url = URL(string: "https://statsnscore.online/scoreboard/controltoken/\(token)/\(command)") else {
        print("Invalid URL")
        return nil
    }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        print(data)
        let responseString = String(data: data, encoding: .utf8)
        return responseString
    } catch {
        print("Failed to fetch: \(error.localizedDescription)")
        return nil
    }
}

// main
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            SidebarView()
                .environment(\.colorScheme, .dark)
        }
    }
}
