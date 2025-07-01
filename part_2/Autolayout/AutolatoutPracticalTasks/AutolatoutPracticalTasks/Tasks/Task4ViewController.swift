//
//  Task4ViewController.swift
//  AutolatoutPracticalTasks
//
//  Created by Kakhaberi Kiknadze on 20.03.25.
//

import UIKit

// Create a view with two subviews aligned vertically when in Compact width, Regular height mode.
// If the orientation changes to Compact-Compact, same 2 subviews should be aligned horizontally.
// Hou can use iPhone 16 simulator for testing.

final class Task4ViewController: UIViewController {
    
    private let blueView = UIView()
    private let greenView = UIView()
    
    private var verticalConstraints: [NSLayoutConstraint] = []
    private var horizontalConstraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        registerForTraitChanges()
        updateLayout(for: traitCollection)
    }

    private func setupViews() {
        blueView.backgroundColor = .blue
        greenView.backgroundColor = .green
        
        [blueView, greenView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func registerForTraitChanges() {
        let sizeTraits: [UITrait] = [UITraitVerticalSizeClass.self, UITraitHorizontalSizeClass.self]
        registerForTraitChanges(sizeTraits) { (self: Self, previousTraitCollection: UITraitCollection) in
            // Handling trait change
            print("Trait collection changed:", self.traitCollection)
            self.updateLayout(for: self.traitCollection)
        }
    }
    
    private func setupConstraints() {
        verticalConstraints = [
            blueView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            blueView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            blueView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            blueView.heightAnchor.constraint(equalToConstant: 100),

            greenView.topAnchor.constraint(equalTo: blueView.bottomAnchor, constant: 20),
            greenView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor),
            greenView.trailingAnchor.constraint(equalTo: blueView.trailingAnchor),
            greenView.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        horizontalConstraints = [
            blueView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            blueView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            blueView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            blueView.widthAnchor.constraint(equalToConstant: 150),

            greenView.topAnchor.constraint(equalTo: blueView.topAnchor),
            greenView.leadingAnchor.constraint(equalTo: blueView.trailingAnchor, constant: 20),
            greenView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            greenView.bottomAnchor.constraint(equalTo: blueView.bottomAnchor),
            blueView.widthAnchor.constraint(equalTo: greenView.widthAnchor)
        ]

        NSLayoutConstraint.activate(verticalConstraints)
    }

    private func updateLayout(for traits: UITraitCollection) {
        if traits.horizontalSizeClass == .compact && traits.verticalSizeClass == .compact {
            NSLayoutConstraint.deactivate(verticalConstraints)
            NSLayoutConstraint.activate(horizontalConstraints)
        } else {
            NSLayoutConstraint.deactivate(horizontalConstraints)
            NSLayoutConstraint.activate(verticalConstraints)
        }
    }
}

#Preview {
    Task4ViewController()
}
