//
//  UICollectionView+Extensions.swift
//  Luno
//
//  Created by Nguyen Trung Kien on 26/3/26.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(_ indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(identifier)")
        }
        return cell
    }
    
    func register<T: UICollectionViewCell>(_: T.Type) {
        let identifier = String(describing: T.self)
        return register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
}
