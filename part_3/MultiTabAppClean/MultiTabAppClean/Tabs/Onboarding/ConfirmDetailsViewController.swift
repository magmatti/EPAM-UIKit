import UIKit

final class ConfirmDetailsViewController: UIViewController {
    
    var userName: String? = ""
    var phoneNumber: String? = ""
    var notificationPreference: String = ""

    private let nameLabel = UILabel()
    private let phoneLabel = UILabel()
    private let notificationLabel = UILabel()

    private let startOverButton = UIButton(type: .system)
    private let editPreferencesButton = UIButton(type: .system)
    private let editPersonalInfoButton = UIButton(type: .system)
    private let confirmButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Confirm Details"
        navigationItem.hidesBackButton = true
        setupUI()
        layoutUI()
    }
    
    private func setupUI() {
        [nameLabel, phoneLabel, notificationLabel].forEach {
            $0.font = .systemFont(ofSize: 18)
            $0.textAlignment = .center
        }

        nameLabel.text = "Name: \(userName ?? "N/A")"
        phoneLabel.text = "Phone Number: \(phoneNumber ?? "N/A")"
        notificationLabel.text = "Notification Preference: \(notificationPreference)"

        setupButton(startOverButton, title: "Start Over", action: #selector(didTapStartOver))
        setupButton(editPreferencesButton, title: "Edit Preferences", action: #selector(didTapEditPreferences))
        setupButton(editPersonalInfoButton, title: "Edit Personal Info", action: #selector(didTapEditPersonalInfo))
        setupButton(confirmButton, title: "Confirm", action: #selector(didTapConfirm))
    }
    
    private func setupButton(_ button: UIButton, title: String, action: Selector) {
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.addTarget(self, action: action, for: .touchUpInside)
    }
    
    private func layoutUI() {
        let stack = UIStackView(arrangedSubviews: [
            nameLabel,
            phoneLabel,
            notificationLabel,
            startOverButton,
            editPreferencesButton,
            editPersonalInfoButton,
            confirmButton
        ])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // button actions
    @objc private func didTapStartOver() {
        navigationController?.popToRootViewController(animated: true)
    }

    @objc private func didTapEditPreferences() {
        if let preferencesVC = navigationController?.viewControllers.first(where: { $0 is PreferencesViewController }) {
            navigationController?.popToViewController(preferencesVC, animated: true)
        }
    }

    @objc private func didTapEditPersonalInfo() {
        if let personalInfoVC = navigationController?.viewControllers.first(where: { $0 is PersonalInfoViewController }) {
            navigationController?.popToViewController(personalInfoVC, animated: true)
        }
    }
    
    @objc private func didTapConfirm() {
        let alert = UIAlertController(
            title: "Onboarding Complete",
            message: "You have successfully completed onboarding.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            if let onboardingVC = self.navigationController?.viewControllers.first(where: { $0 is OnboardingViewController }) as? OnboardingViewController {
                onboardingVC.setRestartState()
                self.navigationController?.popToViewController(onboardingVC, animated: true)
            }
        })
        present(alert, animated: true)
    }
}
