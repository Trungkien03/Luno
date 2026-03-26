//
//  ScriptureListViewModel.swift
//  Luno
//
//  Created by Nguyen Trung Kien on 26/3/26.
//

import Foundation
import UIKit

struct ScriptureSection: Hashable, Sendable {
    let id: UUID
    let title: String
    
}

struct ScriptureItem: Hashable, Sendable {
    let id = UUID()
    let title: String
    let description: String
    let iconName: String
}

struct ScriptureListViewModelActions {

}

protocol ScriptureListViewModelInputs {

}

protocol ScriptureListViewModelOutputs {

}

protocol ScriptureListViewModel: ScriptureListViewModelInputs,
    ScriptureListViewModelOutputs
{}

class DefaultScriptureListViewModel: ScriptureListViewModel {

    var actions: ScriptureListViewModelActions?

    init(actions: ScriptureListViewModelActions? = nil) {
        self.actions = actions
    }

}
