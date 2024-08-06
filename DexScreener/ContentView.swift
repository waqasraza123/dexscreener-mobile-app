import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false

    var body: some View {
        NavigationStack {
            Group {
                if isLoggedIn {
                    HomeView()
                } else {
                    loginView
                }
            }
        }
    }

    var loginView: some View {
        VStack {
            // Logo Image
            Image(systemName: "star.fill") // Replace with your logo image
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()

            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                // Simulate login
                if username.lowercased() == "admin" && password == "admin" {
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
            
            NavigationLink(destination: SignUpView()) {
                Text("Sign Up")
                    .foregroundColor(.blue)
                    .padding()
            }
        }
        .padding()
    }
}
