//
//  LoginView.swift
//  DexScreener
//
//  Created by waqas on 06/08/2024.
//
import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State private var username: String = ""
    @State private var password: String = ""

    var body: some View {
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isLoggedIn: .constant(false))
    }
}
