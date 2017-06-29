//
//  AdCell.swift
//  Tap.az
//
//  Created by Ozal Suleyman on 6/25/17.
//  Copyright © 2017 OzalSuleyman. All rights reserved.
//

import UIKit

class AdCell: UITableViewCell {
    
    var delegate : UIViewController? {
    
        didSet {
        
            if let controller = self.delegate as? NewAdVC {
            
                self.descriptionTextView.addGestureRecognizer(UITapGestureRecognizer(target: controller , action: #selector(controller.descriptionTextViewCilck(gesture:))))
            
            }
            
        }
    
    }
    
    let designView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let adNameTitleLabel : UILabel = {
        let view = UILabel(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = TEXT_COLOR_BLUE
        view.font = UIFont(name: HELVETICA_NEUE_BOLD, size: 14.0)
        view.text = "Elanın adı"
        return view
    }()
    
    let adNameTextField : UITextField = {
        let view = UITextField(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.attributedPlaceholder =  NSMutableAttributedString(string: "...", attributes: [ NSFontAttributeName : UIFont(name: HELVETICA_NEUE_BOLD, size: 14.0)! ,
                                                                                             NSForegroundColorAttributeName : TEXT_COLOR_BLUE ])
        view.textColor = TEXT_COLOR_BLUE
        return view
    }()
    
    let adNameLineView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ORANGE_COLOR.withAlphaComponent(0.5)
        return view
    }()
    
    let cityLabel : UILabel = {
        let view = UILabel(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = TEXT_COLOR_BLUE
        view.font = UIFont(name: HELVETICA_NEUE_BOLD, size: 14.0)
        view.text = "Şəhər"
        return view
    }()
    
    let cityBetweenLineView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ORANGE_COLOR.withAlphaComponent(0.5)
        return view
    }()
    
    let choosenCityButton : UIButton = {
        let view = UIButton(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitleColor(TEXT_COLOR_BLUE , for: .normal )
        view.titleLabel?.font = UIFont(name: HELVETICA_NEUE_BOLD, size: 14.0)
        view.setTitle("...", for: .normal)
        
        return view
    }()
    
    let cityLineView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ORANGE_COLOR.withAlphaComponent(0.5)
        return view
    }()
    
    
    let valueLabel : UILabel = {
        let view = UILabel(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = TEXT_COLOR_BLUE
        view.font = UIFont(name: HELVETICA_NEUE_BOLD, size: 14.0)
        view.text = "Qiymət, AZN"
        return view
    }()
    
    let valueBetweenLineView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ORANGE_COLOR.withAlphaComponent(0.5)
        return view
    }()
    
    let choosenValueTextFiled : UITextField = {
        let view = UITextField(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = TEXT_COLOR_BLUE
        view.font = UIFont(name: HELVETICA_NEUE_BOLD, size: 14.0)
        view.attributedPlaceholder =  NSMutableAttributedString(string: "...", attributes: [ NSFontAttributeName : UIFont(name: HELVETICA_NEUE_BOLD, size: 14.0)! ,
                                                                                           NSForegroundColorAttributeName : TEXT_COLOR_BLUE ])
        view.textAlignment = .center
        view.textColor = TEXT_COLOR_BLUE
        return view
    }()
    
    let valueLineView : UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ORANGE_COLOR.withAlphaComponent(0.5)
        return view
    }()

    
    let descriptionTitleLabel : UILabel = {
        let view = UILabel(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = TEXT_COLOR_BLUE
        view.font = UIFont(name: HELVETICA_NEUE_BOLD, size: 14.0)
        view.text = "Məzmun"
        return view
    }()
    
    let descriptionTextView : UITextView = {
        let view = UITextView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.attributedText = NSMutableAttributedString(string: "...", attributes: [ NSFontAttributeName : UIFont(name: HELVETICA_NEUE_BOLD, size: 14.0)! ,
                                                                                     NSForegroundColorAttributeName : TEXT_COLOR_BLUE ])
        view.contentInset = UIEdgeInsets(top: 0.0 , left: 0.0 , bottom: 0.0 , right: 0.0)
        view.textColor = TEXT_COLOR_BLUE
        return view
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
        self.backgroundColor = ORANGE_COLOR
        self.selectionStyle = .none
        
        // 1
        self.addSubview(self.designView)
        self.designView.backgroundColor = UIColor.white
        self.designView.addCorner(radius: 4.0 , borderWidth: 0.0 , color: .white)
        self.designView.leftAnchor.constraint(equalTo: self.leftAnchor , constant : 5.0 ).isActive = true
        self.designView.topAnchor.constraint(equalTo: self.topAnchor , constant : 2.0 ).isActive = true
        self.designView.widthAnchor.constraint(equalTo: self.widthAnchor , constant : -10.0 ).isActive = true
        self.designView.heightAnchor.constraint(equalTo: self.heightAnchor , constant : -4.0 ).isActive = true
        self.designView.shadow = true
        self.designView.addShadow(shadowColor: UIColor.gray.cgColor , shadowOffset: CGSize(width: 1.0 , height: 1.0 ), shadowOpacity: 1.0, shadowRadius: 1.0)
        self.designView.layer.masksToBounds = false
     
        // 2
        self.addSubview(self.adNameTitleLabel)
        self.adNameTitleLabel.leftAnchor.constraint(equalTo: self.designView.leftAnchor , constant : 8.0 ).isActive = true
        self.adNameTitleLabel.topAnchor.constraint(equalTo: self.designView.topAnchor , constant : 5.0 ).isActive = true
        self.adNameTitleLabel.widthAnchor.constraint(equalTo: self.designView.widthAnchor , constant : -16.0 ).isActive = true
        self.adNameTitleLabel.heightAnchor.constraint(equalToConstant : 20.0 ).isActive = true
        
        // 3
        self.addSubview(self.adNameTextField)
        self.adNameTextField.leftAnchor.constraint(equalTo: self.designView.leftAnchor , constant : 8.0 ).isActive = true
        self.adNameTextField.topAnchor.constraint(equalTo: self.adNameTitleLabel.bottomAnchor , constant : 1.0 ).isActive = true
        self.adNameTextField.widthAnchor.constraint(equalTo: self.designView.widthAnchor , constant : -16.0 ).isActive = true
        self.adNameTextField.heightAnchor.constraint(equalTo: self.designView.heightAnchor , multiplier:  1/5.2 ).isActive = true
        
        
        // 4
        self.addSubview(self.adNameLineView)
        self.adNameLineView.leftAnchor.constraint(equalTo: self.designView.leftAnchor , constant : 5.0 ).isActive = true
        self.adNameLineView.topAnchor.constraint(equalTo: self.adNameTextField.bottomAnchor ).isActive = true
        self.adNameLineView.widthAnchor.constraint(equalTo: self.designView.widthAnchor , constant : -10.0 ).isActive = true
        self.adNameLineView.heightAnchor.constraint(equalToConstant : 1.0 ).isActive = true
        
        // 5
        self.addSubview(self.cityLabel)
        self.cityLabel.leftAnchor.constraint(equalTo: self.designView.leftAnchor , constant : 8.0 ).isActive = true
        self.cityLabel.topAnchor.constraint(equalTo: self.adNameLineView.bottomAnchor , constant : 1.0 ).isActive = true
        self.cityLabel.widthAnchor.constraint(equalTo: self.designView.widthAnchor , multiplier : 1/2 ).isActive = true
        self.cityLabel.heightAnchor.constraint(equalTo: self.designView.heightAnchor , multiplier:  1/5.2 ).isActive = true
        
        // 6
        self.addSubview(self.cityBetweenLineView)
        self.cityBetweenLineView.leftAnchor.constraint(equalTo: self.cityLabel.rightAnchor , constant : 1.0 ).isActive = true
        self.cityBetweenLineView.topAnchor.constraint(equalTo: self.adNameLineView.bottomAnchor , constant : 1.0  ).isActive = true
        self.cityBetweenLineView.widthAnchor.constraint(equalToConstant : 1.0 ).isActive = true
        self.cityBetweenLineView.heightAnchor.constraint(equalTo : self.cityLabel.heightAnchor , constant : -2 ).isActive = true
        
        // 7
        self.addSubview(self.choosenCityButton)
        self.choosenCityButton.leftAnchor.constraint(equalTo: self.cityBetweenLineView.rightAnchor , constant : 5.0 ).isActive = true
        self.choosenCityButton.rightAnchor.constraint(equalTo: self.designView.rightAnchor , constant : -8.0 ).isActive = true
        self.choosenCityButton.topAnchor.constraint(equalTo: self.adNameLineView.bottomAnchor , constant : 1.0 ).isActive = true
        self.choosenCityButton.heightAnchor.constraint(equalTo: self.designView.heightAnchor , multiplier:  1/5.2 ).isActive = true
        self.choosenCityButton.addTarget(self , action: #selector(chooseCity), for: .touchUpInside)
        
        // 8
        self.addSubview(self.cityLineView)
        self.cityLineView.leftAnchor.constraint(equalTo: self.designView.leftAnchor , constant : 5.0 ).isActive = true
        self.cityLineView.topAnchor.constraint(equalTo: self.cityLabel.bottomAnchor ).isActive = true
        self.cityLineView.widthAnchor.constraint(equalTo: self.designView.widthAnchor , constant : -10.0 ).isActive = true
        self.cityLineView.heightAnchor.constraint(equalToConstant : 1.0 ).isActive = true
        
        // 9
        self.addSubview(self.valueLabel)
        self.valueLabel.leftAnchor.constraint(equalTo: self.designView.leftAnchor , constant : 8.0 ).isActive = true
        self.valueLabel.topAnchor.constraint(equalTo: self.cityLineView.bottomAnchor , constant : 1.0 ).isActive = true
        self.valueLabel.widthAnchor.constraint(equalTo: self.designView.widthAnchor , multiplier : 1/2 ).isActive = true
        self.valueLabel.heightAnchor.constraint(equalTo: self.designView.heightAnchor , multiplier:  1/5.2 ).isActive = true
        
        // 10
        self.addSubview(self.valueBetweenLineView)
        self.valueBetweenLineView.leftAnchor.constraint(equalTo: self.valueLabel.rightAnchor , constant : 1.0 ).isActive = true
        self.valueBetweenLineView.topAnchor.constraint(equalTo: self.cityLineView.bottomAnchor , constant : 1.0  ).isActive = true
        self.valueBetweenLineView.widthAnchor.constraint(equalToConstant : 1.0 ).isActive = true
        self.valueBetweenLineView.heightAnchor.constraint(equalTo : self.cityLabel.heightAnchor , constant : -2 ).isActive = true

        // 11
        self.addSubview(self.choosenValueTextFiled)
        self.choosenValueTextFiled.leftAnchor.constraint(equalTo: self.valueBetweenLineView.rightAnchor , constant : 5.0 ).isActive = true
        self.choosenValueTextFiled.rightAnchor.constraint(equalTo: self.designView.rightAnchor , constant : -8.0 ).isActive = true
        self.choosenValueTextFiled.topAnchor.constraint(equalTo: self.cityLineView.bottomAnchor , constant : 1.0 ).isActive = true
        self.choosenValueTextFiled.heightAnchor.constraint(equalTo: self.designView.heightAnchor , multiplier:  1/5.2 ).isActive = true
        
        let keyboard = MMNumberKeyboard(frame: CGRect.zero)
        print(keyboard.frame)
        keyboard.allowsDecimalPoint = true
        keyboard.delegate = self
        
        self.choosenValueTextFiled.inputView = keyboard
        
        
        // 12
        self.addSubview(self.valueLineView)
        self.valueLineView.leftAnchor.constraint(equalTo: self.designView.leftAnchor , constant : 5.0 ).isActive = true
        self.valueLineView.topAnchor.constraint(equalTo: self.valueLabel.bottomAnchor ).isActive = true
        self.valueLineView.widthAnchor.constraint(equalTo: self.designView.widthAnchor , constant : -10.0 ).isActive = true
        self.valueLineView.heightAnchor.constraint(equalToConstant : 1.0 ).isActive = true
        
        // 13
        self.addSubview(self.descriptionTitleLabel)
        self.descriptionTitleLabel.leftAnchor.constraint(equalTo: self.designView.leftAnchor , constant : 8.0 ).isActive = true
        self.descriptionTitleLabel.topAnchor.constraint(equalTo: self.valueLabel.bottomAnchor , constant : 5.0 ).isActive = true
        self.descriptionTitleLabel.widthAnchor.constraint(equalTo: self.designView.widthAnchor , constant : -16.0 ).isActive = true
        self.descriptionTitleLabel.heightAnchor.constraint(equalToConstant : 20.0 ).isActive = true
        
        //14
        self.addSubview(self.descriptionTextView)
        self.descriptionTextView.leftAnchor.constraint(equalTo: self.designView.leftAnchor , constant : 8.0 ).isActive = true
        self.descriptionTextView.topAnchor.constraint(equalTo: self.descriptionTitleLabel.bottomAnchor , constant : 1.0 ).isActive = true
        self.descriptionTextView.widthAnchor.constraint(equalTo: self.designView.widthAnchor , constant : -16.0 ).isActive = true
        self.descriptionTextView.bottomAnchor.constraint(equalTo: self.designView.bottomAnchor , constant :  -1.0 ).isActive = true
       
        
        
    }
    
    @objc fileprivate func chooseCity (button : UIButton) {
    
        print("button clicked...")
        
    }
    
    
}


extension AdCell : MMNumberKeyboardDelegate {

    

}








