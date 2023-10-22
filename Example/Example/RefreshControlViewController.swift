import UIKit
import RefreshControl
import SwiftUI

final class RefreshViewController<T: UIRefreshControl>: UITableViewController {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = T()
        refreshControl!.addAction(UIAction { _ in
            print("Refresh!")
        }, for: .primaryActionTriggered)
        
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
                    image: UIImage(systemName: "play.fill"),
                    handler: { _ in
                        self.refreshControl?.startRefreshing()
                    }
                ),
                UIAction(
                    title: "BeginRefreshing",
                    image: UIImage(systemName: "play.fill"),
                    handler: { _ in
                        self.refreshControl?.beginRefreshing()
                    }
                ),
                UIAction(
                    title: "EndRefreshing",
                    image: UIImage(systemName: "pause.fill"),
                    handler: { _ in
                        self.refreshControl?.endRefreshing()
                    }
                ),
                UIAction(
                    title: "FinishRefreshing",
                    image: UIImage(systemName: "pause.fill"),
                    handler: { _ in
                        self.refreshControl?.finishRefreshing()
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

