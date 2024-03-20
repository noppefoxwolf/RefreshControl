# RefreshControl

![](https://github.com/noppefoxwolf/RefreshControl/blob/main/.github/example.gif)

> [!WARNING]
> The `noppefoxwolf/RefreshControl` is using some black magic.
> I recommend reviewing the implementation code.
> You can use this library with own risk.

# Feature

## UIRefreshControl compatible
- [x] Arrow style content view (ContentHostingRefreshControl)
- [x] Offscreen begin refresh (WaitHostingRefreshControl)
- [x] UIRefreshControl extensions (UIRefreshControl+)

## Subclass extends
- [x] Customize content view (ContentHostingRefreshControl)
- [x] Overtime message (OvertimeRefreshControl)
- [x] Timeout handler (TimeoutRefreshControl)
- [x] Add delegate (DelegatableRefreshControl)
- [x] Private method access (InternalRefreshControl)

## Additional extends
- [x] disabled control (RefreshControlController)

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

If you want to use disabled refreshControl.
You can use `RefreshControlController`.

```swift
tableView.refreshControlController = RefreshControlController(
    refreshControl: refreshControl
)
tableView.refreshControlController.isEnabled = false // Show disabled view
``` 

## Apps Using

<p float="left">
    <a href="https://apps.apple.com/app/id1668645019"><img src="https://github.com/noppefoxwolf/MediaViewer/blob/main/.github/dawn.png" height="65"></a>
</p>

If you use a RefreshControl, add your app via Pull Request.

# LICENSE

RefreshControl is released under an MIT license. See the LICENSE file for more information
