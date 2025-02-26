import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State private var activeRow: Int = 0
    @State private var showOnePlusRobotics: Bool = false
    @State private var isSidebarExpanded: Bool = false
    @State private var selectedTab: Int = 0

    @Environment(\.openWindow) private var openWindow
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    let aspectRatio: CGFloat = 16.0 / 9.0

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                let minDimension = min(geometry.size.width, geometry.size.height / aspectRatio)
                let scaleFactor = minDimension / 1280

                ZStack {
                    Color.clear
                        .background(.ultraThinMaterial)
                        .ignoresSafeArea()
                        .cornerRadius(15)

                    VStack(spacing: 50 * scaleFactor) {
                        HStack {
                            Image("Ex-Group")
                                .resizable()
                                .frame(width: 200 * scaleFactor, height: 160 * scaleFactor)
                                .padding(20 * scaleFactor)

                            Spacer()

                            Text("EXPONEX ARCHIVE")
                                .font(.system(size: 80 * scaleFactor))
                                .foregroundColor(.white)

                            Spacer()

                            Button(action: {
                                shareContent()
                            }) {
                                Image(systemName: "square.and.arrow.up")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 50 * scaleFactor, height: 50 * scaleFactor)
                            }
                        }
                        .padding(.horizontal, 40 * scaleFactor)
                        .padding(.top, 20 * scaleFactor)
                        .background(.ultraThinMaterial)
                        .zIndex(1)

                        ScrollView {
                            VStack(alignment: .center, spacing: 40 * scaleFactor) {
                                if selectedTab == 0 {
                                    ForEach(0..<2, id: \.self) { _ in
                                        HStack(spacing: 40 * scaleFactor) {
                                            ForEach(1..<4, id: \.self) { index in
                                                Button(action: {
                                                    if index == 1 {
                                                        showOnePlusRobotics = true
                                                    } else {
                                                        print("image\(index) tapped")
                                                    }
                                                }) {
                                                    VStack(spacing: 10 * scaleFactor) {
                                                        Image("image\(index)")
                                                            .resizable()
                                                            .clipShape(RoundedRectangle(cornerRadius: 15 * scaleFactor))
                                                            .frame(width: 1200 * scaleFactor, height: 800 * scaleFactor)
                                                        Text(getImageTitle(for: index))
                                                            .font(.system(size: 50 * scaleFactor))
                                                            .foregroundColor(.white)
                                                    }
                                                    .padding(.vertical, 20 * scaleFactor)
                                                    .padding(.horizontal, 20 * scaleFactor)
                                                    .cornerRadius(15 * scaleFactor)
                                                }
                                                .buttonBorderShape(.roundedRectangle(radius: 25 * scaleFactor))
                                            }
                                        }
                                    }
                                } else if selectedTab == 1 {
                                    Text("Titan Cloud Panel")
                                        .font(.system(size: 60 * scaleFactor))
                                        .foregroundColor(.white)
                                } else if selectedTab == 2 {
                                    Text("Supersonic Panel")
                                        .font(.system(size: 60 * scaleFactor))
                                        .foregroundColor(.white)
                                } else {
                                    Text("Another Panel")
                                        .font(.system(size: 60 * scaleFactor))
                                        .foregroundColor(.white)
                                }
                            }
                            .padding()
                        }
                    }

                    // Sidebar (Tab Bar)
                    VStack {
                        Spacer()

                        VStack(alignment: .leading, spacing: 16 * scaleFactor) {
                            ForEach(0..<4, id: \.self) { index in
                                Button(action: {
                                    selectedTab = index
                                }) {
                                    HStack {
                                        Image(systemName: getIcon(for: index))
                                            .resizable()
                                            .frame(width: 40 * scaleFactor, height: 40 * scaleFactor)
                                            .foregroundColor(selectedTab == index ? .blue : .white)

                                        if isSidebarExpanded {
                                            Text(getLabel(for: index))
                                                .foregroundColor(.white)
                                                .font(.system(size: 20 * scaleFactor))
                                                .transition(.move(edge: .leading))
                                        }
                                    }
                                    .padding(.vertical, 8 * scaleFactor)
                                    .padding(.horizontal, isSidebarExpanded ? 12 * scaleFactor : 8 * scaleFactor)
                                    .background(selectedTab == index ? Color.blue.opacity(0.2) : Color.white.opacity(0.1))
                                    .cornerRadius(12 * scaleFactor)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(16 * scaleFactor)
                        .frame(width: isSidebarExpanded ? 200 * scaleFactor : 60 * scaleFactor)
                        .onHover { hovering in
                            withAnimation(.easeInOut(duration: 0.2)) {
                                isSidebarExpanded = hovering
                            }
                        }

                        Spacer()
                    }
                    .offset(x: -geometry.size.width * 0.46)
                    .ignoresSafeArea()
                    .zIndex(2)
                }
                .frame(width: geometry.size.width, height: geometry.size.width / aspectRatio)
                .aspectRatio(aspectRatio, contentMode: .fit)
                .navigationDestination(isPresented: $showOnePlusRobotics) {
                    OnePlusRoboticsView()
                }
            }
        }
    }

    // MARK: - Utility Functions
    func getImageTitle(for index: Int) -> String {
        switch index {
        case 1: return "One Plus Robotics"
        case 2: return "Titan Cloud"
        case 3: return "Supersonic"
        default: return "Unknown"
        }
    }

    func getIcon(for index: Int) -> String {
        switch index {
        case 0: return "square.on.square"
        case 1: return "cloud"
        case 2: return "airplane"
        case 3: return "ellipsis"
        default: return "questionmark"
        }
    }

    func getLabel(for index: Int) -> String {
        switch index {
        case 0: return "Home"
        case 1: return "Titan Cloud"
        case 2: return "Supersonic"
        case 3: return "More"
        default: return "Unknown"
        }
    }

    func shareContent() {
        print("Share button tapped")
    }

    func openSpace(id: String) async {
        await dismissImmersiveSpace()

        switch await openImmersiveSpace(id: id) {
        case .opened:
            print("Immersive space \(id) successfully opened")
        case .error:
            fatalError("Error opening immersive space with id: \(id)")
        case .userCancelled:
            print("User cancelled")
        default:
            break
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
