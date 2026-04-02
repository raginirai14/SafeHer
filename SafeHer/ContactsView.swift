import SwiftUI

struct Contact: Identifiable {
    let id = UUID()
    var name: String
    var phone: String
    var email: String
    var relationship: String
}

struct ContactsView: View {
    @State private var contacts: [Contact] = []
    @State private var showAddContact = false
    @State private var name = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var relationship = "Family"
    let relationships = ["Family", "Friend", "Partner", "Colleague"]

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

                    // Add contact card
                    if showAddContact {
                        VStack(alignment: .leading, spacing: 14) {
                            HStack {
                                Text("Add New Contact")
                                    .font(.headline)
                                Spacer()
                                Button {
                                    showAddContact = false
                                } label: {
                                    Image(systemName: "xmark")
                                        .foregroundColor(.white)
                                        .padding(8)
                                        .background(Color.red)
                                        .cornerRadius(8)
                                }
                            }

                            InputField(icon: "person.fill", placeholder: "Enter name", label: "Name *", text: $name)
                            InputField(icon: "phone.fill", placeholder: "+1 234 567 8900", label: "Phone Number *", text: $phone, keyboardType: .phonePad)
                            InputField(icon: "envelope.fill", placeholder: "email@example.com", label: "Email (Optional)", text: $email, keyboardType: .emailAddress)

                            VStack(alignment: .leading, spacing: 6) {
                                Text("Relationship *")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                Picker("Relationship", selection: $relationship) {
                                    ForEach(relationships, id: \.self) { r in
                                        Text(r).tag(r)
                                    }
                                }
                                .pickerStyle(.menu)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            }

                            HStack(spacing: 12) {
                                Button {
                                    if !name.isEmpty && !phone.isEmpty {
                                        contacts.append(Contact(name: name, phone: phone, email: email, relationship: relationship))
                                        name = ""; phone = ""; email = ""
                                        showAddContact = false
                                    }
                                } label: {
                                    Label("Add Contact", systemImage: "checkmark")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color(hex: "FF2D55"))
                                        .cornerRadius(12)
                                }

                                Button {
                                    showAddContact = false
                                } label: {
                                    Text("Cancel")
                                        .fontWeight(.bold)
                                        .foregroundColor(.gray)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color(.systemGray5))
                                        .cornerRadius(12)
                                }
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.05), radius: 8)
                        .padding(.horizontal)
                    }

                    // Contacts list
                    VStack(spacing: 0) {
                        HStack {
                            Text("Emergency Contacts")
                                .font(.headline)
                            Spacer()
                            Button {
                                showAddContact = true
                            } label: {
                                Image(systemName: "person.badge.plus")
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color(hex: "FF2D55"))
                                    .cornerRadius(10)
                            }
                        }
                        .padding()

                        if contacts.isEmpty {
                            VStack(spacing: 12) {
                                Image(systemName: "person.badge.plus")
                                    .font(.system(size: 48))
                                    .foregroundColor(.gray.opacity(0.4))
                                Text("No emergency contacts added yet")
                                    .foregroundColor(.gray)
                                Text("Add your first contact to get started")
                                    .font(.caption)
                                    .foregroundColor(.gray.opacity(0.7))
                            }
                            .padding(40)
                        } else {
                            ForEach(contacts) { contact in
                                HStack(spacing: 12) {
                                    Circle()
                                        .fill(Color(hex: "FF2D55").opacity(0.15))
                                        .frame(width: 44, height: 44)
                                        .overlay(
                                            Text(String(contact.name.prefix(1)))
                                                .fontWeight(.bold)
                                                .foregroundColor(Color(hex: "FF2D55"))
                                        )
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(contact.name)
                                            .fontWeight(.semibold)
                                        Text(contact.phone)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        Text(contact.relationship)
                                            .font(.caption2)
                                            .foregroundColor(Color(hex: "9B59B6"))
                                    }
                                    Spacer()
                                    Button {
                                        contacts.removeAll { $0.id == contact.id }
                                    } label: {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                Divider().padding(.leading, 68)
                            }
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.05), radius: 8)
                    .padding(.horizontal)

                    // Tips card
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Tips", systemImage: "lightbulb.fill")
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex: "9B59B6"))
                        TipRow(text: "Add at least 2-3 trusted contacts")
                        TipRow(text: "Include both phone and email for reliability")
                        TipRow(text: "Inform your contacts that they're on your emergency list")
                        TipRow(text: "Keep contact information up to date")
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
    }
}

struct TipRow: View {
    let text: String
    var body: some View {
        HStack(alignment: .top, spacing: 6) {
            Text("•")
                .foregroundColor(Color(hex: "9B59B6"))
            Text(text)
                .font(.caption)
                .foregroundColor(Color(hex: "3D1A6E"))
        }
    }
}

#Preview {
    ContactsView()
}
