import RxCocoa
import RxSwift

final class MyPlacesViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var placesCollectionView: UICollectionView!
    @IBOutlet private var swipeDownGesture: UISwipeGestureRecognizer!
    
    // MARK: - Variables

    private var places: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9]

    private let bag = DisposeBag()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        placesCollectionView.register(UINib(nibName: "MyPlacesCell", bundle: nil), forCellWithReuseIdentifier: "defaultMyPlacesCell")
        swipeDownGesture.addTarget(self, action: #selector(dismissPlaces))
    }
    
    @objc private func dismissPlaces() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension MyPlacesViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        places.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultMyPlacesCell", for: indexPath) as? MyPlacesCell else {
            return UICollectionViewCell()
        }
        cell.titleLabel.text = "Warsaw"
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
}

// MARK: - UICollectionViewFlowLayout

extension MyPlacesViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        CGSize(width: (view.frame.width / 2.5) - 13, height: 130)
    }
}
