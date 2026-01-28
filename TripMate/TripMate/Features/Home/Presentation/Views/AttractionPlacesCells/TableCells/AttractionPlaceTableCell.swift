import UIKit

class AttractionPlaceTableCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!

    static let reuseIdentifier = "AttractionPlaceTableCell"

    // MARK: - Private Properties
    private var attractionsPlaces: [AttractionModel] = []
    private var didSelectPlace: ((AttractionModel) -> Void)?

    // MARK: - Method
    func configure(with attractions: [AttractionModel], didSelect: @escaping (AttractionModel) -> Void) {
        self.attractionsPlaces = attractions
        self.didSelectPlace = didSelect
        collectionView.reloadData()
    }

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            UINib(nibName: AttractionPlaceCollectionCell.reuseIdentifier, bundle: nil),
            forCellWithReuseIdentifier: AttractionPlaceCollectionCell.reuseIdentifier)

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 12
            layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
    }
}

// MARK: - UICollectionView DataSource & Delegate

extension AttractionPlaceTableCell: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attractionsPlaces.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AttractionPlaceCollectionCell.reuseIdentifier,
            for: indexPath) as? AttractionPlaceCollectionCell else {
            return UICollectionViewCell()
        }

        let attraction = attractionsPlaces[indexPath.item]
        cell.configure(with: attraction)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let place = attractionsPlaces[indexPath.item]
        didSelectPlace?(place)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AttractionPlaceTableCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let height = collectionView.frame.height
        let width: CGFloat = 130
        return CGSize(width: width, height: height)
    }
}
