//
//  totalViewController.swift
//  About-Covid-19
//
//  Created by 준수김 on 2021/10/13.
//

import UIKit
import Tabman
import Pageboy

class ViewController: TabmanViewController {

    private var viewControllers: Array<UIViewController> = []
    let titleData: [String] = ["코로나 확진자 현황판", "시도별 안심식당 리스트", "마이페이지"]
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        let vc2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "firstViewController") as! firstViewController

        let vc4 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "thirdViewController") as! thirdViewController
        
                let vc3 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "secondViewController") as! secondViewController
        
        viewControllers.append(vc2)
        
        viewControllers.append(vc4)
        viewControllers.append(vc3)
        
        self.dataSource = self

        // Create bar
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap // Customize

        // Add to view
        addBar(bar, dataSource: self, at: .top)
        
        //bar.backgroundView.style = .blur(style: .regular) //bar 배경스타일 변경
        bar.backgroundView.style = .clear
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 40.0, bottom: 0.0, right: 30.0) //bar item 위치변경
        bar.buttons.customize { (button) in
            button.tintColor = .white
            button.selectedTintColor = .black
        }// 버튼 색 변경
        bar.indicator.weight = .light //인디케이터 굵기
        bar.indicator.tintColor = .systemBlue //인디케이터 색
        bar.indicator.overscrollBehavior = .compress //오버스크롤 스타일
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if count == 0 {
            presentPopUp()
            print("실행1")
            count += 1
        }
    }
    
    func presentPopUp() {
        print("실행2")
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PopUpViewController") as? PopUpViewController {
            //스토리보드가 있으면 스토리보드에 SecondVC라는 이름을 가진 ViewViewController 인스턴스를 만드는데 그거의 타입은 SecondViewController이다.
            
            vc.modalPresentationStyle = .overCurrentContext
            //modalPresentationStyle: 어떤식으로 화면을 전환하고 싶나?
            
            self.present(vc, animated: true)
            //vc라는 화면의 애니메이션을 True로 한다,.
        }

    }
    
}

extension ViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let item = TMBarItem(title: "")
        item.title = titleData[index]
//        item.image = UIImage(named: "page")
//        // ↑↑ 이미지는 이따가 탭바 형식으로 보여줄 때 사용할 것이니 "이미지가 왜 있지?" 하지말고 넘어가주세요.
//        item.badgeValue = "New" //벳지추가
        
        return item
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
