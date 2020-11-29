

import UIKit

final class StorkHeaderView: UIView {
    
    let controlView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray3
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(controlView)
        NSLayoutConstraint.activate([controlView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                                     controlView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     controlView.heightAnchor.constraint(equalToConstant: 5),
                                     controlView.widthAnchor.constraint(equalToConstant: 50)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        controlView.apply(.roundedStyle())
    }
}
