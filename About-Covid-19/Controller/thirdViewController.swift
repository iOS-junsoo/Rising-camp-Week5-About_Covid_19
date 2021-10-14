//
//  thirdViewController.swift
//  About-Covid-19
//
//  Created by 준수김 on 2021/10/13.
//

import UIKit
import DropDown
import MarqueeLabel

class thirdViewController: UIViewController{
  
    let dropDown = DropDown()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var localBtn: UIButton!
    @IBOutlet weak var marqueeLabel: MarqueeLabel!
    
    var row = [Row]()
    var model = RestaurantModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.marqueeLabel.type = .continuous
        self.marqueeLabel.speed = .duration(15)
        self.marqueeLabel.animationCurve = .easeInOut
        self.marqueeLabel.fadeLength = 10.0
        self.marqueeLabel.leadingBuffer = 30.0
        
        let strings = ["이 페이지는 전국에 있는 코로나 안심식당을 보여주는 페이지입니다. 즐거운 식사시간 되세요."]
        
        self.marqueeLabel.text = strings[Int(arc4random_uniform(UInt32(strings.count)))]
        dropDown.dataSource = ["경기도", "강원도", "전라북도", "전라남도", "충청북도", "충청남도", "경상북도", "경상남도"] //데이터 소스
        setUpTableView()
        tableView.rowHeight = UITableView.automaticDimension
        
        model.delegate = self
        
        localBtn.layer.shadowColor = UIColor.black.cgColor
        localBtn.layer.masksToBounds = false
        localBtn.layer.shadowOffset = CGSize(width: 0, height: 4)
        localBtn.layer.shadowRadius = 5
        localBtn.layer.shadowOpacity = 0.3
        
        
    }
    private func setUpTableView() {
        tableView.delegate = self
        //"tableView한테 이벤트가 발생하면 프로토콜에 따라 ViewController가 tableView에게 응답을 줄게."
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell") //MemoTableViewCell이름의 XIB를 tableView에 등록한다.
    }
    
    @IBAction func localSelectBtn(_ sender: UIButton) {
        dropDown.show() //드롭다운 메뉴 열기
        
        dropDown.bottomOffset = CGPoint(x: 0, y: -75) //드롭다운 위치 조정
        //오류 코드: dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.width = 235//가로길이
        dropDown.textColor = UIColor.black //글자색
        dropDown.selectedTextColor = UIColor.red //선택된 메뉴 글씨 색
        dropDown.textFont = UIFont.systemFont(ofSize: 20) //폰트사이즈
        dropDown.backgroundColor = UIColor.white //배경색
        dropDown.selectionBackgroundColor = UIColor.white //선택된 메뉴 배경색
        dropDown.cellHeight = 40 //높이
        dropDown.customCellConfiguration = { [unowned self] (index: Int, item: String, cell: DropDownCell) in
        // Setup your custom UI components
        cell.optionLabel.textAlignment = .center
    }
        //dropDown.cornerRadius = 15 //모서리 둥글게
        //선택한 값 가져오기
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("선택한 아이템 : \(item)")
            print("인덱스 : \(index)")
            
        }
        
        //선택되었던 상태 유지못하게 만들기
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("선택한 아이템 : \(item)")
            print("인덱스 : \(index)")
            self.dropDown.clearSelection()
            localBtn.setTitle(item, for: .normal)
            global.dropdownSelected = item
            model.getRestaurants()
        }
        
    }
}

extension thirdViewController: RestaurantModelProtocol {
    // MARK: ArticleModelProtocol functions
    func RestaurantsRetrieved(row: [Row]) {
        print("articles retrieved from article model!")
        self.row = row
        tableView.reloadData()
    }
}

extension thirdViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.row.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
        let restaurant = self.row[indexPath.row]
        cell.displayRastaurant(row: restaurant)
        cell.selectionStyle = .none
        return cell
    }
    
   
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return UITableView.automaticDimension
        
    }

    
}
