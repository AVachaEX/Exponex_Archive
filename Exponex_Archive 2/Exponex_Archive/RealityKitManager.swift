//
//  Untitled.swift
//  Exponex_Archive
//
//  Created by Adam Vácha on 26.02.2025.
//
import RealityKit

class RealityKitManager {
    static let shared = RealityKitManager()

    func loadRealityKitScene() async -> AnchorEntity? {
        do {
            let scene = try await Entity.load(named: "RealityKitContent")
            let anchor = AnchorEntity(world: SIMD3<Float>(0, 0, -1))
            anchor.addChild(scene)
            return anchor
        } catch {
            print("❌ ERROR loading Reality Composer Pro Scene: \(error)")
            return nil
        }
    }
}

