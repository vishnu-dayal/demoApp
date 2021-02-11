//
//  FlightListPresenter.swift
//  DemoApp
//
//  Created by Vishnu Dayal on 11/02/21.
//

import Foundation
import Combine
import SwiftUI

protocol ListInputProtocols {
    var delegate: ListOutputProtocols? {set get}
    
}

protocol ListOutputProtocols {
    
}

class FlightListPresenter: ObservableObject, ListInputProtocols {
    var delegate: ListOutputProtocols?
    var interactor: ListInteractorInputProtocols?
    init() {
//        interactor = FlightListInteractor()
    }
}

extension FlightListPresenter: ListInteractorOutputProtocols {
    
}
