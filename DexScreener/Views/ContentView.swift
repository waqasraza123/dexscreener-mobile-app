import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn: Bool = false

    var body: some View {
        NavigationStack {
            Group {
                if isLoggedIn {
                    HomeView()
                        .navigationDestination(for: GeckoToken.self) { crypto in
                            OHLCChartView(tokenId: crypto.id)
                        }
                } else {
                    LoginView(isLoggedIn: $isLoggedIn)
                }
            }
            .onChange(of: isLoggedIn) { newValue in
                // Optional: Handle state changes or additional logic
                print("Login state changed to: \(newValue)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
