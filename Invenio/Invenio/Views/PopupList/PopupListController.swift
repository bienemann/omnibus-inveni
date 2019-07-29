//
//  PopupListController.swift
//  Invenio
//
//  Created by Allan Martins on 29/07/19.
//  Copyright © 2019 Allan Martins. All rights reserved.
//

import UIKit

class PopupListController: NSObject, CustomPopupProtocol {

    var dismissOnTouchOutside: Bool = true
    var controller: CustomPopupController?

    @IBOutlet weak internal var view: UIView!
    @IBOutlet weak private var lblMessage: UILabel!
    @IBOutlet weak private var btnAcept: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewContainerHeight: NSLayoutConstraint!

    var buttonTitle: String?
    var finishHandler: DidFinishDismissingHandler?

    required override init() {}

    @IBAction private func aceptAndDismiss(_ sender: Any) {
        finishHandler?()
        self.dismiss(animated: true)
    }

    public func show(animated: Bool, handler: DidFinishDismissingHandler?) {

        self.view.layer.cornerRadius = 5.0

        tableView.reloadData()

        let contentSize = tableView.contentSize.height
        tableViewContainerHeight.constant = contentSize <= 352 ? contentSize : 352
        self.view.layoutIfNeeded()

        self.show(animated: animated)
        self.finishHandler = handler
    }

}

extension PopupListController: UITableViewDelegate {

}

extension PopupListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "identi")
        cell.textLabel?.text = "dhgfsahjdha"
        return cell
    }


}
