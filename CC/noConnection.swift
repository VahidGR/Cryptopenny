//
//  noConnection.swift
//  CC
//
//  Created by Vahid Ghanbarpour on 12/6/17.
//  Copyright © 2017 Vahid Ghanbarpour. All rights reserved.
//

import UIKit

class noConnection: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: "344f8d")
        
        let noConnectionLabel = UILabel(frame: CGRect(x: 0, y: (view.frame.size.height / 2) - 60, width: view.frame.size.width, height: 60))
        noConnectionLabel.numberOfLines = 0
        noConnectionLabel.textColor = .white
        noConnectionLabel.textAlignment = .center
        noConnectionLabel.text = "No internet connection found, check your connection and try again"
        view.addSubview(noConnectionLabel)
        
        let reloadButton = UIButton(frame: CGRect(x: (view.frame.size.width / 2) - 75, y: view.frame.size.height / 2, width: 150, height: 50))
        reloadButton.addTarget(self, action: #selector(checkForConnection), for: .touchUpInside)
        reloadButton.titleLabel?.textColor = .white
        reloadButton.titleLabel?.text = "Try again"
        reloadButton.setTitle("Try again", for: .normal)
        reloadButton.layer.cornerRadius = 0.2 * reloadButton.frame.width
        reloadButton.layer.cornerRadius = 0.2 * reloadButton.frame.height
        reloadButton.backgroundColor = UIColor(hex: "2c3881")
        view.addSubview(reloadButton)
    }
    
    @objc func checkForConnection() {
        if Reachability.isConnectedToNetwork() {
            self.dismiss(animated: true, completion: nil)
            Global.internetStatus = true
        } else {
            let NCLabel = UILabel(frame: CGRect(x: 0, y: view.frame.size.height - 120, width: view.frame.size.width, height: 120))
            NCLabel.textAlignment = .center
            NCLabel.textColor = .white
            NCLabel.text = "Still no data transfered"
            view.addSubview(NCLabel)
        }
    }
}
