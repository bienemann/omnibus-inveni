//
//  CustomPopupProtocol.swift
//
//
//  Created by Allan Martins on 25/10/17.
//  All rights reserved.
//

import Foundation
import UIKit

public protocol CustomPopupProtocol: class {
    
    var dismissOnTouchOutside: Bool { get set }
    var view: UIView! { get set }
    var controller: CustomPopupController? { get set }
    
    func dismiss(animated: Bool, _ handler: DidFinishDismissingHandler?)
    func show(animated: Bool)
    init()
    init(nibName: String, bundle: Bundle)
}

extension CustomPopupProtocol {

    init(nibName: String, bundle: Bundle) {
        self.init()
        let nib = UINib(nibName: nibName, bundle: bundle)
        nib.instantiate(withOwner: self, options: nil)
    }
    
    public func show(animated: Bool) {
        self.controller = CustomPopupController(self)
        self.fixDimensions()
        self.controller!.show(animated)
    }
    
    public func fixDimensions() {
        self.controller?.alertWidthConstraint.constant = self.view.bounds.width
        self.controller?.alertHeightConstraint.constant = self.view.bounds.height
        self.controller?.view?.layoutIfNeeded()
    }
    
    func dismiss(animated: Bool, _ handler: DidFinishDismissingHandler? = nil) {
        guard let controller = self.controller else {
            return
        }
        controller.dismiss(animated, handler: handler)
    }
    
}
