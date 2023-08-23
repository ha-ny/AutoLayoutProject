//
//  ViewController.swift
//  AutoLayoutProject
//
//  Created by 김하은 on 2023/08/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let tabBar = UITabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tabBar.view)
        
        tabBar.view.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tabBarSetting()
    }
    
    func tabBarSetting() {
        
        let diary = DiaryViewController()
        diary.tabBarItem = UITabBarItem(title: "다이어리", image: nil, tag: 0)
        
        let kakaoTalk = KakaoTalkViewController()
        kakaoTalk.tabBarItem = UITabBarItem(title: "카카오톡", image: nil, tag: 1)
        
        let findCinema = FindCinemaViewController()
        findCinema.tabBarItem = UITabBarItem(title: "영화관", image: nil, tag: 1)
        
        let tabBarArray = [diary, kakaoTalk, findCinema]
        tabBar.viewControllers = tabBarArray
    }
}

