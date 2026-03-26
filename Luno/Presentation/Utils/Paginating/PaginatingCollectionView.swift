//
//  PaginatingCollectionView.swift
//  Luno
//
//  Created by Nguyen Trung Kien on 26/3/26.
//

import Foundation
import UIKit



protocol PaginatingCollectionViewDelegate: AnyObject {
    func collectionViewShouldBeginPaging(_ collectionView: PaginatingCollectionView) -> Bool
    func collectionViewWillBeginPaging(_ collectionView: PaginatingCollectionView, atPosition position: PaginationPosition)
    func collectionViewDidCompletePaging(_ collectionView: PaginatingCollectionView)
}

final class PaginatingCollectionView: UICollectionView, Paginating {
    var isAtTop: Bool = true
    weak var paginationDelegate: PaginatingCollectionViewDelegate?

    var paginationThreshold: CGFloat = 0
    var paginationState: PaginationState = .ready
    var paginationDirection: PaginationDirection = .vertical
    var paginationType: PaginationType = .bottom

    override func layoutSubviews() {
        super.layoutSubviews()

        trackPaging()
    }

    func shouldBeginPaging() -> Bool {
        paginationDelegate?.collectionViewShouldBeginPaging(self) ?? false
    }

    func willBeginPaging(position: PaginationPosition) {
        paginationDelegate?.collectionViewWillBeginPaging(self, atPosition: position)
    }

    func didCompletePaging() {
        paginationDelegate?.collectionViewDidCompletePaging(self)
    }
}
