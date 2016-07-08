//
//  ViewController.swift
//  LeastResistanceKata
//
//  Created by Jeremy Winters on 7/5/16.
//  Copyright © 2016 Jeremy Winters. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var inputGrid: UITextView!
    @IBOutlet weak var outputArea: UITextView!
    
    var leastResistanceCalculator = LeastResistanceCalculator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func calculateShortestPath(sender: UIButton) {
        outputArea.text = leastResistanceCalculator.calculateLeastResistance(inputGrid.text)
    }
}
