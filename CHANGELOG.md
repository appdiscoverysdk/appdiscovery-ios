# Changelog

## 1.0.0

- First public release.
- `try AppDiscovery.create(host:appId:sdkKey:playerId:trackerHost:)` returns an `Offerwall`; the offerwall host is a required setting, there is no default.
- `Offerwall.launch(viewController:)`, `onReward` / `onClose` callbacks, `tags` and `options`.
- `Offerwall.syncPendingRewards` and `AppDiscovery.syncPendingRewards` for rewards earned while the app was closed.
- iOS 13+, device and simulator (arm64, x86_64 simulator).
