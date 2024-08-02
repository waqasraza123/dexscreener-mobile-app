import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Please choose!")
                    .font(.title3)
                    .fontWeight(.regular)
                    .padding()
                
                NavigationLink(destination: Top100CryptocurrenciesView()) {
                    VStack {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.blue)
                        Text("View Charts (CoinGecko)")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                }
                .padding(.horizontal)
                
                NavigationLink(destination: TokensView()) {
                    VStack {
                        Image(systemName: "list.bullet")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.green)
                        Text("View List (DexScreener)")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationBarTitle("Home", displayMode: .inline)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
