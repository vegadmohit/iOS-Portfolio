import UIKit

class PlaceDetailHeaderView: UIView {

    @IBOutlet weak var imageView: UIImageView!

    static func instantiate() -> PlaceDetailHeaderView {
        let nib = UINib(nibName: "PlaceDetailHeaderView", bundle: nil)
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? PlaceDetailHeaderView else {
            fatalError("Failed to load PlaceDetailHeaderView from nib")
        }
        return view
    }

    func configure(with url: URL?) {
        guard let url = url else {
            imageView.image = UIImage(named: "placeholder")
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }.resume()
    }
    
    
}
