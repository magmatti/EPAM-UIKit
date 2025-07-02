import UIKit

final class PhotoGalleryViewController: UIViewController {
    
    private var photosByYear: [String: [Photo]] = [:]
    private var sortedYears: [String] = []
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photo Gallery"
        
        view.backgroundColor = .systemBackground
        
        configureData()
        setupCollectionView()
    }
    
    private func configureData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"

        let samplePhotos: [Photo] = [
            Photo(image: UIImage(named: "photo1")!, title: "Lake View", date: Date(timeIntervalSince1970: 1610000000), isFavorite: false),
            
            Photo(image: UIImage(named: "photo4")!, title: "Sunset Beach", date: Date(timeIntervalSince1970: 1650000000), isFavorite: false),
            
            Photo(image: UIImage(named: "photo2")!, title: "Forest Trail", date: Date(timeIntervalSince1970: 1620000000), isFavorite: true),
            
            Photo(image: UIImage(named: "photo3")!, title: "Sunset Beach", date: Date(timeIntervalSince1970: 1615000000), isFavorite: false),
            
            Photo(image: UIImage(named: "photo5")!, title: "Mountain Reflection", date: Date(timeIntervalSince1970: 1650000000), isFavorite: true),
            
            Photo(image: UIImage(named: "photo6")!, title: "Golden Sunset", date: Date(timeIntervalSince1970: 1660000000), isFavorite: false)
        ]

        for photo in samplePhotos {
            let year = dateFormatter.string(from: photo.date)
            if photosByYear[year] != nil {
                photosByYear[year]?.append(photo)
            } else {
                photosByYear[year] = [photo]
            }
        }

        sortedYears = photosByYear.keys.sorted(by: >)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(
            PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier
        )
        
        collectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderView.identifier
        )

        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension PhotoGalleryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sortedYears.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        let year = sortedYears[section]
        return photosByYear[year]?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let year = sortedYears[indexPath.section]
        
        guard let photo = photosByYear[year]?[indexPath.item],
              let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PhotoCollectionViewCell.identifier,
                for: indexPath
              ) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.configure(with: photo)

        cell.favoriteTapped = { [weak self] in
            guard let self = self else { return }
            self.photosByYear[year]?[indexPath.item].isFavorite.toggle()

            let updated = self.photosByYear[year]?[indexPath.item]
            let status = updated?.isFavorite == true ? "Marked" : "Removed"
            let symbol = updated?.isFavorite == true ? "♥️" : "🖤"

            let alert = UIAlertController(
                title: nil,
                message: "\(status) \(updated?.title ?? "") as Favorite! \(symbol)",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
            collectionView.reloadItems(at: [indexPath])
        }

        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

        let columns: CGFloat = UIDevice.current.orientation.isLandscape ? 5 : 3
        let spacing: CGFloat = 12 * (columns + 1)
        let totalWidth = collectionView.bounds.width - spacing
        let itemWidth = floor(totalWidth / columns)
        return CGSize(width: itemWidth, height: itemWidth + 40)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {

        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.identifier,
                for: indexPath
              ) as? HeaderView else {
            return UICollectionReusableView()
        }

        let year = sortedYears[indexPath.section]
        header.configure(text: year)
        return header
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
}

