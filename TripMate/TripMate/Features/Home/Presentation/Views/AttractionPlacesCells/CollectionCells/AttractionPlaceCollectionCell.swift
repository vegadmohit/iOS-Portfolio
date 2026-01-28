import UIKit

class AttractionPlaceCollectionCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!

    static let reuseIdentifier = "AttractionPlaceCollectionCell"

    func configure(with attraction: AttractionModel) {
        nameLabel.text = attraction.name
        
        imageView.image = nil
        
        guard let url = attraction.photoURL() else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }.resume()
    }
}


