import SwiftUI

@main
struct CryptoProApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @Environment(\.colorScheme) var scheme
    @State private var selectedTab = 0

    var body: some View {
        ZStack {
            background.ignoresSafeArea()

            VStack(spacing: 0) {
                currentView
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                TabBar(selectedTab: $selectedTab)
            }
        }
    }

    var currentView: some View {
        switch selectedTab {
        case 0: return AnyView(HomeView())
        case 1: return AnyView(MarketView())
        case 2: return AnyView(TradeView())
        case 3: return AnyView(WalletView())
        default: return AnyView(ProfileView())
        }
    }

    var background: LinearGradient {
        scheme == .dark
        ? LinearGradient(colors: [.black, .gray.opacity(0.3)], startPoint: .top, endPoint: .bottom)
        : LinearGradient(colors: [.white, .gray.opacity(0.1)], startPoint: .top, endPoint: .bottom)
    }
}

// MARK: - TAB BAR
struct TabBar: View {
    @Binding var selectedTab: Int

    var body: some View {
        HStack {
            tab(icon: "house.fill", index: 0)
            Spacer()
            tab(icon: "chart.line.uptrend.xyaxis", index: 1)
            Spacer()
            centerButton
            Spacer()
            tab(icon: "wallet.pass.fill", index: 3)
            Spacer()
            tab(icon: "person.fill", index: 4)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
        .padding()
    }

    func tab(icon: String, index: Int) -> some View {
        Button {
            selectedTab = index
        } label: {
            Image(systemName: icon)
                .foregroundColor(selectedTab == index ? .green : .gray)
                .font(.system(size: 20, weight: .semibold))
        }
    }

    var centerButton: some View {
        Button {
            selectedTab = 2
        } label: {
            ZStack {
                Circle()
                    .fill(LinearGradient(colors: [.green, .blue], startPoint: .top, endPoint: .bottom))
                    .frame(width: 55, height: 55)

                Image(systemName: "arrow.up.arrow.down")
                    .foregroundColor(.white)
            }
        }
    }
}

// MARK: - HOME
struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Portfolio")
                    .font(.largeTitle.bold())

                Text("$18,540.22")
                    .font(.title)
                    .foregroundColor(.green)

                CryptoCard(name: "Bitcoin", price: "$67,000", change: "+2%")
                CryptoCard(name: "Ethereum", price: "$3,500", change: "+1.2%")
            }
            .padding()
        }
    }
}

struct CryptoCard: View {
    let name: String
    let price: String
    let change: String

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name).bold()
                Text(price).foregroundColor(.gray)
            }
            Spacer()
            Text(change).foregroundColor(.green)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(12)
    }
}

// MARK: - MARKET
struct MarketView: View {
    var body: some View {
        List {
            Text("Bitcoin - $67,000")
            Text("Ethereum - $3,500")
            Text("BNB - $580")
        }
    }
}

// MARK: - TRADE
struct TradeView: View {
    @State private var amount = ""
    @State private var isBuy = true

    var body: some View {
        VStack(spacing: 20) {
            Picker("", selection: $isBuy) {
                Text("Buy").tag(true)
                Text("Sell").tag(false)
            }
            .pickerStyle(.segmented)

            TextField("Amount", text: $amount)
                .textFieldStyle(.roundedBorder)

            Button(isBuy ? "Buy" : "Sell") {}
                .padding()
                .frame(maxWidth: .infinity)
                .background(isBuy ? Color.green : Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)

            Spacer()
        }
        .padding()
    }
}

// MARK: - WALLET
struct WalletView: View {
    var body: some View {
        VStack {
            Text("Wallet")
                .font(.title)
            Spacer()
        }
        .padding()
    }
}

// MARK: - PROFILE
struct ProfileView: View {
    @State private var name = "Zamin"
    @State private var email = "zamin@mail.com"
    @State private var phone = "+994"
    @State private var notifications = true

    var body: some View {
        NavigationStack {
            Form {
                Section("User Info") {
                    TextField("Name", text: $name)
                    TextField("Email", text: $email)
                    TextField("Phone", text: $phone)
                }

                Section("Settings") {
                    Toggle("Notifications", isOn: $notifications)
                }

                Section {
                    Button("Save") {}
                }
            }
            .navigationTitle("Profile")
        }
    }
}
