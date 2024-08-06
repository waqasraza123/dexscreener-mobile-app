import SwiftUI

struct SignUpView: View {
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var email: String = ""
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            // Your UI code
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
        }
        .padding()
    }
    
    func signUp() {
        // Validation code

        let endpoint = "/auth/register"
        guard let url = URL(string: Constants.apiUrl + endpoint) else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: String] = [
            "password": password,
            "email": email
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    DispatchQueue.main.async {
                        // Handle response
                        print(responseJSON)
                    }
                }
            }
        }.resume()
    }
}
