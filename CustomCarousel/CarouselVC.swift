//import UIKit
//import iCarousel
//
//final class CarouselVC: UIViewController, iCarouselDataSource, iCarouselDelegate {
//    @IBOutlet weak var carousel: iCarousel!
//    @IBOutlet weak var titleLabel: UILabel!
//
//    struct Item { let title: String; let color: UIColor }
//    private let items: [Item] = [
//        .init(title: "3D Rain Narrative", color: UIColor(hex: 0x4F46E5)), // Indigo
//        .init(title: "Lotus Bloom",       color: UIColor(hex: 0xEC4899)), // Pink
//        .init(title: "Aurora Spin",       color: UIColor(hex: 0x22C55E)), // Green
//        .init(title: "Ocean Drift",       color: UIColor(hex: 0x06B6D4)), // Cyan
//        .init(title: "Coral Dance",       color: UIColor(hex: 0xF59E0B)),  // Amber
//            .init(title: "3D Rain Narrative", color: UIColor(hex: 0x4F46E5)), // Indigo
//            .init(title: "Lotus Bloom",       color: UIColor(hex: 0xEC4899)), // Pink
//            .init(title: "Aurora Spin",       color: UIColor(hex: 0x22C55E)), // Green
//            .init(title: "Ocean Drift",       color: UIColor(hex: 0x06B6D4)), // Cyan
//            .init(title: "Coral Dance",       color: UIColor(hex: 0xF59E0B))  // Amber
//    ]
//
//    private let itemSize = CGSize(width: 80, height: 80)
//    private let cornerRadius: CGFloat = 32
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        carousel.type = .custom
//        carousel.delegate = self
//        carousel.dataSource = self
//        carousel.isPagingEnabled = false
//        carousel.decelerationRate = 0.9
//        carousel.clipsToBounds = false
//
//
//        titleLabel.textAlignment = .center
//        titleLabel.alpha = 0.9
//        carousel.reloadData()
//        updateTitle()
//    }
//
//    // MARK: - DataSource
//    func numberOfItems(in carousel: iCarousel) -> Int { items.count }
//    func carouselItemWidth(_ carousel: iCarousel) -> CGFloat { itemSize.width }
//
//    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
//        let container: UIView
//        let cardView: UIView
//        let glyph: UILabel
//
//        if let v = view,                                   // reuse
//           let cv = v.viewWithTag(100) as? UIView,
//           let g  = v.viewWithTag(101) as? UILabel {
//            container = v; cardView = cv; glyph = g
//        } else {
//            container = UIView(frame: CGRect(origin: .zero, size: itemSize))
//            container.backgroundColor = .clear
//            container.layer.masksToBounds = false
//            container.layer.shadowColor = UIColor.black.cgColor
//            container.layer.shadowOpacity = 0.25
//            container.layer.shadowRadius = 20
//            container.layer.shadowOffset = CGSize(width: 0, height: 10)
//
//            cardView = UIView(frame: container.bounds)
//            cardView.tag = 100
//            cardView.layer.cornerRadius = cornerRadius
//            cardView.clipsToBounds = true
//            cardView.layer.borderWidth = 0.5
//            cardView.layer.borderColor = UIColor.white.withAlphaComponent(0.12).cgColor
//
//            glyph = UILabel(frame: container.bounds)
//            glyph.tag = 101
//            glyph.textAlignment = .center
//            glyph.font = .boldSystemFont(ofSize: 42)
//            glyph.textColor = .white.withAlphaComponent(0.95)
//
//            container.addSubview(cardView)
//            container.addSubview(glyph)
//        }
//
//        // màu và ký tự minh họa (chữ cái đầu)
//        cardView.backgroundColor = items[index].color
//        glyph.text = String(items[index].title.prefix(1)) // chỉ để có điểm nhấn, có thể bỏ
//
//        return container
//    }
//
//    // Các item bên cạnh phẳng: KHÔNG xoay, chỉ tịnh tiến + scale nhẹ + Z nhẹ
//    func carousel(_ carousel: iCarousel,
//                  itemTransformForOffset offset: CGFloat,
//                  baseTransform: CATransform3D) -> CATransform3D {
//        var t = baseTransform
//        t.m34 = -1.0 / 800.0
//
//        // Ngang: dồn vừa khung để thấy 5 item
//        let spacingX: CGFloat = 0.90
//        let x = offset * itemSize.width * spacingX
//        t = CATransform3DTranslate(t, x, 0, 0)
//
//        // Chiều sâu: đẩy Z rất nhẹ để tạo lớp, nhưng không làm biến dạng
//        let zPush = -abs(offset) * 60
//        t = CATransform3DTranslate(t, 0, 0, zPush)
//
//        // KHÔNG xoay: side items phẳng mặt
//        // (nếu muốn trung tâm phẳng, cứ để nguyên không rotate như thế này)
//
//        // Scale: giữa to, hai bên nhỏ dần nhưng vẫn rõ
//        let scale = 1.0 - min(abs(offset), 1.0) * 0.25
//        t = CATransform3DScale(t, scale, scale, 1)
//
//        return t
//    }
//    
//    func carousel(_ carousel: iCarousel,
//                  valueFor option: iCarouselOption,
//                  withDefault value: CGFloat) -> CGFloat {
//        switch option {
//        case .wrap:          return 1
//        case .spacing:       return value * 0.9
//        case .fadeMin:       return 0.0
//        case .fadeMax:       return 0.25
//        case .fadeMinAlpha:  return 0.25
//        case .visibleItems:  return 5
//        default:             return value
//        }
//    }
//
//    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) { updateTitle() }
//    private func updateTitle() {
//        let i = max(0, min(items.count - 1, carousel.currentItemIndex))
//        titleLabel.text = items[i].title
//    }
//}
//
//// MARK: - Helpers
//private extension UIColor {
//    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
//        let r = CGFloat((hex >> 16) & 0xFF) / 255.0
//        let g = CGFloat((hex >> 8) & 0xFF)  / 255.0
//        let b = CGFloat(hex & 0xFF)         / 255.0
//        self.init(red: r, green: g, blue: b, alpha: alpha)
//    }
//}
//
//import UIKit
//import iCarousel
//
//final class CarouselVC: UIViewController, iCarouselDataSource, iCarouselDelegate {
//    @IBOutlet weak var carousel: iCarousel!
//
//    let items = (1...5).map { "\($0)" }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        carousel.type = .linear
//        carousel.delegate = self
//        carousel.dataSource = self
//        carousel.isPagingEnabled = false
//        DispatchQueue.main.async { [weak self] in
//            let views = (self?.carousel.visibleItemViews as? [UIView]) ?? []
//            for v in views {
//                let idx = self?.carousel.index(ofItemView: v)
//                guard let content = v.viewWithTag(1001) else { continue }
//                guard let idx else {
//                    return
//                }
//                // offsetForItem(at:) -> khoảng cách logic đến tâm: 0, ±1, ±2, ...
//                let distance = min(abs(self?.carousel.offsetForItem(at: idx) ?? 2.0), 2.0)
//                let scale: CGFloat = 1.0 - 0.2 * distance   // 0→1.00, 1→0.80, 2→0.60
//                content.transform = CGAffineTransform(scaleX: scale, y: scale)
//                content.alpha = 0.7 + 0.3 * scale           // mờ nhẹ ngoài rìa (tuỳ chọn)
//            }
//                }
//    }
//
//    // MARK: - DataSource
//    func numberOfItems(in carousel: iCarousel) -> Int { items.count }
//
//    func carousel(_ carousel: iCarousel,
//                  viewForItemAt index: Int,
//                  reusing view: UIView?) -> UIView {
//
//        let size = CGSize(width: 80, height: 100)
//
//        let container: UIView
//        let content: UIView
//        let label: UILabel
//
//        if let reused = view,
//           let c = reused.viewWithTag(1001),
//           let l = reused.viewWithTag(1002) as? UILabel {
//            container = reused
//            content = c
//            label = l
//        } else {
//            // container do iCarousel điều khiển transform/position
//            let v = UIView(frame: CGRect(origin: .zero, size: size))
//            v.backgroundColor = .clear
//
//            // content bên trong để scale/alpha
//            let contentView = UIView(frame: v.bounds)
//            contentView.tag = 1001
//            contentView.layer.cornerRadius = 16
//            contentView.layer.masksToBounds = true
//
//            let l = UILabel(frame: contentView.bounds.insetBy(dx: 8, dy: 8))
//            l.tag = 1002
//            l.textAlignment = .center
//            l.font = .boldSystemFont(ofSize: 32)
//            l.textColor = .white
//
//            contentView.addSubview(l)
//            v.addSubview(contentView)
//
//            container = v
//            content = contentView
//            label = l
//        }
//
//        content.backgroundColor = [
//            .systemIndigo, .systemPink, .systemGreen, .systemTeal, .systemOrange
//        ][index % 5]
//        label.text = items[index]
//
//        // reset (tránh giữ transform từ lần reuse trước)
//        content.transform = .identity
//        content.alpha = 1.0
//
//        return container
//    }
//
//    // MARK: - Delegate options
//    func carousel(_ carousel: iCarousel,
//                  valueFor option: iCarouselOption,
//                  withDefault value: CGFloat) -> CGFloat {
//        switch option {
//        case .visibleItems: return 5         // luôn thấy 5 item
//        case .wrap:         return 1         // cuộn vô hạn
//        case .spacing:      return value
//        case .arc:          return 0         // phẳng
//        default:            return value
//        }
//    }
//
//    // MARK: - Scale theo khoảng cách tới tâm
//    func carouselDidScroll(_ carousel: iCarousel) {
//        // visibleItemViews là NSArray -> ép về [UIView]
//        let views = (carousel.visibleItemViews as? [UIView]) ?? []
//        for v in views {
//            let idx = carousel.index(ofItemView: v)
//            guard let content = v.viewWithTag(1001) else { continue }
//
//            // offsetForItem(at:) -> khoảng cách logic đến tâm: 0, ±1, ±2, ...
//            let distance = min(abs(carousel.offsetForItem(at: idx)), 2.0)
//            let scale: CGFloat = 1.0 - 0.2 * distance   // 0→1.00, 1→0.80, 2→0.60
//            content.transform = CGAffineTransform(scaleX: scale, y: scale)
//            content.alpha = 0.7 + 0.3 * scale           // mờ nhẹ ngoài rìa (tuỳ chọn)
//        }
//    }
//}
import UIKit

// MARK: - FlowLayout với scale theo khoảng cách tới tâm + snap giữa
final class CarouselFlowLayout: UICollectionViewFlowLayout {
    // giống iCarousel: 0→1.00, 1→0.80, 2→0.60
    var maxSteps: CGFloat = 2
    var stepScaleDrop: CGFloat = 0.2 // mỗi "bước" giảm 0.2
    var minScale: CGFloat { max(1 - maxSteps * stepScaleDrop, 0.4) }

    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
        minimumLineSpacing = 24

        guard let cv = collectionView else { return }
        let itemW: CGFloat = 80
        let itemH: CGFloat = 100
        itemSize = CGSize(width: itemW, height: itemH)

        // canh giữa item
        let insetX = (cv.bounds.width - itemW) / 2
        let insetY = max((cv.bounds.height - itemH) / 2, 0)
        sectionInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attrs = super.layoutAttributesForElements(in: rect),
              let cv = collectionView else { return nil }

        // phải clone attributes để tránh cảnh báo
        let copied = attrs.map { $0.copy() as! UICollectionViewLayoutAttributes }
        let centerX = cv.contentOffset.x + cv.bounds.width / 2
        let stepWidth = itemSize.width + minimumLineSpacing

        for a in copied where a.representedElementCategory == .cell {
            let distance = abs(a.center.x - centerX)
            // "số bước" logic tới tâm: 0, 1, 2, ...
            let steps = min(distance / stepWidth, maxSteps)
            let scale = max(1 - stepScaleDrop * steps, minScale)
            a.transform = CGAffineTransform(scaleX: scale, y: scale)
            a.alpha = 0.7 + 0.3 * scale
            a.zIndex = Int((scale * 1000).rounded())
        }
        return copied
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool { true }

    // Snap cell gần tâm về giữa khi kết thúc cuộn
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let cv = collectionView,
              let attrs = super.layoutAttributesForElements(in: cv.bounds.offsetBy(dx: proposedContentOffset.x - cv.contentOffset.x, dy: 0)),
              !attrs.isEmpty else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }

        let centerX = proposedContentOffset.x + cv.bounds.width / 2
        var minDelta = CGFloat.greatestFiniteMagnitude
        for a in attrs where a.representedElementCategory == .cell {
            let delta = a.center.x - centerX
            if abs(delta) < abs(minDelta) { minDelta = delta }
        }
        return CGPoint(x: proposedContentOffset.x + minDelta, y: proposedContentOffset.y)
    }
}

// MARK: - Cell
final class CarouselCell: UICollectionViewCell {
    static let reuseID = "CarouselCell"

    private let contentCard: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 16
        v.layer.masksToBounds = true
        v.tag = 1001 // để giống code iCarousel
        return v
    }()

    private let titleLabel: UILabel = {
        let l = UILabel()
        l.font = .boldSystemFont(ofSize: 32)
        l.textAlignment = .center
        l.textColor = .white
        l.tag = 1002
        return l
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.addSubview(contentCard)
        contentCard.addSubview(titleLabel)
    }
    required init?(coder: NSCoder) { super.init(coder: coder) }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentCard.frame = contentView.bounds
        titleLabel.frame = contentCard.bounds.insetBy(dx: 8, dy: 8)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        contentCard.transform = .identity
        contentCard.alpha = 1.0
    }

    func configure(text: String, color: UIColor) {
        titleLabel.text = text
        contentCard.backgroundColor = color
    }
}

// MARK: - ViewController
final class CarouselVC_Collection: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    private var collectionView: UICollectionView!
    private let layout = CarouselFlowLayout()

    // dữ liệu gốc giống iCarousel
    private let items = (1...5).map { "\($0)" }
    private let colors: [UIColor] = [.systemIndigo, .systemPink, .systemGreen, .systemTeal, .systemOrange]

    // Infinite scroll: nhân bản nhiều lần & nhảy vào giữa
    private let repeatCount = 200 // 5 * 200 = 1000 items
    private var bigData: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        bigData = Array(repeating: items, count: repeatCount).flatMap { $0 }

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.reuseID)

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // cuộn tới giữa ngay sau layout lần đầu
        view.layoutIfNeeded()
        let middle = (bigData.count / 2)
        collectionView.scrollToItem(at: IndexPath(item: middle, section: 0), at: .centeredHorizontally, animated: false)
    }

    // MARK: DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bigData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.reuseID, for: indexPath) as! CarouselCell
        let value = bigData[indexPath.item]
        let color = colors[indexPath.item % colors.count]
        cell.configure(text: value, color: color)
        return cell
    }

    // MARK: Delegate (giữ infinite scroll mượt)
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) { recenterIfNeeded() }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate { recenterIfNeeded() }
    }

    private func recenterIfNeeded() {
        // Khi người dùng cuộn quá xa về một phía, nhảy về giữa nhưng giữ item đang nhìn
        guard let indexPath = nearestCenteredIndexPath() else { return }
        let logicalIndex = indexPath.item % items.count
        // chọn một index ở "dải giữa" có cùng logicalIndex
        let middleBandStart = (bigData.count / 2) - (bigData.count / 10)
        let target = middleBandStart + logicalIndex
        collectionView.scrollToItem(at: IndexPath(item: target, section: 0), at: .centeredHorizontally, animated: false)
    }

    private func nearestCenteredIndexPath() -> IndexPath? {
        let center = view.convert(collectionView.center, to: collectionView)
        return collectionView.indexPathForItem(at: center)
    }
}
