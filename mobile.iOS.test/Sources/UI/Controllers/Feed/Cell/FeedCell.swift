//
//  FeedofCharacterCell.swift
//  mobile.iOS.test
//
//  Created by Sergey Bondarchuk on 13.02.2020.
//  Copyright © 2020 Sergey Bondarchuk. All rights reserved.
//
import UIKit
import Kingfisher
import SnapKit

class FeedCell: UITableViewCell {
    let name = UILabel()
    let status = UILabel()
    let species = UILabel()
    let imageProfile = UIImageView()
    let error = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviewsAndSetupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(vm: FeedCellViewModel) {
        name.text = vm.name
        status.text = vm.status
        species.text = vm.species
        imageProfile.kf.indicatorType = .activity
        imageProfile.kf.setImage(with: URL(string: vm.imageUrl))
    }
    func addSubviewsAndSetupConstraints() {
        addSubview(name)
        addSubview(status)
        addSubview(species)
        addSubview(imageProfile)
        addSubview(error)
        let distanceBetweenImageAndLabels = 140
        imageProfile.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        name.snp.makeConstraints { (make) in
            make.leading.equalTo(imageProfile).offset(distanceBetweenImageAndLabels)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalTo(status).offset(-45)
        }
        status.snp.makeConstraints { (make) in
            make.leading.equalTo(imageProfile).offset(distanceBetweenImageAndLabels)
            make.top.equalTo(name).offset(45)
            make.bottom.equalTo(species).offset(-70)
        }
        species.snp.makeConstraints { (make) in
            make.leading.equalTo(imageProfile).offset(distanceBetweenImageAndLabels)
            make.top.equalTo(status).offset(20)
            make.bottom.equalToSuperview().offset(0)
        }
    }
}
