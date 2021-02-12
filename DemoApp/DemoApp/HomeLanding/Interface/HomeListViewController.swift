//
//  HomeLandingViewController.swift
//  DemoApp
//
//  Created by Vishnu Dayal on 12/02/21.
//

import Foundation
import UIKit
import SwiftUI

class HomeLandingViewController: UIViewController {

    @IBSegueAction func showDetails(_ coder: NSCoder) -> UIViewController? {
        let listView = FlightListView()
        return UIHostingController(coder: coder, rootView: listView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // some code

    }
}


class MyHostViewController: UIHostingController<FlightListView> {
    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: FlightListView());
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

