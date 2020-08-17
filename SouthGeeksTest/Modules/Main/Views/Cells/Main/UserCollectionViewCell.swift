//
//  UserCollectionViewCell.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 15/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import UIKit

class UserCollectionViewCell: BasePageCollectionCell {
    
    // MARK: - Outlets
    @IBOutlet weak var backConstraintWidth: NSLayoutConstraint!
    @IBOutlet weak var frontConstraintWidth: NSLayoutConstraint!
    @IBOutlet weak var backConstraintHeight: NSLayoutConstraint!
    @IBOutlet weak var frontConstraintHeight: NSLayoutConstraint!
    
    // Front Container
    @IBOutlet weak var avatarContainer: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    // Back Container
    @IBOutlet weak var goldImageView: UIImageView!
    @IBOutlet weak var silverImageView: UIImageView!
    @IBOutlet weak var bronzeImageView: UIImageView!
    @IBOutlet weak var goldLabel: UILabel!
    @IBOutlet weak var silverLabel: UILabel!
    @IBOutlet weak var bronzeLabel: UILabel!
    
    // MARK: - Variables
    private var loading: Bool = false {
        didSet {
            if loading { setAsLoadingCell() }
            else { setAsNormalCell() }
        }
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let avatarContainer = avatarContainer,
            let avatarImageView = avatarImageView else { return }
        avatarContainer.cornerRadius = avatarContainer.frame.height / 2
        avatarImageView.cornerRadius = avatarImageView.frame.height / 2
    }
    
    // MARK: - Methods
    func setData(withUser user: User?, isOpen: Bool) {
        guard let user = user else {
            loading = true
            return
        }
        
        self.cellIsOpen(isOpen, animated: false)
        
        loading = false
        nameLabel.text = user.name?.attributedHtmlString?.string
        locationLabel.text = user.location?.attributedHtmlString?.string
        goldLabel.text = "\(user.badges?.gold ?? 0)"
        silverLabel.text = "\(user.badges?.silver ?? 0)"
        bronzeLabel.text = "\(user.badges?.bronze ?? 0)"
        avatarImageView.setImage(user.profileImage,
                                 placeholder: nil,
                                 forHeight: 100) { [weak self] (avatar) in
            guard let avatar = avatar else {
                self?.avatarImageView.image = UIImage(systemName: "person.fill")
                return
            }
            self?.frontContainerView.backgroundColor = avatar.areaAverage()
        }
    }
    
    func animateIn() {
        bronzeImageView.animateShowPopingUp(duration: 0.4, scaleOut: 1.2)
        silverImageView.animateShowPopingUp(duration: 0.6, scaleOut: 1.2)
        goldImageView.animateShowPopingUp(duration: 0.8, scaleOut: 1.6)
    }
    
    func setAsLoadingCell() {
        avatarImageView.image = nil
        frontContainerView.backgroundColor = .loadingBackground
        avatarImageView.startShimmerAnimation()
        nameLabel.startLabelShimmerAnimation(withText: "\t\t\t", cornerRadius: 10)
        locationLabel.startLabelShimmerAnimation(withText: "\t\t", cornerRadius: 6)
        goldLabel.startLabelShimmerAnimation(withText: "\t", cornerRadius: 6)
        silverLabel.startLabelShimmerAnimation(withText: "\t", cornerRadius: 6)
        bronzeLabel.startLabelShimmerAnimation(withText: "\t", cornerRadius: 6)
        goldImageView.alpha = 0.5
        silverImageView.alpha = 0.5
        bronzeImageView.alpha = 0.5
    }
    
    func setAsNormalCell() {
        avatarImageView.stopShimmerAnimation()
        nameLabel.stopLabelShimmerAnimation()
        locationLabel.stopLabelShimmerAnimation()
        goldLabel.stopLabelShimmerAnimation()
        silverLabel.stopLabelShimmerAnimation()
        bronzeLabel.stopLabelShimmerAnimation()
        goldImageView.alpha = 1
        silverImageView.alpha = 1
        bronzeImageView.alpha = 1
    }

}
