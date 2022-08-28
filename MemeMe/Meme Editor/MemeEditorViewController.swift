//
//  ViewController.swift
//  MemeMe
//
//  Created by Jonathan De Araújo Silva on 05/08/22.
//

import UIKit

class MemeEditorViewController: UIViewController {

    static let TOP_TEXT = "TOP TEXT"
    static let BOTTOM_TEXT = "BOTTOM TEXT"

    var topText: UITextField!
    var bottomText: UITextField!
    var shareButton: UIButton!
    var cancelButton: UIButton!
    var cameraButton: UIButton!
    var albumButton: UIButton!
    var imageView: UIImageView!
    var screenStack: UIStackView!
    var isKeyboardOpen = false
    var meme: Meme?
    var memedImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .black
        screenStack = UIStackView(frame: view.frame)
        view.addSubview(screenStack)

        screenStack.axis = .vertical
        screenStack.alignment = .fill
        screenStack.distribution = .fillEqually

        screenStack.translatesAutoresizingMaskIntoConstraints = false
        screenStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        screenStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        screenStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        screenStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        setupTopAreaAndAttachTo(container: screenStack)
        setupCenterAreaAndAttachTo(container: screenStack)
        setupBottomAreaAndAttachTo(container: screenStack)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let isCameraAvailable = UIImagePickerController.isSourceTypeAvailable(.camera)
        if !isCameraAvailable {
            cameraButton.isEnabled = false
            cameraButton.layer.opacity = 0.5
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

