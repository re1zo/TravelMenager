import RxCocoa
import RxSwift

final class MyPlacesViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var dismissButton: UIButton!
    
    // MARK: - Variables
    
    private var places: [Int] = [1,2,3,4,5,6,7,8,9]
    
    private let bag = DisposeBag()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "MyPlacesCell", bundle: nil), forCellWithReuseIdentifier: "defaultMyPlacesCell")
        dismissButton.rx.tap.bind { self.dismiss(animated: true) }.disposed(by: bag)
    }
}
// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MyPlacesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (view.frame.width / 2.5) - 13 , height: 130)
     }
}
