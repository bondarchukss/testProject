//
//  SnapKitDetailInfoViewController.swift
//  mobile.iOS.test
//
//  Created by Сергей Бондарчук on 03.03.2020.
//  Copyright © 2020 Sergey Bondarchuk. All rights reserved.
//
import UIKit
import SnapKit
import Kingfisher

class DetailInfoViewController: UIViewController {
    let detailInfoView = UIView()
    let profileImage = UIImageView()
    let buttonShare = UIBarButtonItem()
    lazy var textOnPicture: UITextField = {[weak self] in
        let textOnPic = UITextField()
        textOnPic.delegate = self
        textOnPic.backgroundColor = .lightGray
        textOnPic.borderStyle = .roundedRect
        textOnPic.placeholder = "Enter your text"
        return textOnPic}()
    var idOfProfile: Int?
    var originalImage: UIImage?
    let scrollView = UIScrollView()
    let serviceRickAndMorty = ServiceOfRickAndMorty()
    init(id: Int) {
        super.init(nibName: nil, bundle: nil)
        idOfProfile = id
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        notifyCenterObservers()
        addSubviewsAndSetupContraints()
        guard let id = idOfProfile else {
            print("idofprofile не пришло")
            return
        }
        serviceRickAndMorty.detailInfo(id: id) { [weak self] result in
            self?.profileImage.kf.indicatorType = .activity
            self?.navigationItem.title = result.name
            guard let urlString = result.image else {return}
            self?.profileImage.kf.setImage(with: URL(string: urlString)) { result in
                switch result {
                case .success:
                    self?.originalImage = self?.profileImage.image
                case .failure:
                    print("failure")
                }
            }
        }
    }
    @objc func keyboardWillAppear(notification: NSNotification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
            as? NSValue)?.cgRectValue else {return}
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardRect.height)
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    @objc func shareImage() {
        let items = [profileImage]
        let shareActivityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(shareActivityVC, animated: true)
    }
    func notifyCenterObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear),
                                               name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func addSubviewsAndSetupContraints() {
        view.addSubview(detailInfoView)
        view.addSubview(scrollView)
        scrollView.addSubview(profileImage)
        scrollView.addSubview(textOnPicture)
        view.backgroundColor = UIColor.white
        self.navigationItem.rightBarButtonItem = self.buttonShare
        self.buttonShare.title = "Share"
        self.buttonShare.action = #selector(shareImage)
        self.buttonShare.target = self
        scrollView.snp.makeConstraints { make in
            make.top.bottom.right.left.equalToSuperview()
        }
        profileImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.center.equalToSuperview()
            make.height.lessThanOrEqualToSuperview()
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(40)
            make.bottom.equalTo(textOnPicture).offset(-50)
        }
        textOnPicture.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(40)
            make.bottom.equalToSuperview().offset(-50)
        }
    }
}
extension DetailInfoViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let changedText = textField.text else {return}
        profileImage.image = originalImage?.textToImage(
            drawText: changedText, atPoint: CGPoint(x: 0, y: 275),
            withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25),
                             NSAttributedString.Key.foregroundColor: UIColor.gray] )
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}
