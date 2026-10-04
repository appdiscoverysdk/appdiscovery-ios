# AppDiscovery SDK for iOS

A lightweight iOS SDK that adds an offerwall to your app. Your users earn rewards by completing offers, and your app is notified through simple callbacks.

The SDK is configured with the host of your own offerwall (given to you by the network you publish for). There is no default host.

## Requirements

| Requirement | Version |
|---|---|
| iOS deployment target | 13.0+ |
| Swift | 5.7+ |
| Xcode | 14.0+ |
| Architectures | arm64 (device), arm64 and x86_64 (simulator) |

## Installation (Swift Package Manager)

In Xcode choose **File > Add Package Dependencies...** and enter:

```
https://github.com/appdiscoverysdk/appdiscovery-ios
```

Set the rule to **Up to Next Major Version** from `1.0.0`, and add the `AppDiscoverySDK` product to your app target.

With a `Package.swift`:

```swift
.package(url: "https://github.com/appdiscoverysdk/appdiscovery-ios", from: "1.0.0")
```

## Quick start

```swift
import UIKit
import AppDiscoverySDK

class ViewController: UIViewController {

    private func showOfferwall() {
        do {
            let offerwall = try AppDiscovery.create(
                host: "offers.example.com",   // Host of your offerwall (required)
                appId: "YOUR_APP_ID",
                sdkKey: "YOUR_SDK_KEY",
                playerId: "player_123"        // Unique id of the player in your app
            )

            offerwall.onReward = { reward in
                print("Reward:", reward["amount"] ?? "", "transaction:", reward["txid"] ?? "")
            }
            offerwall.onClose = {
                print("Offerwall closed")
            }

            offerwall.launch(viewController: self)
        } catch {
            print("AppDiscovery setup failed:", error.localizedDescription)
        }
    }
}
```

## API

### AppDiscovery

| Method | Parameters | Description |
|---|---|---|
| `create()` | `host`, `appId`, `sdkKey`, `playerId`, `trackerHost = nil` | Creates an `Offerwall`. `host` is a plain host name (an `https://` URL is accepted). Throws `AppDiscoveryError` when the host is blank or invalid. `trackerHost` is only needed when reward sync runs on a different host than the offerwall. |
| `syncPendingRewards()` | `host`, `appId`, `sdkKey`, `playerId`, `trackerHost = nil`, `callback` | Delivers rewards earned while the app was closed, without opening the offerwall. |

### Offerwall

| Member | Description |
|---|---|
| `launch(viewController:)` | Presents the offerwall full screen and syncs pending rewards. |
| `onReward` | `(([String: Any?]) -> Void)?` called for every reward. |
| `onClose` | `(() -> Void)?` called when the offerwall closes. |
| `tags`, `options` | Optional dictionaries for custom tags and display options. |
| `syncPendingRewards(callback:)` | Sync pending rewards for this player. |

### Reward fields

| Field | Description |
|---|---|
| `amount` / `payout` | Reward amount |
| `txid` | Unique transaction id, use it to avoid crediting twice |
| `status` | `approved`, `pending`, `reversed` or `rejected` |
| `player_id` | The player id you passed in |
| `offer_id`, `offer_name` | The completed offer, when available |

Any additional parameters sent by the server are preserved in the dictionary.

## Troubleshooting

- **Zero offers shown:** check that the bundle identifier matches the one registered for your `appId`, that `appId`, `sdkKey` and `host` are correct, and that `playerId` is not empty.
- **`AppDiscoveryError.invalidHost`:** `host` must be a plain host name such as `offers.example.com`.

## License

MIT, see [LICENSE](LICENSE).
