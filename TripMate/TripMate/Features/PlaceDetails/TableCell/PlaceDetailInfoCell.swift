import UIKit

class PlaceDetailInfoCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!

    static let reuseIdentifier = "PlaceDetailInfoCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ attraction: AttractionModel?) {
        nameLabel.text = attraction?.name
        addressLabel.text = attraction?.address
    }

}
