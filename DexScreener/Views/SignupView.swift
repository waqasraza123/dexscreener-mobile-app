import SwiftUI


struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String?
    @State private var isSignUpSuccessful: Bool = false
    
    var body: some View {
        VStack {
            if isSignUpSuccessful {
                Text("Sign Up Successful!")
                    .foregroundColor(.green)
                    .padding()
            }

            VStack(alignment: .leading) {
                Text("Sign Up")
                    .font(.title.bold())
                    .foregroundColor(.black)
                    .padding(.bottom, 1)
                
                Text("Create an account to get started.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 20)
                
                TextField("Email", text: $email)
                    .textFieldStyle(CustomTextFieldStyle(height: 50, cornerRadius: 10, padding: 16))
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(CustomTextFieldStyle(height: 50, cornerRadius: 10, padding: 16))
                    .autocapitalization(.none)
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .textFieldStyle(CustomTextFieldStyle(height: 50, cornerRadius: 10, padding: 16))
                    .autocapitalization(.none)
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                Button(action: {
                    signUp()
                }) {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.blue)
                        .cornerRadius(15.0)
                }
                .padding(.top, 20)
                
                Spacer() // Pushes the Login button to the bottom
                
                NavigationLink(destination: LoginView(isLoggedIn: $isSignUpSuccessful)) {
                    Text("Login")
                        .foregroundColor(.blue)
                        .padding()
                }
                .padding(.bottom, 20) // Add padding to bottom for spacing
            }
            .padding()
        }
        .background(Color.white) // Background color for the view
    }
    
    func signUp() {
        // Validation
        if email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            errorMessage = "All fields are required."
            return
        }
        
        if password != confirmPassword {
            errorMessage = "Passwords do not match."
            return
        }
        
        let endpoint = "/auth/register"
        guard let url = URL(string: Constants.apiUrl + endpoint) else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    errorMessage = "Failed to sign up: \(error.localizedDescription)"
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    errorMessage = "No data received."
                }
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                DispatchQueue.main.async {
                    // Handle response
                    print(responseJSON)
                    isSignUpSuccessful = true
                }
            } else {
                DispatchQueue.main.async {
                    errorMessage = "Failed to parse response."
                }
            }
        }.resume()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
