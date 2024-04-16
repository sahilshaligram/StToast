//
//  ViewController.swift
//  StToast
//
//  Created by sahilthaker on 09/15/2023.
//  Copyright (c) 2023 sahilthaker. All rights reserved.
//

import UIKit
import StToast

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showToastTapped(_ sender: UIButton) {
        StCustomToast(
            controller: self,
            msg: "StToast Testing!!!!!",
            font: .systemFont(ofSize: 18),
            backgroundColor: .black,
            textColor: .white,
            borderColor: .systemPurple,
            type: .warning,
            position: .top,
            delay: 1.5
        ).show()
    }

}

