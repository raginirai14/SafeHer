import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var showSignUp = false
    
    var body: some View {
        if isLoggedIn {
            ContentView()
        } else {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [Color(hex: "FF2D55"), Color(hex: "9B59B6")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Top header
                    VStack(spacing: 8) {
                        Spacer().frame(height: 60)
                        Text("SafeHer")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.white)
                        Text("Your Personal Safety Companion")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.85))
                        Spacer().frame(height: 40)
                    }
                    
                    // White card
                    VStack(spacing: 20) {
                        Text("Welcome Back")
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("Sign in to your account")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Email field
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Email")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                            HStack {
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(.gray)
                                TextField("Enter your email", text: $email)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                        
                        // Password field
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Password")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                            HStack {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(.gray)
                                SecureField("Enter your password", text: $password)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                        
                        // Login button
                        Button {
                            isLoggedIn = true
                        } label: {
                            Text("Sign In")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    LinearGradient(
                                        colors: [Color(hex: "FF2D55"), Color(hex: "9B59B6")],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(14)
                        }
                        
                        // Sign up link
                        HStack {
                            Text("Don't have an account?")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                            Button("Sign Up") {
                                showSignUp = true
                            }
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex: "FF2D55"))
                        }
                    }
                    .padding(28)
                    .background(Color.white)
                    .cornerRadius(30)
                    .padding(.horizontal, 20)
                    
                    Spacer()
                }
            }
            .sheet(isPresented: $showSignUp) {
                SignUpView()
            }
        }
    }
}

// Color hex extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
    }
}

#Preview {
    LoginView()
}
