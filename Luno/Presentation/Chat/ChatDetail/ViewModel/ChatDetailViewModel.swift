//
//  ChatDetailViewModel.swift
//  iOS_CleanArchitecture
//
//  Created by Nguyen Trung Kien on 19/3/26.
//

import Foundation


struct ChatDetailViewModelActions {
    
}

protocol ChatDetailViewModelInputs {
    
}

protocol ChatDetailViewModelOutputs {
    var conversationId: String? { get set }
}

protocol ChatDetailViewModel: ChatDetailViewModelInputs, ChatDetailViewModelOutputs {
    
}

class DefaultChatDetailViewModel: ChatDetailViewModel {
    
    var actions: ChatDetailViewModelActions?
    public var conversationId: String?
    
    init(actions: ChatDetailViewModelActions? = nil) {
        self.conversationId = nil
        self.actions = actions
    }
}
