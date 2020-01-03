import RxCocoa
import RxSwift

final class MyPlacesViewController: UIViewController, UICollectionViewDelegate {

    // MARK: - Outlets

    @IBOutlet private weak var placesCollectionView: UICollectionView!
    @IBOutlet private weak var closeButton: StandardStyledUIButton!

    // MARK: - Variables

    var myPlacesViewModel: MyPlacesViewModel!

    private let bag = DisposeBag()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }

    func bindUI() {
        closeButton.rx.tap
            .bind(to: myPlacesViewModel.onUsedPlaces)
            .disposed(by: bag)

        placesCollectionView.register(UINib(nibName: "MyPlacesCell", bundle: nil), forCellWithReuseIdentifier: "defaultMyPlacesCell")
        placesCollectionView.rx.setDelegate(self)
            .disposed(by: bag)

        myPlacesViewModel.placesViewModels
            .bind(to: placesCollectionView.rx.items(cellIdentifier: "defaultMyPlacesCell", cellType: MyPlacesCell.self)) { _, viewModel, cell in
                cell.viewModel = viewModel
            }
            .disposed(by: bag)
        
        placesCollectionView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                self.placesCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
                self.myPlacesViewModel.selected.onNext(indexPath.row)
            })
            .disposed(by: bag)
    }
}

// MARK: - UICollectionViewFlowLayout

extension MyPlacesViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        CGSize(width: (view.frame.width / 2.5) - 13, height: 130)
    }
}
