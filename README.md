# AudioPipeline

Noise suppression and voice changing for [LiveKit](https://github.com/livekit/client-sdk-swift) on iOS, as a Swift package.
Audio is processed at 48 kHz mono:

- **RNNoise**: lightweight denoising.
- **DeepFilterNet**: model-based denoising.
- **SoundTouch**: pitch shifting for the voice changer.

The native code ships as `AudioPipeline.xcframework` (a GitHub Release asset). The Swift sources wrap it:

- `AudioPipelineProcessor`: a LiveKit `AudioCustomProcessingDelegate` for live calls.
- `OfflineAudioPipeline`: processes recorded buffers outside a call.

## Requirements

- iOS 15+
- Xcode 14+ (Swift 5.7), or Xcode 15+ for `Package@swift-5.9.swift`
- The LiveKit xcframework package, which this package pulls in

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/TempTalkOrg/audio-pipeline-xcframework", from: "1.0.18"),
],
targets: [
    .target(name: "App", dependencies: [
        .product(name: "AudioPipelineProcessor", package: "audio-pipeline-xcframework"),
    ]),
]
```

`DenoisePluginFilter` is kept as an alias of `AudioPipelineProcessor` for older integrations.

## Usage

During a call, install the processor as LiveKit's capture post-processing delegate:

```swift
import AudioPipelineProcessor
import LiveKit

let processor = AudioPipelineProcessor(initialModule: .rnnoise)
AudioManager.shared.capturePostProcessingDelegate = processor

processor.activeModule = .deepfilternet  // switch backends at runtime
processor.setDenoiseEnabled(false)       // bypass denoising
```

Outside a call:

```swift
let pipeline = OfflineAudioPipeline(initialModule: .rnnoise)
let output = pipeline.process(samples)   // [Float], 48 kHz mono
pipeline.release()
```

## License

Apache License 2.0, see [LICENSE](LICENSE).
