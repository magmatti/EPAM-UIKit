import Foundation
import UIKit

final class PreferencesViewController: UIViewController {
    
    var userName: String?
    var phoneNumber: String?
    
    private let instructionLabel = UILabel()
    private let selectPreferenceButton = UIButton(type: .system)
    private let selectedPreferenceLabel = UILabel()
    private let nextButton = UIButton(type: .system)
    
    private var selectedPreference: String? {
        didSet {
            selectedPreferenceLabel.text = selectedPreference.map {
                "Selected: \($0)"
            } ?? "No preference selected"
            nextButton.isEnabled = selectedPreference != nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Preferences"
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        instructionLabel.text = "Select your notification preference:"
        instructionLabel.font = .systemFont(ofSize: 18)
        instructionLabel.numberOfLines = 0
        instructionLabel.textAlignment = .center
        
        selectPreferenceButton.setTitle("Choose Preference", for: .normal)
        selectPreferenceButton.setTitleColor(.white, for: .normal)
        selectPreferenceButton.backgroundColor = .systemBlue
        selectPreferenceButton.layer.cornerRadius = 8
        selectPreferenceButton.addTarget(self, action: #selector(showPreferenceActionSheet), for: .touchUpInside)

        selectedPreferenceLabel.text = "No preference selected"
        selectedPreferenceLabel.font = .systemFont(ofSize: 16)
        selectedPreferenceLabel.textColor = .darkGray
        selectedPreferenceLabel.textAlignment = .center
        
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.backgroundColor = .systemGreen
        nextButton.layer.cornerRadius = 8
        nextButton.isEnabled = false
        nextButton.alpha = 0.6
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        
        [instructionLabel, selectPreferenceButton, selectedPreferenceLabel, nextButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    @objc private func showPreferenceActionSheet() {
        let alert = UIAlertController(title: "Select Notification Preference", message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Email Notifications", style: .default, handler: { _ in
            self.setPreference("Email Notifications")
        }))

        alert.addAction(UIAlertAction(title: "SMS Notifications", style: .default, handler: { _ in
            self.setPreference("SMS Notifications")
        }))

        alert.addAction(UIAlertAction(title: "Push Notifications", style: .default, handler: { _ in
            self.setPreference("Push Notifications")
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alert, animated: true)
    }
    
    @objc private func nextTapped() {
        let confirmVC = ConfirmDetailsViewController()
        confirmVC.userName = userName
        confirmVC.phoneNumber = phoneNumber
        confirmVC.notificationPreference = selectedPreference ?? "N/A"
        navigationController?.pushViewController(confirmVC, animated: true)
    }
    
    private func setPreference(_ preference: String) {
        selectedPreference = preference
        nextButton.alpha = 1.0
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            instructionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            selectPreferenceButton.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 30),
            selectPreferenceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectPreferenceButton.widthAnchor.constraint(equalToConstant: 200),
            selectPreferenceButton.heightAnchor.constraint(equalToConstant: 44),

            selectedPreferenceLabel.topAnchor.constraint(equalTo: selectPreferenceButton.bottomAnchor, constant: 20),
            selectedPreferenceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            selectedPreferenceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            nextButton.topAnchor.constraint(equalTo: selectedPreferenceLabel.bottomAnchor, constant: 40),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 120),
            nextButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
