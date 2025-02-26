import SwiftUI

struct OnePlusRoboticsView: View {
    @State private var selectedTab: Int = 0

    let scaleFactor: CGFloat = 1.0
    let buttonWidth: CGFloat = 200 // Consistent width for buttons

    var body: some View {
        VStack {
            // Scrollable Image Carousel
            ScrollView(.horizontal, showsIndicators: true) {
                HStack(spacing: 40 * scaleFactor) {
                    ForEach(1..<7, id: \.self) { index in
                        VStack(spacing: 10 * scaleFactor) {
                            Image("OnePlus\(index)")
                                .resizable()
                                .clipShape(RoundedRectangle(cornerRadius: 15 * scaleFactor))
                                .frame(width: 1000 * scaleFactor, height: 600 * scaleFactor)
                        }
                        .padding(.vertical, 20 * scaleFactor)
                        .padding(.horizontal, 20 * scaleFactor)
                        .cornerRadius(15 * scaleFactor)
                    }
                }
                .padding()
            }

            // Centered and Equal-Sized Buttons
            HStack(spacing: 20) {
                Spacer() // To center the buttons

                NavigationLink(destination: OnePlusRobotics3DModelView()) {
                    Text("3D Model")
                        .frame(width: buttonWidth, height: 50)
                        .background(.ultraThinMaterial)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                NavigationLink(destination: OnePlusRoboticsImmersiveViewUnique()) {
                    Text("Immersive View")
                        .frame(width: buttonWidth, height: 50)
                        .background(.ultraThinMaterial)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Spacer() // To center the buttons
            }
            .padding(.top, 20)
        }
        .navigationTitle("One Plus Robotics")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Utility Function
    func getImageTitle(for index: Int) -> String {
        switch index {
        case 1: return "One Plus Robotics"
        case 2: return "Titan Cloud"
        case 3: return "Supersonic"
        default: return "Unknown"
        }
    }
}

// MARK: - Placeholder Views for Navigation
struct OnePlusRobotics3DModelViewUnique: View {
    var body: some View {
        Text("3D Model View")
            .font(.largeTitle)
    }
}

struct OnePlusRoboticsImmersiveViewUnique: View {
    var body: some View {
        Text("Immersive View")
            .font(.largeTitle)
    }
}

// MARK: - Preview
#Preview {
    OnePlusRoboticsView()
}





/*
import SwiftUI

struct OnePlusRoboticsView: View {
    @State private var show3DModel: Bool = false
    @State private var showImmersiveView: Bool = false

    var body: some View {
        VStack {
            

            ScrollView(.horizontal, showsIndicators: true) {
                HStack {
                    ForEach(1..<4) { index in
                        Image("image\(index)")
                            .resizable()
                            .frame(width: 1000, height: 600)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            .padding()

            HStack {
                Button("3D Model") {
                    show3DModel = true
                }
                .padding()
                .background(.ultraThinMaterial)
                .foregroundColor(.white)
                .cornerRadius(8)

                Button("Immersive View") {
                    showImmersiveView = true
                }
                .padding()
                .background(.ultraThinMaterial)
                .foregroundColor(.white)
                .cornerRadius(8)
            }

            NavigationLink("", destination: OnePlusRobotics3DModelView(), isActive: $show3DModel)
            NavigationLink("", destination: OnePlusRoboticsImmersiveView(), isActive: $showImmersiveView)
        }
    }
}
 */
