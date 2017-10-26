//
//  ViewController.swift
//  Fruit_parsing
//
//  Created by 김종현 on 2017. 10. 21..
//  Copyright © 2017년 김종현. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {
    
    var item:[String:String] = [:]
    var elements:[[String:String]] = []
    var currentElement = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let strURL = "http://api.androidhive.info/pizza/?format=xml"
        
        if let path = Bundle.main.url(forResource: "Fruit", withExtension: "xml") {
        
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                //print(path)
                
                if parser.parse() {
                    print("parsing success!")
                    print(elements)
                } else {
                    print("parsing failed!!")
                }
            }
        } else {
            print("xml file not found!!")
        }
 
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        print("elementName = \(elementName)")
        
        currentElement = elementName
        
        if elementName == "item" {
            item = [:]
        } else if elementName == "elements" {
            elements = []
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        print("data =  \(data)")
        if !data.isEmpty {
            item[currentElement] = string
       
            print("currentElement = \(currentElement)")
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item" {
            elements.append(item)
            print("item = \(item)")
            print("elements = \(elements)")
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("failure error: ", parseError)
    }
}

