# RefreshControl

![](https://github.com/noppefoxwolf/RefreshControl/blob/main/.github/example.gif)

# Notice

The `noppefoxwolf/RefreshControl` is using some black magic.
I recommend reviewing the implementation code.
You can use this library with own risk.

# Feature

## UIRefreshControl compatible
- [x] Custom content view
- [x] Offscreen begin refresh
- [x] UIRefreshControl extensions

## Subclass extends
- [x] Overtime message
- [x] Timeout handler

# Usage

The `noppefoxwolf/RefreshControl` is subclass of UIRefreshControl.
You can use this library same of UIRefreshControl.

```swift
import RefreshControl
...
refreshControl = RefreshControl()
refreshControl!.addAction(UIAction { _ in
  ...
}, for: .primaryActionTriggered)
```

# LICENSE

RefreshControl is released under an MIT license. See the LICENSE file for more information
