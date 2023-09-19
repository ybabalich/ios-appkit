//
//  TappableButton.swift
//  
//
//  Created by Yaroslav Babalich on 21.01.2021.
//

import UIKit
import Then

open class TappableButton: BiggerAreaButton {

    // MARK: - Public properties

    open override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.5
        }
    }

    public var isLoading: Bool = false {
        didSet {
            if isLoading {
                titleLabel?.isHidden = true
                if #available(iOS 15.0, *) {
                    subtitleLabel?.isHidden = true
                }
                imageView?.isHidden = true
                indicatorView.startAnimating()
            } else {
                titleLabel?.isHidden = false
                if #available(iOS 15.0, *) {
                    subtitleLabel?.isHidden = false
                }
                imageView?.isHidden = false
                indicatorView.stopAnimating()
            }
        }
    }

    // MARK: - Private properties

    private var tapClosure: TypeClosure<TappableButton>?
    private var tempTitleStorage: String?
    private var tempImageStorage: UIImage?
    private var indicatorView: UIActivityIndicatorView!

    // MARK: - Initializers

    public override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    public required init?(coder: NSCoder) {
        fatalError(#function)
    }

    // MARK: - Public methods

    public func onTap(completion: @escaping TypeClosure<TappableButton>) {
        addTarget(self, action: #selector(onTapEvent(_:)), for: .touchUpInside)
        tapClosure = completion
    }

    public func setIsLoading(_ value: Bool, animated: Bool) {
        UIView.animate(withDuration: animated ? 0.3 : 0) {
            self.isLoading = value
        }
    }

    public func showTemporaryText(_ text: String, for time: TimeInterval = 0.5) {
        isEnabled = false
        tempTitleStorage = title(for: .normal)

        UIView.animate(withDuration: time / 2) {
            self.setTitle(text, for: .normal)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            UIView.animate(withDuration: time / 2) {
                self.setTitle(self.tempTitleStorage, for: .normal)

                self.isEnabled = true
            }
        }
    }

    // MARK: - Private methods

    private func setupUI() {
        indicatorView = UIActivityIndicatorView().then { view in
            view.color = titleColor(for: .normal)
            view.hidesWhenStopped = true
            view.stopAnimating()

            addSubview(view) {
                $0.center.equalToSuperview()
                $0.size.equalTo(20)
            }
        }
    }

    @objc
    private func onTapEvent(_ sender: UIButton) {
        tapClosure?(self)
    }
}
