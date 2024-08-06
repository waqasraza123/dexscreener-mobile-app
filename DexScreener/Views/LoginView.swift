import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    @State private var isLoading: Bool = false // State for showing loading spinner
    
    var body: some View {
        VStack() {
            if isLoading {
                // Show loading spinner when isLoading is true
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5, anchor: .center)
                    .padding()
            } else {
                // Header text
                Text("Login")
                    .font(.title.bold())
                    .foregroundColor(.black)
                    .padding(.bottom, 1)
                
                Text("Please sign in to continue.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 20)
                
                // Login form
                TextField("user123@email.com", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                SecureField("••••••••", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                Button(action: {
                    login()
                }) {
                    Text("LOGIN")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 150, alignment: .center)
                        .background(Color.orange)
                        .cornerRadius(15.0)
                }
                .padding(.top, 20) // Add padding to top to separate from fields
                
                NavigationLink(destination: SignUpView()) {
                    Text("Sign Up")
                        .foregroundColor(.orange)
                        .padding()
                }
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
        }
        .padding()
        .background(Color.white) // Background color for the view
    }
    
    func login() {
        let endpoint = "/auth/login"
        guard let url = URL(string: Constants.apiUrl + endpoint) else {
            errorMessage = "Invalid URL"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: String] = [
            "email": username,
            "password": password
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])

        // Set isLoading to true when the login starts
        isLoading = true

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                // Set isLoading to false when the login completes
                isLoading = false
            }

            if let error = error {
                DispatchQueue.main.async {
                    errorMessage = "Error: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    errorMessage = "No data received"
                }
                return
            }
            
            do {
                // Decode the response JSON
                let responseJSON = try JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any], let user = responseJSON["user"] as? [String: Any] {
                    // Handle successful login
                    DispatchQueue.main.async {
                        isLoggedIn = true
                        errorMessage = nil
                    }
                } else {
                    DispatchQueue.main.async {
                        errorMessage = "Invalid credentials"
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    errorMessage = "Error parsing response: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isLoggedIn: .constant(false))
    }
}
