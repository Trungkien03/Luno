//
//  ScriptureDetailViewModel.swift
//  Luno
//
//  Created by Nguyen Trung Kien on 26/3/26.
//

import Foundation
import UIKit

struct ScriptureDetailViewModelActions {
    
}

protocol ScriptureDetailViewModelInputs {
    
}

protocol ScriptureDetailViewModelOutputs {
    var scriptureId: String? { get set }
}

protocol ScriptureDetailViewModel: ScriptureDetailViewModelInputs, ScriptureDetailViewModelOutputs {}

class DefaultScriptureDetailViewModel: ScriptureDetailViewModel {

    var actions: ScriptureDetailViewModelActions?
    
    var scriptureId: String?
    
    init(actions: ScriptureDetailViewModelActions? = nil) {
        self.actions = actions
    }

}
