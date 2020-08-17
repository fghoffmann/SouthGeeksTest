//
//  UserTableViewCell.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 15/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var avatarContainer: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var goldImageView: UIImageView!
    @IBOutlet weak var silverImageView: UIImageView!
    @IBOutlet weak var bronzeImageView: UIImageView!
    @IBOutlet weak var goldLabel: UILabel!
    @IBOutlet weak var silverLabel: UILabel!
    @IBOutlet weak var bronzeLabel: UILabel!
    
    // MARK: - Variables
    static var cellHeight: CGFloat { UITableView.automaticDimension }
    private var loading: Bool = false {
        didSet {
            if loading { setAsLoadingCell() }
            else { setAsNormalCell() }
        }
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarContainer.cornerRadius = avatarContainer.frame.height / 2
        avatarImageView.cornerRadius = avatarImageView.frame.height / 2
        mainContainer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Methods
    func setData(withUser user: User?) {
        guard let user = user else {
            loading = true
            return
        }
        
        loading = false
        nameLabel.text = user.name
        locationLabel.text = user.location
        goldLabel.text = "\(user.badges?.gold ?? 0)"
        silverLabel.text = "\(user.badges?.silver ?? 0)"
        bronzeLabel.text = "\(user.badges?.bronze ?? 0)"
        avatarImageView.setImage(user.profileImage,
                                 placeholder: UIImage(systemName: "contact"),
                                 forHeight: 50) { (avatar) in
                                    
        }
    }
    
    func animateIn() {
        goldImageView.animateShowPopingUp(duration: 0.5)
        silverImageView.animateShowPopingUp(duration: 0.7)
        bronzeImageView.animateShowPopingUp(duration: 0.9)
    }
    
    func setAsLoadingCell() {
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
