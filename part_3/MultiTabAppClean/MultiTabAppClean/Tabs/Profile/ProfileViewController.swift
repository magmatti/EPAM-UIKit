import UIKit

final class ProfileViewController: UIViewController {
    
    private let nameLabel = UILabel()
    private let editButton = UIButton(type: .system)
    
    private var userName: String? {
        didSet {
            nameLabel.text = "Name: \(userName ?? "Unknown")"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logLifecycle("viewDidLoad")
        view.backgroundColor = .systemBackground
        title = "Profile"
        setupUI()
        setupNavigationBar()
    }
    
    // lifecycle logging
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
        print("[ProfileViewController] \(method)")
    }

    private func setupUI() {
        nameLabel.text = "Name: \(userName)"
        nameLabel.font = .systemFont(ofSize: 20)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        editButton.setTitle("Edit profile", for: .normal)
        editButton.addTarget(self, action: #selector(editProfileTapped), for: .touchUpInside)
        editButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(nameLabel)
        view.addSubview(editButton)

        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),

            editButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            editButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        let alertButton = UIBarButtonItem(
            image: UIImage(systemName: "pencil.slash"),
            style: .plain,
            target: self,
            action: #selector(promptForName)
        )

        let anonymousButton = UIBarButtonItem(
            image: UIImage(systemName: "person.crop.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(setAnonymous)
        )

        navigationItem.rightBarButtonItems = [anonymousButton, alertButton]
    }
    
    @objc private func promptForName() {
        let alert = UIAlertController(title: "Change Name", message: "Enter a new name", preferredStyle: .alert)
        alert.addTextField()

        let confirm = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            let input = alert.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            self?.userName = input?.isEmpty == false ? input! : "Default"
        }

        let cancel = UIAlertAction(title: "Cancel", style: .cancel)

        alert.addAction(confirm)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    @objc private func setAnonymous() {
        userName = "Anonymous"
    }
    
    @objc private func editProfileTapped() {
        let editVC = EditProfileViewController()
        navigationController?.pushViewController(editVC, animated: true)
    }
}
