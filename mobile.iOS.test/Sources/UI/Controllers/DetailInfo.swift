//
//  DetailInfo.swift
//  mobile.iOS.test
//
//  Created by Sergey Bondarchuk on 14.02.2020.
//  Copyright © 2020 Sergey Bondarchuk. All rights reserved.
//

import UIKit
import Kingfisher
import Moya
import SnapKit
class DetailInfo: UIViewController {
    var idOfProfile: Int?
    var profileOfVM: DetailInfoCharacter?
    let profileImage = UIImageView()
    override func viewDidLoad() {
        addConstraintForImageProfile()
        guard let id = idOfProfile else {
            print("idofprofile не пришло")
            return
        }
        let detailInfo = ServiceOfRickAndMorty()
        detailInfo.detailInfo(id: id) { result in
            self.profileImage.kf.setImage(with: DetailInfoCharacter.init(model: result).imageUrl)
        }
    }
    func addConstraintForImageProfile() {
        self.view.addSubview(profileImage)
        profileImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(150)
            make.bottom.equalToSuperview().offset(-150)
            make.right.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            make.center.equalToSuperview()
        }
    }
}
