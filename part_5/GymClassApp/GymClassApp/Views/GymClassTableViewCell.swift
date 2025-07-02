import UIKit

class GymClassTableViewCell: UITableViewCell {
    
    static let identifier = "GymClassTableViewCell"
    
    let timeLabel = UILabel()
    let nameLabel = UILabel()
    let durationLabel = UILabel()
    let trainerLabel = UILabel()
    let trainerImageView = UIImageView()
    let actionButton = UIButton(type: .system)
    
    var onActionButtonTap: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let stack = UIStackView(arrangedSubviews: [timeLabel, nameLabel, durationLabel, trainerLabel])
        stack.axis = .vertical
        stack.spacing = 4
        
        trainerImageView.layer.cornerRadius = 20
        trainerImageView.clipsToBounds = true
        trainerImageView.contentMode = .scaleAspectFill
        trainerImageView.translatesAutoresizingMaskIntoConstraints = false
        trainerImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        trainerImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let mainStack = UIStackView(arrangedSubviews: [trainerImageView, stack, actionButton])
        mainStack.axis = .horizontal
        mainStack.alignment = .center
        mainStack.spacing = 12
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])

        actionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        onActionButtonTap?()
    }
    
    func configure(with gymClass: GymClass) {
        timeLabel.text = gymClass.time
        nameLabel.text = gymClass.name
        durationLabel.text = "\(gymClass.duration) min"
        trainerLabel.text = gymClass.trainerName
        trainerImageView.image = UIImage(named: gymClass.trainerImageName)
        let buttonIcon = gymClass.isRegistered ? "xmark.circle.fill" : "plus.circle"
        actionButton.setImage(UIImage(systemName: buttonIcon), for: .normal)
    }
}
