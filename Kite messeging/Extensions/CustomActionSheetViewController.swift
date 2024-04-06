//
//  CustomActionSheetViewController.swift
//  Kite messeging
//
//  Created by Admin on 19/03/24.
//
import UIKit

class CustomActionSheetViewController: UIViewController {
    
    // MARK: - Properties
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    private let actionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        
        containerView.addSubview(actionStackView)
        actionStackView.translatesAutoresizingMaskIntoConstraints = false
        actionStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20).isActive = true
        actionStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        actionStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        
        actionStackView.addArrangedSubview(createActionButton(title: "My Account", imageName: "account"))
        actionStackView.addArrangedSubview(createActionButton(title: "Settings", imageName: "setting"))
        actionStackView.addArrangedSubview(createActionButton(title: "Logout", imageName: "logout"))
        
        containerView.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.topAnchor.constraint(equalTo: actionStackView.bottomAnchor, constant: 20).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func createActionButton(title: String, imageName: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.contentHorizontalAlignment = .left
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.addTarget(self, action: #selector(actionButtonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    // MARK: - Actions
    
    @objc private func actionButtonTapped(_ sender: UIButton) {
        // Handle action button tapped
        dismiss(animated: true) {
            // Perform action based on the tapped button
            if let title = sender.title(for: .normal) {
                switch title {
                case "My Account":
                    print("My Account tapped")
                case "Settings":
                    print("Settings tapped")
                case "Logout":
                    print("Logout tapped")
                default:
                    break
                }
            }
        }
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
