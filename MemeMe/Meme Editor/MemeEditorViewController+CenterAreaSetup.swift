//
//  MemeEditorViewController+CenterAreaSetup.swift
//  MemeMe
//
//  Created by Jonathan De Araújo Silva on 22/08/22.
//

import UIKit

extension MemeEditorViewController: UITextFieldDelegate {
    func setupCenterAreaAndAttachTo(container: UIStackView) {
        imageView = UIImageView(frame: container.bounds)
        imageView.center = container.center
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        container.addArrangedSubview(imageView)
        imageView.backgroundColor = .black


        imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.8).isActive = true
        imageView.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true

        let textFont = UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
        UIFontMetrics(forTextStyle: .body).scaledFont(for: textFont)

        topText = UITextField(frame: imageView.frame)
        imageView.addSubview(topText)
        topText.translatesAutoresizingMaskIntoConstraints = false
        topText.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 24).isActive = true
        topText.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        topText.text = MemeEditorViewController.TOP_TEXT
        topText.autocapitalizationType = .allCharacters
        topText.defaultTextAttributes = [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: textFont,
        ]
        topText.delegate = self

        bottomText = UITextField(frame: imageView.frame)
        imageView.addSubview(bottomText)
        bottomText.translatesAutoresizingMaskIntoConstraints = false
        bottomText.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -24).isActive = true
        bottomText.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        bottomText.text = MemeEditorViewController.BOTTOM_TEXT
        bottomText.autocapitalizationType = .allCharacters
        bottomText.defaultTextAttributes = [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: textFont
        ]
        bottomText.delegate = self
        bottomText.adjustsFontForContentSizeCategory = true
    }

    @objc func keyboardWillAppear(_ notification: Notification) {
        if !isKeyboardOpen && bottomText.isEditing {
            isKeyboardOpen = true
            let userInfo = notification.userInfo
            let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
            view.frame.origin.y -= keyboardSize.cgRectValue.height
        }
    }

    @objc func keyboardWillDisappear(_ notification: Notification) {
        if isKeyboardOpen && bottomText.isEditing {
            isKeyboardOpen = false
            let userInfo = notification.userInfo
            let keyboardSize = userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
            view.frame.origin.y += keyboardSize.cgRectValue.height
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.saveMeme()
    }
}

