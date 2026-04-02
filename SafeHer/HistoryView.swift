import SwiftUI

struct HistoryView: View {
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

                    // History card
                    VStack(spacing: 16) {
                        HStack {
                            Text("Location History")
                                .font(.headline)
                            Spacer()
                            Text("0 locations recorded")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }

                        VStack(spacing: 12) {
                            Image(systemName: "location.circle")
                                .font(.system(size: 48))
                                .foregroundColor(.gray.opacity(0.4))
                            Text("No location history yet")
                                .foregroundColor(.gray)
                            Text("Your location tracking history will appear here")
                                .font(.caption)
                                .foregroundColor(.gray.opacity(0.7))
                                .multilineTextAlignment(.center)
                        }
                        .padding(30)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.05), radius: 8)
                    .padding(.horizontal)

                    // About card
                    VStack(alignment: .leading, spacing: 8) {
                        Label("About Location History", systemImage: "mappin.circle.fill")
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex: "FF2D55"))
                        TipRow(text: "Location updates are stored locally on your device")
                        TipRow(text: "History is kept for your last 100 locations")
                        TipRow(text: "Data is not shared unless you send an SOS alert")
                        TipRow(text: "Clear history anytime for privacy")
                    }
                    .padding()
                    .background(Color(hex: "FFF0F3"))
                    .cornerRadius(16)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
                .padding(.top, 16)
            }
            .background(Color(hex: "F8F0FF"))
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    HistoryView()
}
