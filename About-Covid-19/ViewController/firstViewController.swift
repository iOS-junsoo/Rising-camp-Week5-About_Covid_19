//
//  firstViewController.swift
//  About-Covid-19
//
//  Created by 준수김 on 2021/10/13.
//

import UIKit
import MarqueeLabel

class firstViewController: UIViewController, XMLParserDelegate {
    
    //총확진자 수
    @IBOutlet weak var seoulStateLabel: UILabel!
    @IBOutlet weak var jejuStateLabel: UILabel!
    @IBOutlet weak var gyeongnamStateLabel: UILabel!
    @IBOutlet weak var gyeongbukStateLabel: UILabel!
    @IBOutlet weak var jeonnamStateLabel: UILabel!
    @IBOutlet weak var jeonbukStateLabel: UILabel!
    @IBOutlet weak var chungnamStateLabel: UILabel!
    @IBOutlet weak var chungbukStateLabel: UILabel!
    @IBOutlet weak var gangwonStateLabel: UILabel!
    @IBOutlet weak var gyeonggiStateLabel: UILabel!
    @IBOutlet weak var sejongStateLabel: UILabel!
    @IBOutlet weak var ulsanStateLabel: UILabel!
    @IBOutlet weak var daejeonStateLabel: UILabel!
    @IBOutlet weak var gwangjuStateLabel: UILabel!
    @IBOutlet weak var incheonStateLabel: UILabel!
    @IBOutlet weak var daeguStateLabel: UILabel!
    @IBOutlet weak var busanStateLabel: UILabel!
    @IBOutlet weak var lazarettoStateLabel: UILabel! //검역
    
    //전일 대비 증감수 Label
    @IBOutlet weak var seoulStateLabel1: UILabel!
    @IBOutlet weak var jejuStateLabel1: UILabel!
    @IBOutlet weak var gyeongnamStateLabel1: UILabel!
    @IBOutlet weak var gyeongbukStateLabel1: UILabel!
    @IBOutlet weak var jeonnamStateLabel1: UILabel!
    @IBOutlet weak var jeonbukStateLabel1: UILabel!
    @IBOutlet weak var chungnamStateLabel1: UILabel!
    @IBOutlet weak var chungbukStateLabel1: UILabel!
    @IBOutlet weak var gangwonStateLabel1: UILabel!
    @IBOutlet weak var gyeonggiStateLabel1: UILabel!
    @IBOutlet weak var sejongStateLabel1: UILabel!
    @IBOutlet weak var ulsanStateLabel1: UILabel!
    @IBOutlet weak var daejeonStateLabel1: UILabel!
    @IBOutlet weak var gwangjuStateLabel1: UILabel!
    @IBOutlet weak var incheonStateLabel1: UILabel!
    @IBOutlet weak var daeguStateLabel1: UILabel!
    @IBOutlet weak var busanStateLabel1: UILabel!
    @IBOutlet weak var lazarettoStateLabel1: UILabel! //검역
    
    var total1 = ""
    var total2 = ""
    
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
        requestCovidInfo()
        self.marqueeLabel.type = .continuous
        self.marqueeLabel.speed = .duration(15)
        self.marqueeLabel.animationCurve = .easeInOut
        self.marqueeLabel.fadeLength = 10.0
        self.marqueeLabel.leadingBuffer = 30.0
        
        let strings = ["오늘까지의 총 확진자 수는 \(total1)명 입니다. 전일 대비 확진자 수가 총 \(total2)명이 증가하였으니 개인 소독에 집중하는 하루되시길 바랍니다."]
        
        self.marqueeLabel.text = strings[Int(arc4random_uniform(UInt32(strings.count)))]
        
    }
    
    func requestCovidInfo() {
        
        //MARK: - view가 load 되는 현재 시간 저장
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let current_date_string = formatter.string(from: Date())
        //print(current_date_string)
        
//        let url = "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson?serviceKey=2yD7EAVjVn6s7TOB869TohgRaubtsfz2hXk2RZKdv%2FHPLcJiFtZobJXfo2w7W4d%2F55NE6nJccDXb9km9qifGRA%3D%3D&pageNo=1&numOfRows=10&startCreateDt=\(current_date_string)&endCreateDt=\(current_date_string)"
//
        let url = "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson?serviceKey=2yD7EAVjVn6s7TOB869TohgRaubtsfz2hXk2RZKdv%2FHPLcJiFtZobJXfo2w7W4d%2F55NE6nJccDXb9km9qifGRA%3D%3D&pageNo=1&numOfRows=10&startCreateDt=20211013&endCreateDt=20211013"
        
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
        
        switch covidgubun {
        case "검역":
            lazarettoStateLabel.text = coviddefCnt
            lazarettoStateLabel1.text = "(+\(covidincDec))"
            lazarettoStateLabel.sizeToFit()
            lazarettoStateLabel1.sizeToFit()
        
        case "제주":
            jejuStateLabel.text = coviddefCnt
            jejuStateLabel1.text = "(+\(covidincDec))"
            jejuStateLabel.sizeToFit()
            jejuStateLabel1.sizeToFit()
        case "경북":
            gyeongbukStateLabel.text = coviddefCnt
            gyeongbukStateLabel1.text = covidincDec
            gyeongbukStateLabel.sizeToFit()
            gyeongbukStateLabel1.sizeToFit()
        case "경남":
            gyeongnamStateLabel.text = coviddefCnt
            gyeongnamStateLabel1.text = "(+\(covidincDec))"
            gyeongnamStateLabel.sizeToFit()
            gyeongnamStateLabel1.sizeToFit()
        case "전남":
            jeonnamStateLabel.text = coviddefCnt
            jeonnamStateLabel1.text = "(+\(covidincDec))"
            jeonnamStateLabel.sizeToFit()
            jeonnamStateLabel1.sizeToFit()
        case "전북":
            jeonbukStateLabel.text = coviddefCnt
            jeonbukStateLabel1.text = "(+\(covidincDec))"
            jeonbukStateLabel.sizeToFit()
            jeonbukStateLabel1.sizeToFit()
        case "충남":
            chungnamStateLabel.text = coviddefCnt
            chungnamStateLabel1.text = "(+\(covidincDec))"
            chungnamStateLabel.sizeToFit()
            chungnamStateLabel1.sizeToFit()
        case "충북":
            chungbukStateLabel.text = coviddefCnt
            chungbukStateLabel1.text = "(+\(covidincDec))"
            chungbukStateLabel.sizeToFit()
            chungbukStateLabel1.sizeToFit()
        case "강원":
            gangwonStateLabel.text = coviddefCnt
            gangwonStateLabel1.text = "(+\(covidincDec))"
            gangwonStateLabel.sizeToFit()
            gangwonStateLabel1.sizeToFit()
        case "경기":
            gyeonggiStateLabel.text = coviddefCnt
            gyeonggiStateLabel1.text = "(+\(covidincDec))"
            gyeonggiStateLabel.sizeToFit()
            gyeonggiStateLabel1.sizeToFit()
        case "세종":
            sejongStateLabel.text = coviddefCnt
            sejongStateLabel1.text = "(+\(covidincDec))"
            sejongStateLabel.sizeToFit()
            sejongStateLabel1.sizeToFit()
        case "울산":
            ulsanStateLabel.text = coviddefCnt
            ulsanStateLabel1.text = "(+\(covidincDec))"
            ulsanStateLabel.sizeToFit()
            ulsanStateLabel1.sizeToFit()
        case "대전":
            daejeonStateLabel.text = coviddefCnt
            daejeonStateLabel1.text = "(+\(covidincDec))"
            daejeonStateLabel.sizeToFit()
            daejeonStateLabel1.sizeToFit()
        case "광주":
            gwangjuStateLabel.text = coviddefCnt
            gwangjuStateLabel1.text = "(+\(covidincDec))"
            gwangjuStateLabel.sizeToFit()
            gwangjuStateLabel1.sizeToFit()
        case "인천":
            incheonStateLabel.text = coviddefCnt
            incheonStateLabel1.text = "(+\(covidincDec))"
            incheonStateLabel.sizeToFit()
            incheonStateLabel1.sizeToFit()
        case "대구":
            daeguStateLabel.text = coviddefCnt
            daeguStateLabel1.text = "(+\(covidincDec))"
            daeguStateLabel.sizeToFit()
            daeguStateLabel1.sizeToFit()
        case "부산":
            busanStateLabel.text = coviddefCnt
            busanStateLabel1.text = "(+\(covidincDec))"
            busanStateLabel.sizeToFit()
            busanStateLabel1.sizeToFit()
        case "서울":
            seoulStateLabel.text = coviddefCnt
            seoulStateLabel1.text = "(+\(covidincDec))"
            seoulStateLabel.sizeToFit()
            seoulStateLabel1.sizeToFit()
        case "합계":
            total1 = coviddefCnt
            total2 = covidincDec
        default:
            print("error")
        }
    }

}
