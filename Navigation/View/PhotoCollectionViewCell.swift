import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    static let  identifier = "lib"

    var source: ImageSet? {
        didSet {
            photoImage.image = source?.image
            rowForImage = (source?.rowIndex)!
        }
    }

    var rowForImage: Int = 0

    lazy var photoImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6
        return image
    }()

    private func setupView() {

        contentView.addSubview(photoImage)

        let constraints = [
            photoImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}
