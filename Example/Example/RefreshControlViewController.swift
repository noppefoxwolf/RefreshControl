import UIKit
import RefreshControl
import SwiftUI

final class RefreshViewController: UITableViewController {
    enum Section: Int {
        case items
    }

    struct Item: Hashable {
        let id: UUID = UUID()
    }
    
    lazy var dataSource = UITableViewDiffableDataSource<Section, Item>(
        tableView: tableView,
        cellProvider: { [unowned self] (tableView, indexPath, item) in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "cell",
                for: indexPath
            )
            
            cell.contentConfiguration = UIHostingConfiguration(content: {
                Text("Hello, World!!")
            })
            
            return cell
        }
    )
    
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    
    let refreshControlFactory: () -> UIRefreshControl
    
    var refreshControlController: (any RefreshControlControllable)? = nil
    
    init(_ refreshControlFactory: @escaping () -> UIRefreshControl) {
        self.refreshControlFactory = refreshControlFactory
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = refreshControlFactory()
        refreshControl.addAction(UIAction { _ in
            print("Refresh!")
        }, for: .primaryActionTriggered)
        
        let rootView = VStack(content: {
            ProgressView().progressViewStyle(.circular)
            Text("Streaming...").foregroundStyle(.secondary)
        }).padding()
        let disabledRefreshIndicatorView = DisabledRefreshIndicatorView(rootView: rootView)
        
        refreshControlController = RefreshControlController(
            refreshControl: refreshControl,
            disabledRefreshIndicatorView: disabledRefreshIndicatorView
        )
        refreshControlController?.scrollView = tableView
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        _ = dataSource
        
        snapshot.appendSections([.items])
        snapshot.appendItems((0..<100).map({ _ in Item() }), toSection: .items)
        
        dataSource.apply(snapshot)
            
        let refreshMenuItem = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis.circle"),
            menu: UIMenu(children: [
                UIAction(
                    title: "StartRefreshing",
                    image: UIImage(systemName: "arrow.counterclockwise.circle"),
                    handler: { [weak self] _ in
                        self?.refreshControlController?.refreshControl.startRefreshing()
                        self?.tableView.reloadData()
                    }
                ),
                UIAction(
                    title: "BeginRefreshing",
                    image: UIImage(systemName: "play.fill"),
                    handler: { [weak self] _ in
                        self?.refreshControlController?.refreshControl.beginRefreshing()
                    }
                ),
                UIAction(
                    title: "EndRefreshing",
                    image: UIImage(systemName: "pause.fill"),
                    handler: { [weak self] _ in
                        self?.refreshControlController?.refreshControl.endRefreshing()
                    }
                ),
                UIAction(
                    title: "FinishRefreshing",
                    image: UIImage(systemName: "stop.fill"),
                    handler: { [weak self] _ in
                        self?.refreshControlController?.refreshControl.finishRefreshing()
                    }
                ),
                UIAction(
                    title: "Enabled",
                    image: UIImage(systemName: "circle.circle"),
                    handler: { [weak self] _ in
                        self?.refreshControlController?.isEnabled = true
                    }
                ),
                UIAction(
                    title: "Disabled",
                    image: UIImage(systemName: "xmark.circle"),
                    handler: { [weak self] _ in
                        self?.refreshControlController?.isEnabled = false
                    }
                ),
            ])
        )
        refreshMenuItem.preferredMenuElementOrder = .fixed
        setToolbarItems([
            UIBarButtonItem.flexibleSpace(),
            refreshMenuItem,
        ], animated: false)
        navigationController?.setToolbarHidden(false, animated: false)
    }
}

