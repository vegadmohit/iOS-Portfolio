import UIKit

class TrendingTableCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!

    static let reuseIdentifier = "TrendingTableCell"
    
    private var trendingPlaces: [AttractionModel] = []
    private var didSelectPlace: ((AttractionModel) -> Void)?

    // MARK: - Method
    
    func configure(with places: [AttractionModel], didSelect: @escaping (AttractionModel) -> Void) {
        self.trendingPlaces = places
        self.didSelectPlace = didSelect
        collectionView.reloadData()
    }

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            UINib(nibName: TrendingCollectionCell.reuseIdentifier, bundle: nil),
            forCellWithReuseIdentifier: TrendingCollectionCell.reuseIdentifier
        )

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 12
            layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
    }
}

// MARK: - UICollectionView DataSource & Delegate

extension TrendingTableCell: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingPlaces.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TrendingCollectionCell.reuseIdentifier,
            for: indexPath
        ) as? TrendingCollectionCell else {
            return UICollectionViewCell()
        }

        let place = trendingPlaces[indexPath.item]
        cell.configure(with: place)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let place = trendingPlaces[indexPath.item]
        didSelectPlace?(place)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TrendingTableCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let height = collectionView.frame.height
        let width: CGFloat = 130
        return CGSize(width: width, height: height)
    }
}
