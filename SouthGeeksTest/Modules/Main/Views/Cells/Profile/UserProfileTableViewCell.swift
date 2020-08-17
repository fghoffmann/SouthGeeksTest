//
//  UserProfileTableViewCell.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 16/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import UIKit

class UserProfileTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var reputationLabel: UILabel!
    @IBOutlet weak var goldLabel: UILabel!
    @IBOutlet weak var silverLabel: UILabel!
    @IBOutlet weak var bronzeLabel: UILabel!
    
    // MARK: - Variables
    static var cellHeight: CGFloat { UIScreen.main.bounds.height - 236 }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Methods
    func setData(withUser user: User?) {
        guard let user = user else { return }
        
        nameLabel.text = user.name
        locationLabel.text = user.location
        reputationLabel.text = "\(user.reputation ?? 0)"
        goldLabel.text = "\(user.badges?.gold ?? 0)"
        silverLabel.text = "\(user.badges?.silver ?? 0)"
        bronzeLabel.text = "\(user.badges?.bronze ?? 0)"
        
        for view in mainStackView.arrangedSubviews {
            view.alpha = 0
        }
    }
    
    func animateIn() {
        var  count: Double = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            for view in self?.mainStackView.arrangedSubviews ?? [] {
                view.animateFadeIn(duration: 0.3 + (0.2 * count))
                count+=1
            }
        }
    }
    
}
