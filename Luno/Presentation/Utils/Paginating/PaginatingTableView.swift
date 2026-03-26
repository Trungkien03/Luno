//
//  PaginatingTableView.swift
//  Luno
//
//  Created by Nguyen Trung Kien on 26/3/26.
//

import Foundation
import UIKit

protocol PaginatingTableViewDelegate: AnyObject {
    func tableViewShouldBeginPaging(_ tableView: PaginatingTableView) -> Bool
    func tableViewWillBeginPaging(_ tableView: PaginatingTableView)
    func tableViewWillBeginPaging(_ tableView: PaginatingTableView,position: PaginationPosition)
    func tableViewDidCompletePaging(_ tableView: PaginatingTableView)
}


final class PaginatingTableView: UITableView, Paginating {

    var isAtTop: Bool = false

    weak var paginationDelegate: PaginatingTableViewDelegate?

    var paginationThreshold: CGFloat = 200
    var paginationState: PaginationState = .ready
    var paginationDirection: PaginationDirection = .vertical
    var paginationType: PaginationType = .bottom

    override func layoutSubviews() {
        super.layoutSubviews()

        trackPaging()
    }

    func shouldBeginPaging() -> Bool {
        paginationDelegate?.tableViewShouldBeginPaging(self) ?? false
    }

    func willBeginPaging() {
        paginationDelegate?.tableViewWillBeginPaging(self)
        paginationDelegate?.tableViewWillBeginPaging(self,position: .bottom)
    }
    
    func willBeginPaging(position: PaginationPosition) {
        paginationDelegate?.tableViewWillBeginPaging(self)
        paginationDelegate?.tableViewWillBeginPaging(self,position: position)
    }

    func didCompletePaging() {
        paginationDelegate?.tableViewDidCompletePaging(self)
    }
    
    //Callback when tableview reload, using to check validate or show/hide emptyview
    var onReload: (() -> Void)?
    
    override func reloadData() {
        super.reloadData()
        onReload?() // Callback when reload itself
    }
    
    override func reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        super.reloadRows(at: indexPaths, with: animation)
        onReload?()
    }
    
    override func reloadSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
        super.reloadSections(sections, with: animation)
        onReload?()
    }
}
