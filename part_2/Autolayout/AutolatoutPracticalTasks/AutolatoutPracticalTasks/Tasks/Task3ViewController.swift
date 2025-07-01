//
//  Task3ViewController.swift
//  AutolatoutPracticalTasks
//
//  Created by Kakhaberi Kiknadze on 20.03.25.
//

import UIKit
import Combine

// Lay out login screen as in the attached screen recording.
// 1. Content should respect safe area guides
// 2. Content should be visible on all screen sizes
// 3. Content should be spaced on bottom as in the recording
// 4. When keyboard appears, content should move up
// 5. When you tap the screen and keyboard gets dismissed, content should move down
// 6. You can use container views/layout guides or any option you find useful
// 7. Content should have horizontal spacing of 16
// 8. Title and description labels should have a vertical spacing of 12 from each other
// 9. Textfields should have a spacing of 40 from top labels
// 10. Login button should have 16 spacing from textfields

final class Task3ViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let formContainerView = UIView()

    private let titleLabel = UILabel()
    private let bodyLabel = UILabel()
    private let usernameField = UITextField()
    private let passwordField = UITextField()
    private let logInButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        setupGestures()
    }

    private func setupViews() {
        titleLabel.text = "Sign In"
        titleLabel.font = .boldSystemFont(ofSize: 32)

        bodyLabel.text = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit,
        sed do eiusmod tempor incididunt ut labore
        """
        bodyLabel.numberOfLines = 3

        usernameField.placeholder = "Enter username"
        usernameField.borderStyle = .roundedRect

        passwordField.placeholder = "Enter password"
        passwordField.borderStyle = .roundedRect

        logInButton.setTitle("Log In", for: .normal)

        [scrollView, contentView, formContainerView,
         titleLabel, bodyLabel, usernameField, passwordField, logInButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(formContainerView)

        formContainerView.addSubview(titleLabel)
        formContainerView.addSubview(bodyLabel)
        formContainerView.addSubview(usernameField)
        formContainerView.addSubview(passwordField)
        formContainerView.addSubview(logInButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor),

            formContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            formContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            formContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
            formContainerView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 40),

            titleLabel.topAnchor.constraint(equalTo: formContainerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: formContainerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: formContainerView.trailingAnchor),

            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            bodyLabel.leadingAnchor.constraint(equalTo: formContainerView.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: formContainerView.trailingAnchor),

            usernameField.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 40),
            usernameField.leadingAnchor.constraint(equalTo: formContainerView.leadingAnchor),
            usernameField.trailingAnchor.constraint(equalTo: formContainerView.trailingAnchor),

            passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 16),
            passwordField.leadingAnchor.constraint(equalTo: formContainerView.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: formContainerView.trailingAnchor),

            logInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: formContainerView.leadingAnchor),
            logInButton.trailingAnchor.constraint(equalTo: formContainerView.trailingAnchor),
            logInButton.bottomAnchor.constraint(equalTo: formContainerView.bottomAnchor)
        ])
    }
    
    private func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func endEditing() {
        view.endEditing(true)
    }
}

#Preview {
    Task3ViewController()
}
