# Android arm64 Vulkan artifact

This artifact is pinned to a llama.cpp release tag and built for Android arm64/Termux with Vulkan enabled.

Build intent:

- `GGML_VULKAN=ON`
- `LLAMA_BUILD_TOOLS=ON`
- `LLAMA_BUILD_SERVER=ON`
- `LLAMA_BUILD_COMMON=ON`
- MTP support from upstream PR `ggml-org/llama.cpp#22673`
- Runtime support for `--spec-type draft-mtp`, `--tools`, and `--agent`

The Android Vulkan driver is not bundled. The binaries use Android's system Vulkan loader at `/system/lib64/libvulkan.so`, which then loads the device vendor Mali stack.

Launcher templates:

- `start-stable.sh`: conservative profile for agentic work and device-loss isolation.
- `start-fast.sh`: faster profile that re-enables q8 KV, Flash Attention auto, and prompt cache.
- `start-mtp.sh`: conservative MTP profile using `--spec-type draft-mtp --spec-draft-n-max 2`.
- `bench-gemma4.sh`: simple `llama-bench` run for Gemma 4 GGUF comparison.
