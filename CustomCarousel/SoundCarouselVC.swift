//
//  SoundCarouselVC.swift
//  CustomCarousel
//
//  Created by Admin on 11/11/25.
//

//
//  Carousel2VC.swift
//  CustomCarousel
//
//  Created by Admin on 11/11/25.
//

import UIKit

struct SoundItem {
    let title: String
    let subtitle: String
    let color: UIColor
}

final class SoundCardCell: UICollectionViewCell {
    static let reuseID = "SoundCardCell"

    private let container = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let playButton = UIButton(type: .system)
    private let heartButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setupUI() {
        contentView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        container.layer.cornerRadius = 20
        container.layer.masksToBounds = true

        // Labels
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .white

        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = UIColor.white.withAlphaComponent(0.85)

        // Buttons (SF Symbols)
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        [playButton, heartButton].forEach {
            $0.tintColor = .white
            $0.backgroundColor = UIColor.white.withAlphaComponent(0.12)
            $0.layer.cornerRadius = 22
            $0.widthAnchor.constraint(equalToConstant: 44).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
        }

        // Stack trên (title + subtitle)
        let textStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        textStack.axis = .vertical
        textStack.alignment = .leading
        textStack.spacing = 4

        // Layout
        [textStack, playButton, heartButton].forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(v)
        }

        NSLayoutConstraint.activate([
            textStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            textStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            textStack.trailingAnchor.constraint(lessThanOrEqualTo: container.trailingAnchor, constant: -16),

            playButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            playButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -14),

            heartButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -14),
            heartButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -14)
        ])
    }

    func configure(_ item: SoundItem) {
        container.backgroundColor = item.color
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        layer.transform = CATransform3DIdentity
        alpha = 1
        layer.shadowOpacity = 0
    }

}

final class SoundCarouselVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    private var items: [SoundItem] = [
        .init(title: "Name of Sound", subtitle: "Meditation", color: .systemIndigo),
        .init(title: "Deep Focus",    subtitle: "Chill",      color: .systemTeal),
        .init(title: "Rain Night",    subtitle: "Sleep",      color: .systemGreen),
        .init(title: "Ocean Drift",   subtitle: "Calm",       color: .systemBlue),
        .init(title: "Pink Coral",    subtitle: "Ambient",    color: .systemPink)
    ]

    private let flow = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flow)

    // spacing cấu hình
    private let sideInset: CGFloat = 20
    private let interItemSpacing: CGFloat = 16

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black

        flow.scrollDirection = .horizontal
        flow.minimumLineSpacing = interItemSpacing
        flow.minimumInteritemSpacing = interItemSpacing

        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast    // cuộn mượt
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SoundCardCell.self, forCellWithReuseIdentifier: SoundCardCell.reuseID)

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 220) // chiều cao vùng carousel
        ])
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Card kích thước ~75% width để có hiệu ứng “peek”
        let cvWidth = collectionView.bounds.width
        let itemW = floor(cvWidth * 0.72)
        let itemH: CGFloat = collectionView.bounds.height
        flow.itemSize = CGSize(width: itemW, height: itemH)

        // Inset để card đầu/cuối vẫn cân
        let inset = max((cvWidth - itemW) / 2, sideInset)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }

    // MARK: DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SoundCardCell.reuseID,
                                                      for: indexPath) as! SoundCardCell
        cell.configure(items[indexPath.item])
        return cell
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        applyTransforms()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        applyTransforms()
    }
    private func applyTransforms() {
        let centerX = collectionView.contentOffset.x + collectionView.bounds.width / 2
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

        let itemSpan = layout.itemSize.width + layout.minimumLineSpacing
        let minScale: CGFloat = 0.9

        for cell in collectionView.visibleCells {
            let cellCenterX = cell.convert(cell.bounds, to: collectionView).midX
            let distance = abs(centerX - cellCenterX)
            let fraction = min(distance / itemSpan, 1)

            // Scale nhẹ (1 ở giữa, minScale ở ngoài)
            let scale = 1 - (1 - minScale) * fraction
            cell.transform = CGAffineTransform(scaleX: scale, y: scale)

            // Giảm alpha cho item ngoài rìa
            cell.alpha = 1 - 0.4 * fraction

            // (tuỳ chọn) thêm blur mờ
            if let blur = cell.contentView.viewWithTag(9999) as? UIVisualEffectView {
                blur.alpha = fraction * 0.6
                blur.layer.cornerRadius = 20
            } else {
                let blur = UIVisualEffectView(effect: UIBlurEffect(style: .light))
                blur.frame = cell.bounds
                blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                blur.tag = 9999
                blur.layer.cornerRadius = 20
                blur.alpha = fraction * 0.6
                cell.contentView.addSubview(blur)
            }
        }
    }


    // (Tuỳ chọn) snap về tâm như paging
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = flow
        let itemWidth = layout.itemSize.width + layout.minimumLineSpacing
        // điểm giữa màn hình tính theo contentInset
        let offsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let index = round(offsetX / itemWidth)
        targetContentOffset.pointee.x = index * itemWidth - scrollView.contentInset.left
    }
    
}

