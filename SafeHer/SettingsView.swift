import SwiftUI

struct SettingsView: View {
    @State private var gpsRefreshRate: Double = 5
    @State private var accuracyThreshold: Double = 50
    @State private var autoSendLocation = false
    @State private var soundAlerts = true
    @State private var vibration = true
    @State private var shakeToSOS = true
    @State private var shakeSensitivity: Double = 2

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

                    // GPS Settings
                    SettingsCard(title: "GPS Settings", icon: "location.fill", color: Color(hex: "9B59B6")) {
                        VStack(spacing: 16) {
                            SliderSetting(
                                label: "GPS Refresh Rate: \(Int(gpsRefreshRate)) seconds",
                                value: $gpsRefreshRate,
                                range: 1...60,
                                leftLabel: "1s (High battery use)",
                                rightLabel: "60s (Low battery use)"
                            )
                            Divider()
                            SliderSetting(
                                label: "Location Accuracy Threshold: \(Int(accuracyThreshold))m",
                                value: $accuracyThreshold,
                                range: 10...200,
                                leftLabel: "10m (Strict)",
                                rightLabel: "200m (Lenient)"
                            )
                            Text("Accuracy below this threshold is considered \"Excellent\"")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }

                    // Auto Send Location
                    SettingsCard(title: "Auto-Send Location", icon: "arrow.clockwise.circle.fill", color: Color(hex: "9B59B6")) {
                        ToggleSetting(
                            label: "Enable Auto-Send",
                            subtitle: "Periodically send location to contacts",
                            isOn: $autoSendLocation
                        )
                    }

                    // Alert Preferences
                    SettingsCard(title: "Alert Preferences", icon: "bell.fill", color: Color(hex: "9B59B6")) {
                        VStack(spacing: 12) {
                            ToggleSetting(
                                label: "Sound Alerts",
                                subtitle: "Play sound when sending SOS",
                                isOn: $soundAlerts
                            )
                            Divider()
                            ToggleSetting(
                                label: "Vibration",
                                subtitle: "Vibrate when sending SOS",
                                isOn: $vibration
                            )
                        }
                    }

                    // Shake to SOS
                    SettingsCard(title: "Shake to SOS", icon: "iphone.radiowaves.left.and.right", color: Color(hex: "9B59B6")) {
                        VStack(spacing: 16) {
                            ToggleSetting(
                                label: "Enable Shake to SOS",
                                subtitle: "Shake phone to trigger SOS alert",
                                isOn: $shakeToSOS
                            )
                            if shakeToSOS {
                                Divider()
                                SliderSetting(
                                    label: "Shake Sensitivity: \(Int(shakeSensitivity))",
                                    value: $shakeSensitivity,
                                    range: 1...5,
                                    leftLabel: "Low",
                                    rightLabel: "High"
                                )
                            }
                        }
                    }

                    // App info
                    VStack(spacing: 4) {
                        Text("SafeHer v1.0")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("Your safety is our priority")
                            .font(.caption2)
                            .foregroundColor(.gray.opacity(0.6))
                    }
                    .padding(.bottom, 20)
                }
                .padding(.top, 16)
            }
            .background(Color(hex: "F8F0FF"))
        }
        .ignoresSafeArea(edges: .top)
    }
}

struct SettingsCard<Content: View>: View {
    let title: String
    let icon: String
    let color: Color
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(title, systemImage: icon)
                .fontWeight(.bold)
                .foregroundColor(color)
            content
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8)
        .padding(.horizontal)
    }
}

struct SliderSetting: View {
    let label: String
    @Binding var value: Double
    let range: ClosedRange<Double>
    let leftLabel: String
    let rightLabel: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.subheadline)
                .fontWeight(.medium)
            Slider(value: $value, in: range, step: 1)
                .accentColor(Color(hex: "FF2D55"))
            HStack {
                Text(leftLabel)
                    .font(.caption2)
                    .foregroundColor(.gray)
                Spacer()
                Text(rightLabel)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct ToggleSetting: View {
    let label: String
    let subtitle: String
    @Binding var isOn: Bool

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Toggle("", isOn: $isOn)
                .tint(Color(hex: "FF2D55"))
        }
    }
}

#Preview {
    SettingsView()
}
