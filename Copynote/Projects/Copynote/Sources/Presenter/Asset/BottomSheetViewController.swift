//
//  BottomSheetViewController.swift
//  Copynote
//
//  Created by 송영모 on 2023/01/14.
//  Copyright © 2023 Copynote. All rights reserved.
//

import UIKit
import RxGesture
import SnapKit

class BottomSheetViewController: BaseViewController {
    // MARK: - Sub Type
    
    enum Mode {
        case drag
        case fixed
    }
    
    // MARK: - UI Components

    var sheetView: UIView = .init()
    var dimmedView: UIView = .init()

    // MARK: - Properties

    private let mode: Mode
    
    private lazy var MAX_ALPHA: CGFloat = {
        self.mode == .drag ? 0.75 : 0.0
    }()
    
    private lazy var dimmedColor: UIColor = {
        self.mode == .drag ? .black : .clear
    }()
    
    // MARK: - Initializer
    
    init(mode: Mode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .overCurrentContext
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle Methods

    override func viewWillAppear(_: Bool) {
        animatePresentView()
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        self.animateDismissView()
        super.dismiss(animated: flag, completion: completion)
    }
    
    func refresh() {
        sheetView.layoutIfNeeded()
    }

    // MARK: - Setup Methods

    override func setupProperty() {
        view.backgroundColor = .clear

        sheetView.backgroundColor = .white
        sheetView.cornerRound(radius: 24, direct: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        sheetView.setShadow(radius: 40, offset: .init(width: 4, height: 10), opacity: 0.06)

        dimmedView.backgroundColor = .clear
    }

    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubviews([dimmedView, sheetView])
    }

    override func setupLayout() {
        super.setupLayout()
        
        dimmedView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-1000)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    override func setupBind() {
        super.setupBind()
        
        guard mode == .drag else { return }
        
        sheetView.rx.panGesture()
            .subscribe(onNext: { [weak self] gesture in
                guard let self = self else { return }
                let translation = gesture.translation(in: self.view)
                guard translation.y > 0 else { return }
                
                let dismissPercent = self.MAX_ALPHA - (translation.y / self.sheetView.bounds.height)

                self.dimmedView.backgroundColor = self.dimmedColor.withAlphaComponent(dismissPercent)

                switch gesture.state {
                case .changed: self.willTransition(to: translation.y)
                case .ended: self.endTransition(at: translation.y)
                default: break
                }
            })
            .disposed(by: disposeBag)

        dimmedView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }

    final func addContentView(view: UIView) {
        sheetView.addSubview(view)

        sheetView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(view.snp.height).offset(48)
        }

        view.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(24)
        }
    }

    // MARK: - Dismiss Sheet

    func willTransition(to transitionY: CGFloat) {
        guard transitionY > 0 else { return }

        sheetView.transform = CGAffineTransform(translationX: 0, y: transitionY)
    }

    func endTransition(at transitionY: CGFloat) {
        if transitionY < sheetView.bounds.height / 3.0 {
            dimmedView.backgroundColor = dimmedColor
            sheetView.transform = .identity
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func animatePresentView() {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseInOut]) {
            self.dimmedView.backgroundColor = self.dimmedColor
            self.dimmedView.alpha = self.MAX_ALPHA
        }
    }

    func animateDismissView() {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseInOut]) {
            self.dimmedView.alpha = 0
        }
    }
}
