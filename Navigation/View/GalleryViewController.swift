import UIKit

class GalleryViewController: UIViewController, Coordinated {
    
    var coordinator: CoordinatorProtocol?
    
    var storage = PhotoStorage()

    var largePhotoIndexPath: IndexPath? {
        didSet {
            var indexPaths: [IndexPath] = []
            if let largePhotoIndexPath = largePhotoIndexPath {
                indexPaths.append(largePhotoIndexPath)
            }
            
            if let oldValue = oldValue {
                indexPaths.append(oldValue)
            }
            
            collectionView.performBatchUpdates({
                
                self.collectionView.reloadItems(at: indexPaths)
            },completion: { _ in
                if let largePhotoIndexPath = self.largePhotoIndexPath {
                        self.collectionView.scrollToItem(
                        at: largePhotoIndexPath,
                        at: .centeredVertically,
                        animated: true)
                }
            })
        }
    }
    
    func deleteCell(_ image: UIImage) {
        guard storage.photoGrid.count >= 0 else { return }
        let oldStorage = storage.photoGrid
        var newStorage = storage.photoGrid
        if newStorage.count == 1 {
            newStorage = []
        } else if newStorage.count > 1 {
            for i in 0...newStorage.count - 2 {
                if newStorage[i].image == image {
                    newStorage.remove(at: i)
                }
            }
        }
        storage.photoGrid = newStorage
        
        self.collectionView.reloadData()
    }
    
    private let sectionInsets = UIEdgeInsets(
      top: 50.0,
      left: 20.0,
      bottom: 50.0,
      right: 20.0)
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.identifier)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private func setupViews() {

        view.addSubview(collectionView)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()

        let constraints = [
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Photo gallery"
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Photo gallery"
    }

}
extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storage.photoGrid.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identifier,
                                                            for: indexPath) as? GalleryCollectionViewCell
        else {
            preconditionFailure("Invalid cell type")
        }
        cell.sourse = storage.photoGrid[indexPath.row]
        cell.controller = self

        guard indexPath == largePhotoIndexPath else {
            cell.trashView.isHidden = true
            return cell
        }
        cell.trashView.isHidden = false
        cell.trashView.isUserInteractionEnabled = true
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath == largePhotoIndexPath {
          var size = collectionView.bounds.size
          size.height -= (self.sectionInsets.top +
                          self.sectionInsets.right)
          size.width -= (self.sectionInsets.left +
                         self.sectionInsets.right)
          return size
        }
        
        return CGSize(width:(view.bounds.width - 8 * 4)/3, height: (view.bounds.width - 8 * 4)/3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(8.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(8.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {

      if largePhotoIndexPath == indexPath {
        largePhotoIndexPath = nil
      } else {
        largePhotoIndexPath = indexPath
      }

      return false
    }
    
}
