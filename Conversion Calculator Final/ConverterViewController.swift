//
//  ConverterViewController.swift
//  Conversion Calculator Final
//
//  Created by Sean Buchholz on 12/8/17.
//  Copyright © 2017 Sean Buchholz. All rights reserved.
//
import UIKit
class ConverterViewController: UIViewController { var converters = [
    Converter(label: "Fahrenheit to Celcius", iU: "°F", oU: "°C", convert: {x in return ((x-32)/1.8)}),
    Converter(label: "Celcius to Fahrenheit", iU: "°C", oU: "°F", convert: {x in return ((x*1.8)+32)}),
    Converter(label: "Miles to Kilometers", iU: "Mi", oU: "Km", convert: {x in return (x*1.609)}),
    Converter(label: "Kilometers to Miles", iU: "Km", oU: "Mi", convert: {x in return (x*0.621)}) ]
    var currentConverter: Converter?
    var oUS: String = ""
    var oS: String = ""
    var iS: String = ""
    var iUS: String = ""
@IBOutlet weak var outputDisplay: UITextField!
@IBOutlet weak var inputDisplay: UITextField!
@IBAction func convert(_ sender: UIButton) { let alert = UIAlertController(title:"Choose A Converter From The List Below:", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        for converter in converters { alert.addAction(UIAlertAction(title: converter.label, style: UIAlertActionStyle.default, handler: { (alertAction) -> Void in
                self.iUS = converter.iU
                self.oUS = converter.oU
                self.currentConverter = converter
                self.updateCalculator() })) }
        self.present(alert, animated: true, completion: nil) }
@IBAction func addDigit(_ sender: UIButton) { if currentConverter == nil { return }
        let button = sender as UIButton
        if(button.tag == -1){ if iS.contains(".") || iS.count == 0 { return }
        iS.append(".") } else { iS.append(String(button.tag)) }
        updateCalculator() }
@IBAction func clear(_ sender: Any) { iS = ""; oS = ""; updateCalculator() }
@IBAction func changeSign(_ sender: Any) { if iS.count == 0{ return } else if iS.contains("-") { iS.remove(at: (iS.startIndex)) } else { iS.insert("-", at: (iS.startIndex)) }
        updateCalculator() }
    func updateCalculator(){ guard let converter = currentConverter else { return }
        if(iS.count == 0){ inputDisplay.text = iUS; outputDisplay.text = oUS; return }
        var output: Double
        var value: Double
        inputDisplay.text = iS + " " + iUS
        value = Double(iS) ?? 0
        output = converter.convert(value)
        oS = String(format: "%.2f", output)
        outputDisplay.text = oS + " " + oUS }
    override func viewDidLoad() { super.viewDidLoad() }
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() } }
