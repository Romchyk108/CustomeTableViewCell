//
//  ExampleTableViewCell.swift
//  TableView_CustomCell
//
//  Created by Roman Shestopal on 29.11.2021.
//

import UIKit

class ExampleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var segmentAnswerOutlet: UISegmentedControl!
    @IBOutlet weak var ChangeOutlet: UIButton!
    @IBOutlet weak var DeleteOutlet: UIButton!
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        //segmentAnswerOutlet.setTitle("12", forSegmentAt: 3)
    }
    
    @IBAction func ButtonChange(_ sender: UIButton) {
        deligate?.change(self, index: title)
    }
    
    @IBAction func ButtonDelete(_ sender: UIButton) {
        deligate?.showAC(self, index: title)
        deligate?.didTapBtn(with: sender.tag)
    }
    
    var deligate: ProtocolQuestion?
    
    static var identifire = "ExampleTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "StringExampleTableViewCell", bundle: nil)
    }
    
    private var title: Int = 10
    
    func configure(with title: Int){
        self.title = title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
