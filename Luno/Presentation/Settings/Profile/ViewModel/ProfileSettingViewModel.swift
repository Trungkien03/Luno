//
//  ProfileViewModel.swift
//  iOS_CleanArchitecture
//
//  Created by Nguyen Trung Kien on 19/3/26.
//

import Foundation

struct ProfileSettingViewModelActions {
    
}

protocol ProfileSettingViewModelInputs {
    
}

protocol ProfileSettingViewModelOutputs {
    
}

protocol ProfileSettingViewModel: ProfileSettingViewModelInputs, ProfileSettingViewModelOutputs {}

class DefaultProfileViewModel: ProfileSettingViewModel {
    var actions: ProfileSettingViewModelActions?
    
    init(actions: ProfileSettingViewModelActions? = nil) {
        self.actions = actions
    }
}
