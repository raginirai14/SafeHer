import SwiftUI
import CoreLocation

struct HomeView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var isSOSPressed = false
    @State private var showSOSAlert = false
    @State private var holdProgress: CGFloat = 0
    @State private var sosTimer: Timer? = nil

    // ⚠️ REPLACE THESE WITH REAL NUMBERS
    // Format: country code + number (no + or spaces)
    // India example: "919876543210" means +91 98765 43210
    let trustedContacts = [
        "919946087763",
        "918529208232",
    ]

    var body: some View {
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

                    // Status cards
                    HStack(spacing: 12) {
                        StatusCard(
                            icon: "person.2.fill",
                            title: "Contacts",
                            value: "\(trustedContacts.count)",
                            subtitle: "Emergency contacts",
                            color: Color(hex: "9B59B6")
                        )
                        StatusCard(
                            icon: "waveform.path.ecg",
                            title: "GPS Status",
                            value: locationManager.locationReady ? "Ready" : "...",
                            subtitle: locationManager.statusText,
                            color: Color(hex: "9B59B6")
                        )
                    }
                    .padding(.horizontal)

                    // SOS card
                    VStack(spacing: 16) {
                        Text("Emergency SOS")
                            .font(.title3)
                            .fontWeight(.bold)

                        Text("Hold 3 seconds to send WhatsApp alert")
                            .font(.caption)
                            .foregroundColor(.gray)

                        // SOS Button
                        ZStack {
                            Circle()
                                .fill(Color.red.opacity(0.15))
                                .frame(width: 200, height: 200)

                            Circle()
                                .trim(from: 0, to: holdProgress)
                                .stroke(Color.red, lineWidth: 6)
                                .frame(width: 190, height: 190)
                                .rotationEffect(.degrees(-90))
                                .animation(.linear(duration: 0.1), value: holdProgress)

                            Circle()
                                .fill(Color.red)
                                .frame(width: 160, height: 160)
                                .overlay(
                                    VStack(spacing: 4) {
                                        Image(systemName: "exclamationmark.circle")
                                            .font(.system(size: 28))
                                            .foregroundColor(.white)
                                        Text("SOS")
                                            .font(.system(size: 28, weight: .bold))
                                            .foregroundColor(.white)
                                    }
                                )
                                .scaleEffect(isSOSPressed ? 0.93 : 1.0)
                                .animation(.easeInOut(duration: 0.1), value: isSOSPressed)
                        }
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { _ in
                                    if !isSOSPressed {
                                        isSOSPressed = true
                                        startHoldTimer()
                                    }
                                }
                                .onEnded { _ in
                                    isSOSPressed = false
                                    cancelHoldTimer()
                                }
                        )

                        if locationManager.locationReady {
                            Text("📍 \(String(format: "%.4f", locationManager.latitude)), \(String(format: "%.4f", locationManager.longitude))")
                                .font(.caption)
                                .foregroundColor(.green)
                        } else {
                            Text("⚠️ Getting your location...")
                                .font(.caption)
                                .foregroundColor(.orange)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.05), radius: 8)
                    .padding(.horizontal)

                    // Quick buttons
                    HStack(spacing: 12) {
                        QuickButton(
                            icon: "person.2.fill",
                            label: "Manage Contacts",
                            color: Color(hex: "9B59B6")
                        )
                        QuickButton(
                            icon: "phone.fill",
                            label: "Fake Call",
                            color: Color(hex: "3498DB")
                        )
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
                .padding(.top, 16)
            }
            .background(Color(hex: "F8F0FF"))
        }
        .ignoresSafeArea(edges: .top)
        .alert("🚨 Opening WhatsApp!", isPresented: $showSOSAlert) {
            Button("OK") { }
        } message: {
            Text("WhatsApp is opening for each contact. Just tap the Send button!")
        }
    }

    func startHoldTimer() {
        holdProgress = 0
        var elapsed: CGFloat = 0
        sosTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            elapsed += 0.1
            holdProgress = elapsed / 3.0
            if elapsed >= 3.0 {
                timer.invalidate()
                isSOSPressed = false
                holdProgress = 0
                sendSOSViaWhatsApp()
            }
        }
    }

    func cancelHoldTimer() {
        sosTimer?.invalidate()
        sosTimer = nil
        withAnimation { holdProgress = 0 }
    }

    func sendSOSViaWhatsApp() {
        let message = locationManager.whatsappMessage
        guard let encoded = message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }

        for (index, contact) in trustedContacts.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 2.0) {
                let urlString = "whatsapp://send?phone=\(contact)&text=\(encoded)"
                if let url = URL(string: urlString) {
                    UIApplication.shared.open(url)
                }
            }
        }
        showSOSAlert = true
    }
}
struct StatusCard: View {
    let icon: String
    let title: String
    let value: String
    let subtitle: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.caption)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
            Text(subtitle)
                .font(.caption2)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.04), radius: 6)
    }
}

struct QuickButton: View {
    let icon: String
    let label: String
    let color: Color

    var body: some View {
        Button {} label: {
            HStack {
                Image(systemName: icon)
                Text(label)
                    .fontWeight(.semibold)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .cornerRadius(14)
        }
    }
}
#Preview {
    HomeView()
}
