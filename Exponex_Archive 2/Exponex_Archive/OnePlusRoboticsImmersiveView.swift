
import SwiftUI
import RealityKit

struct OnePlusRoboticsImmersiveView: View {
    var body: some View {
        VStack {
            Text("Immersive View")
                .font(.title)
                .padding()

            RealityView { content in
                let anchor = AnchorEntity(world: SIMD3<Float>(0, 0, 0))
                if let model = try? ModelEntity.load(named: "OnePlusRobotics") {
                    anchor.addChild(model)
                }
                content.add(anchor)
            }
            .frame(height: 400)
        }
    }
}
