//
//  Paginating.swift
//  Luno
//
//  Created by Nguyen Trung Kien on 26/3/26.
//

import Foundation
import CoreGraphics
import UIKit

enum PaginationState {
    case ready
    case waiting
}

enum PaginationDirection {
    case vertical
    case horizontal
}

enum PaginationPosition {
    case top
    case bottom
}

enum PaginationType {
    case top
    case bottom
    case twoWay
}

protocol Paginating: AnyObject {
    
    var paginationThreshold: CGFloat { get }
    var paginationState: PaginationState { get set }
    var paginationDirection: PaginationDirection { get set }
    var paginationType: PaginationType { get set }
    
    var contentSize: CGSize { get }
    var bounds: CGRect { get }
    var isAtTop: Bool { get set }
    var contentOffset: CGPoint { get set }
    var contentInset: UIEdgeInsets { get }
    
    func shouldBeginPaging() -> Bool
    func willBeginPaging(position: PaginationPosition)
    func didCompletePaging()
}

extension Paginating {
    var contentOffsetDelta: CGSize {
            // Tính toán chiều ngang (width/x)
            let widthDelta = contentSize.width - (bounds.size.width + contentOffset.x)
            
            // Tính toán chiều dọc (height/y)
            let heightDelta = contentSize.height - (bounds.size.height + contentOffset.y)
            
            // Gán vào biến delta
            var delta = CGSize(width: widthDelta, height: heightDelta)

            // Cộng thêm contentInset
            delta.width += contentInset.right
            delta.height += contentInset.bottom

            return delta.rounded
        }

    var contentOffsetDeltaValue: CGFloat {
        switch paginationDirection {
        case .horizontal:
            return contentOffsetDelta.width
        case .vertical:
            return contentOffsetDelta.height
        }
    }

    var reachedPagingThreshold: Bool {
        return contentOffsetDeltaValue <= paginationThreshold
    }

    func reachedTopPagingThreshold() -> Bool {
            switch paginationDirection {
            case .horizontal:
                return contentOffset.x <= paginationThreshold + contentInset.left
            case .vertical:
                return contentOffset.y <= paginationThreshold + contentInset.top
            }
        }

    var hasContent: Bool {
        switch paginationDirection {
        case .horizontal:
            return contentSize.width > 0.0
        case .vertical:
            return contentSize.height > 0.0
        }
    }

    var hasBounds: Bool {
        bounds.width > 0 && bounds.height > 0
    }

    func beginPaging(position: PaginationPosition = .bottom) {
        guard shouldBeginPaging() else { return }
        guard allowPagination(position: position) else { return }
        willBeginPaging(position: position)
        paginationState = .waiting
    }

    func allowPagination(position: PaginationPosition) -> Bool {
        if paginationType == .twoWay {
            return true
        }

        if position == .top && paginationType == .top {
            return true
        }

        if position == .bottom && paginationType == .bottom {
            return true
        }

        return false
    }

    func completePaging() {
        paginationState = .ready
        didCompletePaging()
    }

    func shouldBeginPaging() -> Bool {
        false
    }

    func willBeginPaging(position: PaginationPosition = .bottom) {
        beginPaging(position: position)
    }

    func didCompletePaging() {
        completePaging()
    }
}

private extension CGSize {
    var rounded: CGSize {
        CGSize(width: round(width), height: round(height))
    }
}

extension Paginating {
    func trackPaging() {
        guard hasContent, hasBounds, paginationState == .ready else {
            return
        }
        
        if paginationDirection == .horizontal {
            if reachedPagingThreshold {
                beginPaging(position: .bottom)
            }
        } else {
            if reachedPagingThreshold {
                beginPaging(position: .bottom)
            } else if reachedTopPagingThreshold() {
                if !isAtTop {
                    isAtTop = true
                    beginPaging(position: .top)
                }
            } else {
                isAtTop = false
            }
        }
    }
}
