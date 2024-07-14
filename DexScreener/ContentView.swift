import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false

    var body: some View {
        Group {
            if isLoggedIn {
                TokensView()
            } else {
                loginView
            }
        }
    }

    var loginView: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                // Simulate login
                if username == "admin" && password == "admin" {
                    isLoggedIn = true
                } else {
                    // Handle invalid credentials
                    print("Invalid credentials")
                }
            }) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.blue)
                    .cornerRadius(15.0)
            }
        }
        .padding()
    }
}
