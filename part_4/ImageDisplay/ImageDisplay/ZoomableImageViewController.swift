import UIKit

final class ZoomableImageViewController: UIViewController, UIScrollViewDelegate {
    
    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    
    private let imagePadding: CGFloat = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupScrollView()
        setupImageView()
    }

    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = false
        scrollView.bounces = true
        scrollView.bouncesZoom = true
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupImageView() {
        guard let image = UIImage(named: "nature") else {
            print("Image not found!")
            return
        }

        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(imageView)

        // Calculate image frame with aspect fit
        let viewWidth = view.bounds.width - 2 * imagePadding
        let aspectRatio = image.size.height / image.size.width
        let fittedHeight = viewWidth * aspectRatio
        imageView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: fittedHeight)

        scrollView.contentSize = CGSize(width: viewWidth, height: fittedHeight)
        centerImage()
    }

    // Required for zooming
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImage()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Lock horizontal scrolling at base zoom
        if scrollView.zoomScale == scrollView.minimumZoomScale {
            scrollView.contentOffset.x = 0
        }
    }

    private func centerImage() {
        let scrollSize = scrollView.bounds.size
        let imageSize = imageView.frame.size

        let horizontal = max(0, (scrollSize.width - imageSize.width * scrollView.zoomScale) / 2)
        let vertical = max(0, (scrollSize.height - imageSize.height * scrollView.zoomScale) / 2)

        scrollView.contentInset = UIEdgeInsets(
            top: vertical + imagePadding,
            left: horizontal + imagePadding,
            bottom: vertical + imagePadding,
            right: horizontal + imagePadding
        )
    }
}

