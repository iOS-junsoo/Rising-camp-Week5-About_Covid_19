//
//  firstViewController.swift
//  About-Covid-19
//
//  Created by 준수김 on 2021/10/13.
//

import UIKit
import MarqueeLabel

class firstViewController: UIViewController, XMLParserDelegate {

    var xmlParser = XMLParser()
    
    var currentElement = ""
    var items = [[String : String]]()
    var item = [String : String]()
    
    var covidgubun = "" //시도명
    var covidincDec = "" //전일 대비 증감 수
    var coviddefCnt = "" //코로나 확진자 수
    var covidisolIngCnt = "" //현재 격리중인 환자 수
    
    @IBOutlet weak var marqueeLabel: MarqueeLabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.marqueeLabel.type = .continuous
        self.marqueeLabel.speed = .duration(15)
        self.marqueeLabel.animationCurve = .easeInOut
        self.marqueeLabel.fadeLength = 10.0
        self.marqueeLabel.leadingBuffer = 30.0
        
        let strings = ["오늘의 총 확진자 수는 165명 입니다. 전일 대비 확진자 수가 총 29명이 증가하였으니 개인 소독에 집중하는 하루되시길 바랍니다."]
        
        self.marqueeLabel.text = strings[Int(arc4random_uniform(UInt32(strings.count)))]
        requestCovidInfo()
    }
    
    func requestCovidInfo() {
        
        //MARK: - view가 load 되는 현재 시간 저장
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let current_date_string = formatter.string(from: Date())
        //print(current_date_string)
        
        let url = "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson?serviceKey=2yD7EAVjVn6s7TOB869TohgRaubtsfz2hXk2RZKdv%2FHPLcJiFtZobJXfo2w7W4d%2F55NE6nJccDXb9km9qifGRA%3D%3D&pageNo=1&numOfRows=10&startCreateDt=\(current_date_string)&endCreateDt=\(current_date_string)"
        
        guard let xmlParser = XMLParser(contentsOf: URL(string: url)!) else { return }
        xmlParser.delegate = self
        xmlParser.parse()
  
    }
    //MARK: - XML 파서가 시작 테그를 만나면 호출됨
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if elementName == "item" {
            item = [String : String]()
            covidgubun = ""
            covidincDec = ""
            coviddefCnt = ""
            covidisolIngCnt = ""
            //print("didStartElement")
        }
    }
    //MARK: - XML 파서가 종료 테그를 만나면 호출됨
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            item["gubun"] = covidgubun
            item["incDec"] = covidincDec
            item["defCnt"] = coviddefCnt
            item["isolIngCnt"] = covidisolIngCnt
            items.append(item)

            //print("didEndElement")
        }
        
    }
    //MARK: - 현재 테그에 담겨있는 문자열 전달
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        //print("foundCharacters")
        
        if currentElement == "gubun" {
            covidgubun = string
            print("시도명: \(covidgubun)")
            //print("foundCharacters1")
        } else if (currentElement == "incDec") {
            covidincDec = string
            print("오늘 확진자 수 :\(covidincDec)")
            //print("foundCharacters2")
        } else if (currentElement == "defCnt") {
            coviddefCnt = string
            print("총 확진자 수:\(coviddefCnt)")
            //print("foundCharacters2")
        } else if (currentElement == "isolIngCnt") {
            covidisolIngCnt = string
            print("격리중인 환자 수:\(covidisolIngCnt)")
            print("-----------------------")
            //print("foundCharacters2")
        }
    }

}
