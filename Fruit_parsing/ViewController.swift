import UIKit

class ViewController: UIViewController, XMLParserDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var strXMLData: String = ""
    var item:[String:String] = [:]
    var elements:[[String:String]] = []
    var currentElement = ""
    @IBOutlet weak var mytable: UITableView!

    //JDth = 사상자 (주니어 Death)
    //Dth = 사망자 (Death)
    //MDth = 중상자 (Medium)
    //LDth = 경상자 (Light)
    //EA = 발생건수
    //Crash = 사고가난곳
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.url(forResource: "walkc", withExtension: "xml") {
            
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                //print(path)
                
                if parser.parse() {
                    print("parsing success!")
                    //print("strXMLData = \(strXMLData)")
                    //poopoo.text = strXMLData
                    
                } else {
                    print("parsing failed!!")
                }
            }
        } else {
            print("xml file not found!!")
        }
        
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        print("********elementName = \(elementName)")
        
        currentElement = elementName
        
        if elementName == "item" {
            item = [:]
        } else if elementName == "elements" {
            elements = []
        }
        print("++1")
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        print("data =  \(data)")
        if !data.isEmpty {
            item[currentElement] = data
            strXMLData = strXMLData + "\n\n" + item[currentElement]!
            print(strXMLData)
            
        }
        print("++2")
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            elements.append(item)
        }
        print("++3")
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("failure error: ", parseError)

    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
   
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return item.count
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myCell: papoo = mytable.dequeueReusableCell(withIdentifier:"myCell",for: indexPath) as! papoo
        
        myCell.Crash?.text = item["spotname"]
        myCell.JDth?.text = "사상자 수 : " + item["dthinj_co"]!
        myCell.EA?.text = "발생건 수 : " + item["occrrnc_co"]!
        myCell.Dth?.text = "사망자 수 : " + item["death_co"]!
        myCell.MDth?.text = "중상자 수 : " + item["serinj_co"]!
        myCell.LDth?.text = "경상자 수 : " + item["ordnr_co"]!



        
        return myCell
        
        
    }

    
}
