import UIKit

final class EditProfileViewController: UIViewController {
    
    private let infoLabel = UILabel()
        
    // lifecycle logging
    override func viewDidLoad() {
        super.viewDidLoad()
        logLifecycle("viewDidLoad")
        view.backgroundColor = .systemGray6
        title = "Edit profile"
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logLifecycle("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logLifecycle("viewDidAppear")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        logLifecycle("viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logLifecycle("viewDidLayoutSubviews")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logLifecycle("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        logLifecycle("viewDidDisappear")
    }
    
    private func logLifecycle(_ method: String) {
        print("[EditProfileViewController] \(method)")
    }
    
    private func setupUI() {
        infoLabel.text = "You are editing your profile"
        infoLabel.textAlignment = .center
        infoLabel.textColor = .black
        infoLabel.font = .systemFont(ofSize: 18)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
