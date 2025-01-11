//
//  Tasks+ViewModel.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/11/25.
//

import Foundation
import SwiftUI

extension Tasks {
    @Observable
    class ViewModel {
        private var dataService: DataService
        
        init(dataService: DataService) {
            self.dataService = dataService
        }
        
        func onAppear() {
            dataService.getTasks()
        }
    }
}
