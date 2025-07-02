import UIKit

final class SettingsViewController: UIViewController {
    
    private let toggleSwitch = UISwitch()
    private let toggleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    private func setupUI() {
       toggleLabel.text = "Navigation is easy!"
       toggleLabel.font = .systemFont(ofSize: 18)
       toggleLabel.translatesAutoresizingMaskIntoConstraints = false
       
       toggleSwitch.translatesAutoresizingMaskIntoConstraints = false
       
       view.addSubview(toggleLabel)
       view.addSubview(toggleSwitch)
       
       NSLayoutConstraint.activate([
           toggleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
           toggleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
           
           toggleSwitch.centerYAnchor.constraint(equalTo: toggleLabel.centerYAnchor),
           toggleSwitch.leadingAnchor.constraint(equalTo: toggleLabel.trailingAnchor, constant: 16)
       ])
   }
}
