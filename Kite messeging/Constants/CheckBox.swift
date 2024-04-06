//
//  CheckBox.swift
//  Kite messeging
//
//  Created by Admin on 16/03/24.
//

import UIKit

class CheckboxButton: UIButton {
    
    // MARK: - Properties
    
    var isChecked: Bool = false {
        didSet {
            updateCheckboxState()
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCheckbox()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCheckbox()
    }
    
    // MARK: - Private Methods
    
    private func setupCheckbox() {
        addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
        updateCheckboxState()
    }
    
    private func updateCheckboxState() {
        let imageName = isChecked ? "checkbox_checked" : "checkbox_unchecked"
        setImage(UIImage(named: imageName), for: .normal)
    }
    
    // MARK: - Action
    
    @objc private func checkboxTapped() {
        isChecked.toggle()
    }
}

