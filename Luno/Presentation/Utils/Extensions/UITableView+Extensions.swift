//
//  UITableView+Extensions.swift
//  Luno
//
//  Created by Nguyen Trung Kien on 26/3/26.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: identifier) as? T
        else {
            fatalError("Could not dequeue cell with identifier: \(identifier)")
        }

        return cell
    }

    func register<T: UITableViewCell>(_: T.Type) {
        let identifier = String(describing: T.self)
        return register(
            UINib(nibName: identifier, bundle: nil),
            forCellReuseIdentifier: identifier
        )
    }

    func registerView<T: UIView>(_: T.Type) {
        let identifier = String(describing: T.self)
        return register(
            UINib(nibName: identifier, bundle: nil),
            forHeaderFooterViewReuseIdentifier: identifier
        )
    }

}

extension UITableView {

    func scrollToBottom(animated: Bool = true) {
        DispatchQueue.main.async {
            var yOffset: CGFloat = 0.0
            if self.contentSize.height > self.bounds.size.height {
                yOffset = self.contentSize.height - self.bounds.size.height
            }
            self.setContentOffset(CGPoint(x: 0, y: yOffset), animated: animated)
        }
    }

    func scrollToBottoms(_ animated: Bool = true) {
        let numberOfSections = self.numberOfSections
        if numberOfSections > 0 {
            let numberOfRows = self.numberOfRows(
                inSection: numberOfSections - 1
            )
            if numberOfRows > 0 {
                let indexPath = IndexPath(
                    row: numberOfRows - 1,
                    section: (numberOfSections - 1)
                )
                self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
            }
        }
    }

    func returnIndexPath(cell: UITableViewCell) -> IndexPath? {
        guard let indexPath = self.indexPath(for: cell) else {
            return nil
        }
        return indexPath
    }
}
