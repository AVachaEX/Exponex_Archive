import SwiftUI
import RealityKit

struct OnePlusRobotics3DModelView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showExitMenu: Bool = false
    @State private var modelEntity: AnchorEntity? // ✅ Store the loaded RealityKit model
    
    var body: some View {
        ZStack {
            // ✅ RealityKit Scene
            RealityView { content in
                if let modelEntity {
                    content.add(modelEntity) // ✅ Add model only if it's loaded
                }
            } update: { content in
                if let modelEntity {
                    content.add(modelEntity) // ✅ Ensure it updates properly
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .task {
                await loadRealityKitScene() // ✅ Load asynchronously
            }

            // ✅ Exit Menu (Appears when user interacts)
            if showExitMenu {
                VStack {
                    Button("Back") {
                        dismiss()
                    }
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                }
                .frame(width: 200, height: 100)
                .background(Color.black.opacity(0.6))
                .cornerRadius(20)
                .transition(.scale)
            }
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 20).onChanged { _ in
                showExitMenu.toggle()
            }
        ) // ✅ Fixes menu toggle
    }

    // MARK: - ✅ Load Reality Composer Pro Scene from RealityKitContent.rkassets
    private func loadRealityKitScene() async {
        do {
            // 🔍 Debugging: Print all files in the main bundle
            if let resourcePath = Bundle.main.resourcePath {
                let fileManager = FileManager.default
                let files = try? fileManager.contentsOfDirectory(atPath: resourcePath)
                print("📂 Available Files in Main Bundle: \(files ?? [])")
            }

            // ✅ Get the RealityKit content bundle
            guard let realityKitBundleURL = Bundle.main.url(forResource: "RealityKitContent_RealityKitContent", withExtension: "bundle"),
                  let realityKitBundle = Bundle(url: realityKitBundleURL) else {
                print("❌ ERROR: RealityKit content bundle not found")
                return
            }

            // 🔍 Debugging: Print files in the RealityKit bundle
            if let bundlePath = realityKitBundle.resourcePath {
                let fileManager = FileManager.default
                let files = try? fileManager.contentsOfDirectory(atPath: bundlePath)
                print("📂 Available Files in RealityKit Bundle: \(files ?? [])")
            }

            // ✅ Load the `.usda` scene from the RealityKit bundle
            let scene = try await ModelEntity.load(named: "OnePlusRobotics", in: realityKitBundle)

            // 🔥 Fix 1: Adjust Scale (Prevents Model Being Too Small or Large)
            scene.setScale(SIMD3<Float>(0.1, 0.1, 0.1), relativeTo: nil) // Adjust if needed

            // 🔥 Fix 2: Adjust Position (Ensures Model is in Front of Camera)
            scene.position = SIMD3<Float>(0, 0.3, -0.5) // Move it higher & forward

            // ✅ Attach it to an Anchor
            let anchor = AnchorEntity(.plane(.horizontal, classification: .table, minimumBounds: [0.2, 0.2]))
            anchor.addChild(scene)

            // 🔥 Fix 3: Add Lighting (Prevents Model from Being Too Dark)
            let light = DirectionalLight()
            light.light.color = .white
            light.light.intensity = 10_000 // Increase brightness
            let lightAnchor = AnchorEntity(world: [0, 1, -1]) // Light positioned above
            lightAnchor.addChild(light)
            anchor.addChild(lightAnchor)

            // ✅ Ensure UI updates happen on the main thread
            await MainActor.run {
                modelEntity = anchor
            }

            print("✅ Successfully loaded OnePlusRobotics.usda from RealityKit bundle")

        } catch {
            print("❌ ERROR loading Reality Composer Pro Scene: \(error)")
        }
    }

}

// MARK: - Preview
#Preview {
    OnePlusRobotics3DModelView()
}
