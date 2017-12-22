//
//  Menu.swift
//  MapaDef
//
//  Created by user130165 on 12/1/17.
//  Copyright © 2017 KevinGonzalez. All rights reserved.
//

import UIKit

var elegido = 0

class Menu: UIViewController {
    
    @IBAction func showMap(_ sender: UIButton) {
        elegido = sender.tag
        performSegue(withIdentifier: "toMap", sender: sender)
    }
    
}
