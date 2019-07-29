//
//  PopupListController.swift
//  Invenio
//
//  Created by Allan Martins on 29/07/19.
//  Copyright © 2019 Allan Martins. All rights reserved.
//

import UIKit
import OlhoVivoSDK

protocol LinesPopupProtocol: CustomPopupProtocol {
    func show(lines: [OVLine], dismissHandler: DidFinishDismissingHandler?)
}

class LinesPopupController: NSObject, LinesPopupProtocol {

    var dismissOnTouchOutside: Bool = true
    var controller: CustomPopupController?

    @IBOutlet weak internal var view: UIView!
    @IBOutlet weak private var lblMessage: UILabel!
    @IBOutlet weak private var btnAcept: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewContainerHeight: NSLayoutConstraint!

    var linesDataSource: [OVLine]?
    var finishHandler: DidFinishDismissingHandler?

    required override init() {}

    @IBAction private func aceptAndDismiss(_ sender: Any) {
        finishHandler?()
        self.dismiss(animated: true)
    }

    func show(lines: [OVLine], dismissHandler: DidFinishDismissingHandler?) {
        linesDataSource = lines
        self.show(animated: true, handler: dismissHandler)
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

extension LinesPopupController: UITableViewDelegate {

}

extension LinesPopupController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return linesDataSource?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let lines = linesDataSource else { return UITableViewCell() }

        let cell = UITableViewCell(style: .default, reuseIdentifier: "identi")
        let line = lines[indexPath.row]

        let name = line.direction == .inbound ? line.inboundName : line.outboundName
        cell.textLabel?.text = lines[indexPath.row].lineNumber + " - " + name
        return cell
    }


}
