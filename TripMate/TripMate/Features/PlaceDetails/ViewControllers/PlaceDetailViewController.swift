import UIKit

class PlaceDetailViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    var attraction: AttractionModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: PlaceDetailInfoCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: PlaceDetailInfoCell.reuseIdentifier)

        setupHeader()
    }
    
    private func setupHeader() {
        let header = PlaceDetailHeaderView.instantiate()
        let visibleHeight: CGFloat = 250
        let headerHeight = visibleHeight + 88
        header.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: headerHeight)
        header.configure(with: attraction?.photoURL())
        tableView.tableHeaderView = header
    }
}

extension PlaceDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceDetailInfoCell", for: indexPath) as! PlaceDetailInfoCell
        cell.configure(attraction)
        return cell
    }
    
    
}
