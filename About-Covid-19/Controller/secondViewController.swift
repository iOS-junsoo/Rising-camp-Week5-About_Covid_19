//
//  secondViewController.swift
//  About-Covid-19
//
//  Created by 준수김 on 2021/10/13.
//

import UIKit
import FBSDKLoginKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import SafariServices

class secondViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var mypage: UILabel!
    @IBOutlet weak var covidLabel: UILabel!
    var nameIsNill: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var lineView = UIView(frame: CGRect(x: 0, y: 132, width: self.view.frame.size.width, height: 1))
        lineView.backgroundColor = UIColor.black
        self.view.addSubview(lineView)
        
        var lineView1 = UIView(frame: CGRect(x: 0, y: 255, width: self.view.frame.size.width, height: 1))
        lineView1.backgroundColor = UIColor.black
        self.view.addSubview(lineView1)
        
        logoutBtn.layer.shadowColor = UIColor.black.cgColor
        logoutBtn.layer.masksToBounds = false
        logoutBtn.layer.shadowOffset = CGSize(width: 0, height: 4)
        logoutBtn.layer.shadowRadius = 5
        logoutBtn.layer.shadowOpacity = 0.3
        logoutBtn.layer.cornerRadius = 10
        
//        mypage.layer.shadowColor = UIColor.black.cgColor
//        mypage.layer.masksToBounds = false
//        mypage.layer.shadowOffset = CGSize(width: 0, height: 4)
//        mypage.layer.shadowRadius = 5
//        mypage.layer.shadowOpacity = 0.3
//        
//        covidLabel.layer.shadowColor = UIColor.black.cgColor
//        covidLabel.layer.masksToBounds = false
//        covidLabel.layer.shadowOffset = CGSize(width: 0, height: 4)
//        covidLabel.layer.shadowRadius = 5
//        covidLabel.layer.shadowOpacity = 0.3
        
        userImage.layer.cornerRadius = 10
        
        //어떤 로그인 방식을 이용했는지 구분
        switch global.checkAccount {
        case 1:
            self.userName.text = "OO님 반가워요👋🏼"
            self.userName.sizeToFit()
            self.userImage.image = UIImage(named: "person")
        case 2:
            //kakao사용자 정보 가져오기
            UserApi.shared.me() {(user, error) in
                if let error = error {
                    print(error)
                }
                else {
                    //사용자 정보 입력
//                    if let user?.kakaoAccount?.profile?.nickname = nameIsNill {
//                        self.userName.text = user?.kakaoAccount?.profile?.nickname
//                        self.userName.sizeToFit()
//                    }
                    
                    self.userName.text = user?.kakaoAccount?.profile?.nickname!
                    self.userName.sizeToFit()
                    let url = user?.kakaoAccount?.profile?.profileImageUrl
                    let data = try? Data(contentsOf: url!)
                    self.userImage.image = UIImage(data: data!)


                    _ = user
                }
            }
        case 3:
            //facebook 사용자 정보 가져오기
            Profile.loadCurrentProfile { profile, error in
                if let firstName = profile?.firstName {
                    print("Hello, \(firstName)")
                    self.userName.text = firstName
                }
            }
            
            let profilePictureView = FBProfilePictureView()
            profilePictureView.profileID = AccessToken.current!.userID
            profilePictureView.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
            userImage.addSubview(profilePictureView)

        default:
            print("error")
        }
        
        
              
    }
    
    @IBAction func openVaccineBtn(_ sender: UIButton) {
        guard let url = URL(string: "https://ncvr2.kdca.go.kr/") else { return }

            let safariViewController = SFSafariViewController(url: url)

            present(safariViewController, animated: true, completion: nil)

    }
    
    @IBAction func vaccineStatusBtn(_ sender: UIButton) {
        guard let url = URL(string: "https://ncv.kdca.go.kr/") else { return }

            let safariViewController = SFSafariViewController(url: url)

            present(safariViewController, animated: true, completion: nil)
    }
    
    @IBAction func covidBoardBtn(_ sender: UIButton) {
        guard let url = URL(string: "http://ncov.mohw.go.kr/tcmBoardList.do?brdId=3&brdGubun=31&dataGubun=&ncvContSeq=&contSeq=&board_id=311&gubun=") else { return }

            let safariViewController = SFSafariViewController(url: url)

            present(safariViewController, animated: true, completion: nil)
    }
    
    @IBAction func logOutBtn(_ sender: UIButton) {
//        UserApi.shared.logout {(error) in
//            if let error = error {
//                print(error)
//            }
//            else {
//                print("logout() success.")
//                self.logoutLogic()
//            }
//        }
        logoutLogic()
    }
    
    func logoutLogic() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "StartViewController") as? StartViewController {
            //스토리보드가 있으면 스토리보드에 SecondVC라는 이름을 가진 ViewViewController 인스턴스를 만드는데 그거의 타입은 SecondViewController이다.
            
            vc.modalPresentationStyle = .overFullScreen
            //modalPresentationStyle: 어떤식으로 화면을 전환하고 싶나?
            
            self.present(vc, animated: true)
            //vc라는 화면의 애니메이션을 True로 한다,.
        }
    }
    
}



// Swift override func viewDidLoad() { super.viewDidLoad() if let token = AccessToken.current, !token.isExpired { // User is logged in, do work such as go to next view controller. } }
    
