import SwiftUI

struct SignUpView: View {
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var phoneNumber = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "FF2D55"), Color(hex: "9B59B6")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                VStack(spacing: 8) {
                    Spacer().frame(height: 50)
                    Text("SafeHer")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                    Text("Your Personal Safety Companion")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.85))
                    Spacer().frame(height: 30)
                }
                
                // White card
                ScrollView {
                    VStack(spacing: 20) {
                        Text("Create Account")
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("Sign up to get started")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Full name
                        InputField(
                            icon: "person.fill",
                            placeholder: "Enter your full name",
                            label: "Full Name",
                            text: $fullName
                        )
                        
                        // Phone
                        InputField(
                            icon: "phone.fill",
                            placeholder: "+91 XXXXX XXXXX",
                            label: "Phone Number",
                            text: $phoneNumber,
                            keyboardType: .phonePad
                        )
                        
                        // Email
                        InputField(
                            icon: "envelope.fill",
                            placeholder: "Enter your email",
                            label: "Email",
                            text: $email,
                            keyboardType: .emailAddress
                        )
                        
                        // Password
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Password")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                            HStack {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(.gray)
                                SecureField("Create a password", text: $password)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                        
                        // Confirm password
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Confirm Password")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                            HStack {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(.gray)
                                SecureField("Confirm your password", text: $confirmPassword)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                        
                        // Sign up button
                        Button {
                            dismiss()
                        } label: {
                            Text("Create Account")
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
                        
                        // Back to login
                        HStack {
                            Text("Already have an account?")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                            Button("Sign In") {
                                dismiss()
                            }
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex: "FF2D55"))
                        }
                    }
                    .padding(28)
                }
                .background(Color.white)
                .cornerRadius(30)
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
    }
}

struct InputField: View {
    let icon: String
    let placeholder: String
    let label: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.gray)
                TextField(placeholder, text: $text)
                    .keyboardType(keyboardType)
                    .autocapitalization(.none)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
    }
}

#Preview {
    SignUpView()
}
