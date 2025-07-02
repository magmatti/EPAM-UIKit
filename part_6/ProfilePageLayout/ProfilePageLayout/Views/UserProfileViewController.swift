import Foundation
import UIKit

final class UserProfileViewController: UIViewController {

    private let user = User(
        name: "John Doe",
        bio: "iOS Developer | Fitness enthusiast | Coffee addict",
        profileImage: UIImage(named: "profile")!,
        followers: 1200,
        following: 300,
        posts: 75
    )

    private let mainStackView = UIStackView()
    private let taggedSection = UILabel()
    private let toggleTaggedButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupStackView()
    }

    private func setupStackView() {
        mainStackView.axis = .vertical
        mainStackView.spacing = 16
        mainStackView.alignment = .center
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStackView)

        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24)
        ])

        setupProfileHeader()
        setupBio()
        setupStatistics()
        setupTaggedSection()
        setupToggleButton()
    }

    private func setupProfileHeader() {
        let profileImageView = UIImageView(image: user.profileImage)
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 40
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80)
        ])

        let nameLabel = UILabel()
        nameLabel.text = user.name
        nameLabel.font = .boldSystemFont(ofSize: 20)

        let followButton = UIButton(type: .system)
        followButton.setTitle("Follow", for: .normal)
        followButton.setTitleColor(.white, for: .normal)
        followButton.backgroundColor = .systemBlue
        followButton.layer.cornerRadius = 6
        followButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)

        let headerStack = UIStackView(arrangedSubviews: [profileImageView, nameLabel, followButton])
        headerStack.axis = .horizontal
        headerStack.alignment = .center
        headerStack.spacing = 16
        mainStackView.addArrangedSubview(headerStack)
    }

    private func setupBio() {
        let bioLabel = UILabel()
        bioLabel.text = user.bio
        bioLabel.textAlignment = .center
        bioLabel.numberOfLines = 0
        bioLabel.font = .systemFont(ofSize: 16)
        mainStackView.addArrangedSubview(bioLabel)
    }

    private func setupStatistics() {
        let followers = makeStatStack(count: "\(user.followers)", label: "Followers")
        let following = makeStatStack(count: "\(user.following)", label: "Following")
        let posts = makeStatStack(count: "\(user.posts)", label: "Posts")

        let statsStack = UIStackView(arrangedSubviews: [followers, following, posts])
        statsStack.axis = .horizontal
        statsStack.spacing = 32
        statsStack.alignment = .center
        mainStackView.addArrangedSubview(statsStack)
    }

    private func makeStatStack(count: String, label: String) -> UIStackView {
        let countLabel = UILabel()
        countLabel.text = count
        countLabel.font = .boldSystemFont(ofSize: 18)
        countLabel.textAlignment = .center

        let nameLabel = UILabel()
        nameLabel.text = label
        nameLabel.font = .systemFont(ofSize: 14)
        nameLabel.textColor = .gray
        nameLabel.textAlignment = .center

        let stack = UIStackView(arrangedSubviews: [countLabel, nameLabel])
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }

    private func setupTaggedSection() {
        taggedSection.text = "Tagged Posts Section"
        taggedSection.font = .systemFont(ofSize: 16)
        taggedSection.textColor = .gray
        taggedSection.textAlignment = .center
        taggedSection.isHidden = true
        mainStackView.addArrangedSubview(taggedSection)
    }

    private func setupToggleButton() {
        toggleTaggedButton.setTitle("Show Tagged", for: .normal)
        toggleTaggedButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        toggleTaggedButton.addTarget(self, action: #selector(toggleTaggedSection), for: .touchUpInside)
        mainStackView.addArrangedSubview(toggleTaggedButton)
    }

    @objc private func toggleTaggedSection() {
        let isHidden = taggedSection.isHidden
        taggedSection.isHidden = !isHidden
        toggleTaggedButton.setTitle(isHidden ? "Hide Tagged" : "Show Tagged", for: .normal)

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
