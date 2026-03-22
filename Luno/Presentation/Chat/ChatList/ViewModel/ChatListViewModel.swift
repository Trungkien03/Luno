//
//  ChatListViewModel.swift
//  iOS_CleanArchitecture
//
//  Created by Nguyen Trung Kien on 19/3/26.
//

import UIKit

struct ChatListViewModelActions {
    
}

protocol ChatListViewModelInputs {
    
}

protocol ChatListViewModelOutputs {
    
}

protocol ChatListViewModel: ChatListViewModelInputs, ChatListViewModelOutputs {}

class DefaultChatListViewModel: ChatListViewModel {

    var actions: ChatListViewModelActions?
    
    init(actions: ChatListViewModelActions? = nil) {
        self.actions = actions
    }

}
