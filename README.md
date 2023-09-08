# RefreshControl

![](https://github.com/noppefoxwolf/RefreshControl/blob/main/.github/example.gif)

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
