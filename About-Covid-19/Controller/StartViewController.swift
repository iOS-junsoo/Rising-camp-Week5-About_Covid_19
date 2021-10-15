//
//  ViewController.swift
//  About-Covid-19
//
//  Created by 준수김 on 2021/10/12.
//

import UIKit
import FBSDKLoginKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class StartViewController: UIViewController {

    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var login2: UIButton!
    @IBOutlet weak var mainLogin: UIButton!
    @IBOutlet weak var ID: UITextField!
    @IBOutlet weak var PW: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //기본적으로 제공하는 버튼
        
        
        //MARK: - 버튼에 그림자 넣기
        ID.layer.shadowColor = UIColor.black.cgColor
        ID.layer.masksToBounds = false
        ID.layer.shadowOffset = CGSize(width: 0, height: 4)
        ID.layer.shadowRadius = 5
        ID.layer.shadowOpacity = 0.3
        
        PW.layer.shadowColor = UIColor.black.cgColor
        PW.layer.masksToBounds = false
        PW.layer.shadowOffset = CGSize(width: 0, height: 4)
        PW.layer.shadowRadius = 5
        PW.layer.shadowOpacity = 0.3
        
        mainLogin.layer.shadowColor = UIColor.black.cgColor
        mainLogin.layer.masksToBounds = false
        mainLogin.layer.shadowOffset = CGSize(width: 0, height: 4)
        mainLogin.layer.shadowRadius = 5
        mainLogin.layer.shadowOpacity = 0.3
        mainLogin.layer.cornerRadius = 4
        
        login2.layer.shadowColor = UIColor.black.cgColor
        login2.layer.masksToBounds = false
        login2.layer.shadowOffset = CGSize(width: 0, height: 4)
        login2.layer.shadowRadius = 5
        login2.layer.shadowOpacity = 0.3
        
        login.layer.shadowColor = UIColor.black.cgColor
        login.layer.masksToBounds = false
        login.layer.shadowOffset = CGSize(width: 0, height: 4)
        login.layer.shadowRadius = 5
        login.layer.shadowOpacity = 0.3
        
    }
    @IBAction func login2(_ sender: UIButton) {
        let manager = LoginManager()
        manager.logIn(permissions: ["public_profile"], from: self) { result, error in
            if let error = error {
                print("Process error: \(error)")
                return

            }
            guard let result = result else {
                print("No Result")

                return

            }
            if result.isCancelled {
                print("Login Cancelled")
                return
            }
            // result properties
            //  - token : 액세스 토큰
            //  - isCancelled : 사용자가 로그인을 취소했는지 여부
            //  - grantedPermissions : 부여 된 권한 집합
            //
            self.loginLogic()
            global.checkAccount = 3
    }
        
}
        
    @IBAction func login(_ sender: UIButton) {
        
        UserApi.shared.loginWithKakaoAccount(prompts:[.Login]) {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                global.checkAccount = 2
                self.loginLogic()
                //do something
                _ = oauthToken
                    
            }
        }
    }

    @IBAction func mainLogin(_ sender: UIButton) {
        loginLogic()
        global.checkAccount = 1
    }
    
    func loginLogic() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            //스토리보드가 있으면 스토리보드에 SecondVC라는 이름을 가진 ViewViewController 인스턴스를 만드는데 그거의 타입은 SecondViewController이다.
            
            vc.modalPresentationStyle = .overFullScreen
            //modalPresentationStyle: 어떤식으로 화면을 전환하고 싶나?
            
            self.present(vc, animated: true)
            //vc라는 화면의 애니메이션을 True로 한다,.
        }
    }
    
}

