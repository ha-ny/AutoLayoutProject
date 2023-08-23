//
//  DiaryViewController.swift
//  AutoLayoutProject
//
//  Created by 김하은 on 2023/08/22.
//

import UIKit
import SnapKit

class DiaryViewController: UIViewController {

    let photoImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        return view
    }()

    let titleTextField  = {
        let view = UITextField()
        view.layer.borderWidth = 0.5
        view.textAlignment = .center
        view.placeholder = "제목을 입력해주세요"
        return view
    }()
    let dateTextField  = {
        let view = UITextField()
        view.layer.borderWidth = 0.5
        view.textAlignment = .center
        view.placeholder = "날짜를 입력해주세요"
        return view
    }()
    let memoTextView  = {
        let view = UITextView()
        view.layer.borderWidth = 0.5
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [photoImageView, titleTextField, dateTextField, memoTextView].forEach {
            view.addSubview($0)
        }
        
        designSetting()
    }
    
    func designSetting(){
        
        photoImageView.snp.makeConstraints { make in
            make.centerX.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.3)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(photoImageView)
            make.height.equalTo(50)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleTextField.snp.bottom).offset(16)
            make.leading.trailing.equalTo(titleTextField)
            make.height.equalTo(50)
        }
        
        memoTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dateTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(dateTextField)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
    }
}
