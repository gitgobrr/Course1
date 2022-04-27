//
//  ViewController.swift
//  Course1
//
//  Created by Devloper on 12.02.2020.
//  Copyright © 2020 Devloper. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        let label = NSTextField(labelWithString: "Look at me!")
//        label.leadingAnchor.constraint(equalTo: cotCheck.leadingAnchor, constant: 0)
//        label.topAnchor.constraint(equalTo: cotCheck.bottomAnchor, constant: 10)
//        label.trailingAnchor.constraint(lessThanOrEqualTo: graphView.leadingAnchor, constant: 30)
//        
//        view.addSubview(label)
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBOutlet weak var graphView: Graph!
    
    @IBOutlet weak var sinParams: NSStackView!
    @IBOutlet weak var cosParams: NSStackView!
    @IBOutlet weak var tanParams: NSStackView!
    @IBOutlet weak var cotParams: NSStackView!
    
    @IBAction func lowerBound(_ sender: NSTextField) {
        let params = [sinParams,cosParams,tanParams,cotParams]
        for param in params {
            let field = param!.arrangedSubviews[3] as! NSTextField
            field.doubleValue = sender.doubleValue
        }
    }
    @IBAction func upperBound(_ sender: NSTextField) {
        let params = [sinParams,cosParams,tanParams,cotParams]
        for param in params {
            let field = param!.arrangedSubviews[4] as! NSTextField
            field.doubleValue = sender.doubleValue
        }
    }
    
    @IBOutlet weak var sinCheck: NSButton!
    @IBOutlet weak var cosCheck: NSButton!
    @IBOutlet weak var tanCheck: NSButton!
    @IBOutlet weak var cotCheck: NSButton!
    
    @IBAction func sinChecked(_ sender: Any) {
        graphView.setNeedsDisplay(graphView.visibleRect)
    }
    @IBAction func cosChecked(_ sender: Any) {
        graphView.setNeedsDisplay(graphView.visibleRect)
    }
    @IBAction func tanChecked(_ sender: Any) {
        graphView.setNeedsDisplay(graphView.visibleRect)
    }
    @IBAction func cotChecked(_ sender: Any) {
        graphView.setNeedsDisplay(graphView.visibleRect)
    }
    
    
    @IBAction func redrawView(_ sender: Any) {
        graphView.setNeedsDisplay(graphView.visibleRect)
    }
    @IBAction func clearView(_ sender: Any) {
        sinCheck.state = .off
        cosCheck.state = .off
        tanCheck.state = .off
        cotCheck.state = .off
        graphView.setNeedsDisplay(graphView.visibleRect)
    }
    
    @IBOutlet weak var separatorInset: NSTextField!
    @IBAction func insetChanged(_ sender: Any) {
        guard separatorInset.integerValue > 19 else {
            separatorInset.integerValue = 20
            graphView.separatorInset = separatorInset.integerValue
            separatorInset.stringValue = String(graphView.separatorInset)
            graphView.setNeedsDisplay(graphView.visibleRect)
            return
        }
        graphView.separatorInset = separatorInset.integerValue
        separatorInset.stringValue = String(graphView.separatorInset)
        graphView.setNeedsDisplay(graphView.visibleRect)
    }
    
    @IBAction func zoomIn(_ sender: Any) {
        graphView.separatorInset += 1
        separatorInset.stringValue = String(graphView.separatorInset)
        graphView.setNeedsDisplay(graphView.visibleRect)
    }
    @IBAction func zoomOut(_ sender: Any) {
        guard graphView.separatorInset > 20 else {return}
        graphView.separatorInset -= 1
        separatorInset.stringValue = String(graphView.separatorInset)
        graphView.setNeedsDisplay(graphView.visibleRect)
    }
    
    var labels: [NSTextField]!
    
}

