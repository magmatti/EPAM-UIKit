import Foundation
import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "PhotoCollectionViewCell"
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let favoriteButton = UIButton()
    
    var favoriteTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        titleLabel.font = .systemFont(ofSize: 12)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2

        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.tintColor = .systemRed
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)

        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(favoriteButton)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),

            favoriteButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 5),
            favoriteButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -5),
            favoriteButton.widthAnchor.constraint(equalToConstant: 24),
            favoriteButton.heightAnchor.constraint(equalToConstant: 24),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 4),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -4),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with photo: Photo) {
        imageView.image = photo.image
        titleLabel.text = photo.title
        let heart = photo.isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: heart), for: .normal)
    }
    
    @objc private func favoriteButtonTapped() {
        favoriteTapped?()
    }
}
