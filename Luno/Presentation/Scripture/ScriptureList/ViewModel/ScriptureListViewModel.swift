//
//  ScriptureListViewModel.swift
//  Luno
//
//  Created by Nguyen Trung Kien on 26/3/26.
//

import Foundation
import UIKit

struct ScriptureListViewModelActions {
    
}

protocol ScriptureListViewModelInputs {
    
}

protocol ScriptureListViewModelOutputs {
    
}

protocol ScriptureListViewModel: ScriptureListViewModelInputs, ScriptureListViewModelOutputs {}

class DefaultScriptureListViewModel: ScriptureListViewModel {

    var actions: ScriptureListViewModelActions?
    
    init(actions: ScriptureListViewModelActions? = nil) {
        self.actions = actions
    }

}
