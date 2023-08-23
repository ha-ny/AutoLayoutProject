//
//  KakaoTalkViewController.swift
//  AutoLayoutProject
//
//  Created by 김하은 on 2023/08/22.
//

import UIKit
import SnapKit

class KakaoTalkViewController: UIViewController {

    let closeButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "xmark"), for: .normal)
        view.tintColor = .black
        return view
    }()
    
    let profileImageView = {
        let view = UIImageView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 38
        return view
    }()
    
    let nameLabel = {
        let view = UILabel()
        view.text = "이름"
        view.textColor = .black
        return view
    }()
    
    let lineLabel = {
        let view = UILabel()
        view.backgroundColor = .gray
        return view
    }()
    
    let chatToMeButton = {
        let view = UIButton()
        view.setTitleColor(UIColor.black, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 13)
        view.setTitle("나와의 채팅", for: .normal)
        return view
    }()
    
    let profileEditButton = {
        let view = UIButton()
        view.setTitleColor(UIColor.black, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 13)
        view.setTitle("프로필 편집", for: .normal)
        return view
    }()
    
    let kakaoStoryButton = {
        let view = UIButton()
        view.setTitleColor(UIColor.black, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 13)
        view.setTitle("카카오스토리", for: .normal)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        [closeButton, profileImageView, nameLabel, lineLabel, chatToMeButton, profileEditButton, kakaoStoryButton].forEach {
            view.addSubview($0)
        }
        
        designSetting()
    }
    
    func designSetting() {
        
        let viewHeight = view.frame.height
        let viewWidth = view.frame.width

        closeButton.snp.makeConstraints { make in
            make.left.top.equalTo(15)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(view.snp.width).multipliedBy(0.3)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(viewHeight/2)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
        }
        
        lineLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: viewHeight, height: 0.7))
            make.top.equalTo(nameLabel.snp.bottom).offset(26)
        }
        
        chatToMeButton.snp.makeConstraints { make in
            make.size.equalTo(view.snp.width).multipliedBy(0.2)
            make.bottom.left.equalToSuperview().inset(40)
        }
        
        profileEditButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(view.snp.width).multipliedBy(0.2)
            make.bottom.equalToSuperview().inset(40)
        }

        kakaoStoryButton.snp.makeConstraints { make in
            make.size.equalTo(view.snp.width).multipliedBy(0.2)
            make.bottom.right.equalToSuperview().inset(40)
        }
    }
}
