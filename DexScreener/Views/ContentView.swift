import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn: Bool = false

    var body: some View {
        NavigationStack {
            Group {
                if isLoggedIn {
                    HomeView()
                } else {
                    LoginView(isLoggedIn: $isLoggedIn)
                }
            }
            .navigationDestination(for: GeckoToken.self) { crypto in
                OHLCChartView(tokenId: crypto.id)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
