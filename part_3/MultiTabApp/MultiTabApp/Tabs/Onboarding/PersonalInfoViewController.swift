import UIKit

final class PersonalInfoViewController: UIViewController {
    
    var userName: String?
    var phoneNumber: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Personal Info"
        setupViews()
        setupConstraints()
        setupActions()
    }

    private func setupViews() {
        view.addSubview(instructionLabel)
        view.addSubview(nameTextField)
        view.addSubview(phoneTextField)
        view.addSubview(confirmButton)
    }
    
    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter your information"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter your name"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    let phoneTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter your phone number"
        tf.keyboardType = .numberPad
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Confirm", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            instructionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            nameTextField.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 30),
            nameTextField.leadingAnchor.constraint(equalTo: instructionLabel.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: instructionLabel.trailingAnchor),

            phoneTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            phoneTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            phoneTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),

            confirmButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 30),
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmButton.widthAnchor.constraint(equalToConstant: 120),
            confirmButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func setupActions() {
        nameTextField.addTarget(self, action: #selector(validateInput), for: .editingChanged)
        phoneTextField.addTarget(self, action: #selector(validateInput), for: .editingChanged)
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }

    @objc private func validateInput() {
        let isNameValid = !(nameTextField.text ?? "").trimmingCharacters(in: .whitespaces).isEmpty
        let isPhoneValid = (phoneTextField.text ?? "").count >= 9

        confirmButton.isEnabled = isNameValid && isPhoneValid
        confirmButton.alpha = confirmButton.isEnabled ? 1.0 : 0.5
    }

    @objc private func confirmButtonTapped() {
        userName = nameTextField.text ?? ""
        phoneNumber = phoneTextField.text ?? ""

        let alert = UIAlertController(
            title: "Confirm Information",
            message: "Please confirm your name and phone number.\nName: \(userName!), Phone: \(phoneNumber!)",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Edit", style: .cancel))

        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { _ in
            let preferencesVC = PreferencesViewController()
            preferencesVC.userName = self.userName
            preferencesVC.phoneNumber = self.phoneNumber
            self.navigationController?.pushViewController(preferencesVC, animated: true)
        }))

        present(alert, animated: true)
    }
}
