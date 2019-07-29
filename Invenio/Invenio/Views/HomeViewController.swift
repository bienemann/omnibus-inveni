//
//  ViewController.swift
//  Invenio
//
//  Created by Allan Martins on 29/07/19.
//  Copyright © 2019 Allan Martins. All rights reserved.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {

    @IBOutlet weak var textContainer: UIView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var textContainerBottomConstraint: NSLayoutConstraint!

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        if searchField.isFirstResponder {
            searchField.resignFirstResponder()
        }
    }

}

extension HomeViewController { // Keyboard notification

    @objc func keyboardWillShow(notification: NSNotification) {

        guard
            let userInfo = notification.userInfo,
            let endFrameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
            else {
                return
        }

        if textContainerBottomConstraint.constant == 0 {
            textContainerBottomConstraint.constant = endFrameValue.cgRectValue.height
            UIView.animate(withDuration: animationDuration) {
                self.view.layoutIfNeeded()
            }
        }

    }

    @objc func keyboardWillHide(notification: NSNotification) {

        guard
            let userInfo = notification.userInfo,
            let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
            else {
                return
        }

        if textContainerBottomConstraint.constant != 0 {
            textContainerBottomConstraint.constant = 0
            UIView.animate(withDuration: animationDuration) {
                self.view.layoutIfNeeded()
            }
        }
    }

}

