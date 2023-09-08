import UIKit
import SwiftUI

class OriginalRefreshControlViewController: UITableViewController {
    lazy var dataSource = UITableViewDiffableDataSource<Section, Item>(
        tableView: tableView,
        cellProvider: { [unowned self] (tableView, indexPath, item) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.contentConfiguration = UIHostingConfiguration(content: {
                Text("ok")
            })
            return cell
        }
    )
    
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl!.tag = 100
        refreshControl!.addAction(UIAction { _ in
            print("Refresh!")
        }, for: .primaryActionTriggered)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            systemItem: .cancel,
            primaryAction: UIAction { [unowned self] _ in
                if refreshControl!.isRefreshing {
                    refreshControl!.endRefreshing()
                }
            }
        )
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        _ = dataSource
        
        snapshot.appendSections([.items])
        snapshot.appendItems((0..<100).map({ _ in Item() }), toSection: .items)
        
        dataSource.apply(snapshot)
    }
}
