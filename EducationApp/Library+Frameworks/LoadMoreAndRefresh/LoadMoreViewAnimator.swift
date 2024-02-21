//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import UIKit

open class LoadMoreAnimator: UIView, LoadMoreDelegate {

    open var spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)

    override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = .flexibleWidth
        
        spinner.color = UIColor(named: "Light Text Color - #7C7F86")
        addSubview(spinner)
        spinner.isHidden = true
    }

    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func layoutSubviews() {
        super.layoutSubviews()

        spinner.center = CGPoint(x: frame.size.width * 0.5, y: frame.size.height * 0.5)
    }

    open func loadMoreAnimationDidStart(view: LoadMoreView) {
        spinner.isHidden = false
        spinner.startAnimating()
    }

    open func loadMoreAnimationDidEnd(view: LoadMoreView) {
        spinner.isHidden = true
        spinner.stopAnimating()
    }
}
