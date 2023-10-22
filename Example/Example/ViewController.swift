
import UIKit
import RefreshControl

class ViewController: UITableViewController {
    enum Section: Int {
        case items
    }

    enum Item: String, CaseIterable {
        case refreshControl
        case originalRefreshControl
    }
    
    lazy var dataSource = UITableViewDiffableDataSource<Section, Item>(
        tableView: tableView,
        cellProvider: { [unowned self] (tableView, indexPath, item) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            var contentConfiguration = UIListContentConfiguration.cell()
            contentConfiguration.text = item.rawValue
            cell.contentConfiguration = contentConfiguration
            return cell
        }
    )
    
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        _ = dataSource
        
        snapshot.appendSections([.items])
        snapshot.appendItems(Item.allCases, toSection: .items)
        
        dataSource.apply(snapshot)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch dataSource.itemIdentifier(for: indexPath) {
        case .refreshControl:
            let vc = RefreshViewController<RefreshControl>()
            navigationController?.pushViewController(vc, animated: true)
        case .originalRefreshControl:
            let vc = RefreshViewController<UIRefreshControl>()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
