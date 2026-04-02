import SwiftUI

struct FakeCallView: View {
    @State private var callerName = "Mom"
    @State private var delay: Double = 5
    @State private var avatarURL = ""
    @State private var showIncomingCall = false
    @State private var countdown = 0
    @State private var timer: Timer? = nil

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Header
                ZStack {
                    LinearGradient(
                        colors: [Color(hex: "FF2D55"), Color(hex: "9B59B6")],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    VStack(spacing: 4) {
                        Spacer().frame(height: 50)
                        Text("SafeHer")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                        Text("Your Personal Safety Companion")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.85))
                        Spacer().frame(height: 16)
                    }
                }
                .frame(height: 110)

                ScrollView {
                    VStack(spacing: 16) {

                        // Setup card
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Fake Call")
                                .font(.title3)
                                .fontWeight(.bold)
                            Text("Receive a fake call to escape uncomfortable situations")
                                .font(.caption)
                                .foregroundColor(.gray)

                            InputField(icon: "person.fill", placeholder: "Mom", label: "Caller Name", text: $callerName)

                            VStack(alignment: .leading, spacing: 6) {
                                Text("Delay Before Call: \(Int(delay)) seconds")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                Slider(value: $delay, in: 1...60, step: 1)
                                    .accentColor(Color(hex: "FF2D55"))
                                HStack {
                                    Text("Instant")
                                        .font(.caption2)
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Text("60 seconds")
                                        .font(.caption2)
                                        .foregroundColor(.gray)
                                }
                            }

                            InputField(icon: "photo", placeholder: "https://example.com/image.jpg", label: "Caller Avatar URL (Optional)", text: $avatarURL)

                            Button {
                                startFakeCall()
                            } label: {
                                Label("Start Fake Call (in \(Int(delay))s)", systemImage: "phone.fill")
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
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.05), radius: 8)
                        .padding(.horizontal)

                        // How to use card
                        VStack(alignment: .leading, spacing: 8) {
                            Label("How to Use", systemImage: "lightbulb.fill")
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "9B59B6"))
                            TipRow(text: "Set a delay to give yourself time to prepare")
                            TipRow(text: "Your phone will vibrate and simulate an incoming call")
                            TipRow(text: "Answer the call and pretend to have a conversation")
                            TipRow(text: "Use this to safely exit uncomfortable situations")
                        }
                        .padding()
                        .background(Color(hex: "F0E6FF"))
                        .cornerRadius(16)
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    }
                    .padding(.top, 16)
                }
                .background(Color(hex: "F8F0FF"))
            }
            .ignoresSafeArea(edges: .top)

            // Incoming call overlay
            if showIncomingCall {
                IncomingCallView(callerName: callerName) {
                    showIncomingCall = false
                }
            }
        }
    }

    func startFakeCall() {
        countdown = Int(delay)
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { t in
            countdown -= 1
            if countdown <= 0 {
                t.invalidate()
                showIncomingCall = true
            }
        }
    }
}

struct IncomingCallView: View {
    let callerName: String
    let onDismiss: () -> Void
    @State private var callAnswered = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "1a1a2e"), Color(hex: "16213e")],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 30) {
                Spacer()

                // Caller info
                VStack(spacing: 16) {
                    Circle()
                        .fill(Color(hex: "FF2D55").opacity(0.3))
                        .frame(width: 100, height: 100)
                        .overlay(
                            Text(String(callerName.prefix(1)))
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.white)
                        )

                    Text(callerName)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)

                    Text(callAnswered ? "Connected" : "Incoming Call...")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }

                Spacer()

                if callAnswered {
                    VStack(spacing: 12) {
                        Text("Say something like:")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.6))
                        Text("\"Oh hi! Yes I'm coming now...\"")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(12)
                    }
                    .padding()

                    Button {
                        onDismiss()
                    } label: {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 70, height: 70)
                            .overlay(
                                Image(systemName: "phone.down.fill")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            )
                    }
                    .padding(.bottom, 60)
                } else {
                    // Answer / Decline buttons
                    HStack(spacing: 60) {
                        VStack(spacing: 8) {
                            Button {
                                onDismiss()
                            } label: {
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 70, height: 70)
                                    .overlay(
                                        Image(systemName: "phone.down.fill")
                                            .font(.title2)
                                            .foregroundColor(.white)
                                    )
                            }
                            Text("Decline")
                                .font(.caption)
                                .foregroundColor(.white)
                        }

                        VStack(spacing: 8) {
                            Button {
                                callAnswered = true
                            } label: {
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 70, height: 70)
                                    .overlay(
                                        Image(systemName: "phone.fill")
                                            .font(.title2)
                                            .foregroundColor(.white)
                                    )
                            }
                            Text("Answer")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.bottom, 60)
                }
            }
        }
    }
}

#Preview {
    FakeCallView()
}
