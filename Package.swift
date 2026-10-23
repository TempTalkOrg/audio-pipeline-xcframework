// swift-tools-version:5.7
// (Xcode14.0+)

import PackageDescription

let package = Package(
    name: "AudioPipelineProcessor",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "AudioPipelineProcessor",
            targets: ["AudioPipelineProcessor"]
        ),
        .library(
            name: "DenoisePluginFilter",
            targets: ["AudioPipelineProcessor"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/TempTalkOrg/client-sdk-swift-xcframework", from: "2.15.2-a12"),
    ],
    targets: [
        .binaryTarget(
            name: "AudioPipeline",
            // path: "libs_audio_pipeline/AudioPipeline.xcframework"

            // for remote release:
            url: "https://github.com/TempTalkOrg/audio-pipeline-xcframework/releases/download/1.0.19/AudioPipeline.xcframework.zip",
            checksum: "246e53dcc24395bf96bd59195db972a5902fad1b4794294cbd750ef6d46f40f5"
        ),
        .target(
            name: "AudioPipelineProcessor",
            dependencies: [
                .product(name: "LiveKit", package: "client-sdk-swift-xcframework"),
                "AudioPipeline",
            ],
            path: "Sources/AudioPipelineProcessor"
        ),
    ]
)
