# RefreshControl

![](https://github.com/noppefoxwolf/RefreshControl/blob/main/.github/example.gif)

> **Warning**
> The `noppefoxwolf/RefreshControl` is using some black magic.
> I recommend reviewing the implementation code.
> You can use this library with own risk.

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

## Apps Using

<p float="left">
    <a href="https://apps.apple.com/app/id1668645019"><img src="https://github.com/noppefoxwolf/MediaViewer/blob/main/.github/dawn.png" height="65"></a>
</p>

If you use a MediaViewer, add your app via Pull Request.

# LICENSE

RefreshControl is released under an MIT license. See the LICENSE file for more information
