//
//  BanderaView.swift
//  MapaDef
//
//  Created by user130165 on 12/2/17.
//  Copyright © 2017 KevinGonzalez. All rights reserved.
//

import UIKit

class BanderaView: UIViewController {
    
    @IBOutlet weak var lblPais: UILabel!
    @IBOutlet weak var viewBandera: UIImageView!
    
    override func viewDidLoad() {
        lblPais.text = paisSelecinado
        viewBandera.image = UIImage(named: paisSelecinado)
    }
}
