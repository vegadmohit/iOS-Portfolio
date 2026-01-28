import UIKit

// MARK: - HomeViewController
class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    weak var navigator: HomeNavigator?
    var viewModel: HomeViewModelProtocol!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchAttractionPlaces()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        self.navigationItem.title = "Home"
        
        tableView.register(
            UINib(nibName: "AttractionPlaceTableCell", bundle: nil),
            forCellReuseIdentifier: AttractionPlaceTableCell.reuseIdentifier)
        tableView.register(UINib(nibName: "TrendingTableCell", bundle: nil),
            forCellReuseIdentifier: TrendingTableCell.reuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            self?.tableView.reloadData()
            self?.tableView.refreshControl?.endRefreshing()
        }
        
        viewModel.onError = { [weak self] error in
            self?.tableView.refreshControl?.endRefreshing()
            self?.showAlert(message: error.localizedDescription)
        }
    }
    
    @objc private func refreshData() {
        viewModel.refreshData()
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = viewModel.sections[indexPath.section]
        
        switch section {
        case .attractionPlaces(let data):
            let cell = tableView.dequeueReusableCell(withIdentifier: AttractionPlaceTableCell.reuseIdentifier,for: indexPath) as! AttractionPlaceTableCell
            
            cell.configure(with: data) { [weak self] place in
                self?.navigator?.navigateToDetail(place: place)
            }
            return cell
            
        case .trendingPlaces(let data):
            let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTableCell.reuseIdentifier,for: indexPath
            ) as! TrendingTableCell
            
            cell.configure(with: data) { [weak self] place in
                self?.navigator?.navigateToDetail(place: place)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.sections[indexPath.section].rowHeight
    }
}
