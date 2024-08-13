//
//  PhotosViewController.swift
//  Navigation
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {

    let photoIdent = "photoCell"
    var photos: [UIImage] = [] // Список фотографий, который будет заполняться через подписку

    // Экземпляр фасада
    var imagePublisherFacade: ImagePublisherFacade?

    // MARK: Visual objects

    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
        return layout
    }()

    lazy var photosCollectionView: UICollectionView = {
        let photos = UICollectionView(frame: .zero, collectionViewLayout: layout)
        photos.translatesAutoresizingMaskIntoConstraints = false
        photos.backgroundColor = .white
        photos.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: photoIdent)
        return photos
    }()

    // MARK: - Setup section

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Photo Gallery"
        self.view.addSubview(photosCollectionView)
        self.photosCollectionView.dataSource = self
        self.photosCollectionView.delegate = self
        setupConstraints()

        // Создаем и подписываемся на ImagePublisher
        imagePublisherFacade = ImagePublisherFacade()
        imagePublisherFacade?.addImagesWithTimer(time: 0.5, repeat: 10) // Запускаем процесс добавления изображений
        imagePublisherFacade?.subscribe(self) // Подписываем PhotosViewController на публикацию изображений
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true

        // Отписываемся при выходе из экрана
        imagePublisherFacade?.removeSubscription(for: self)
    }
}

// MARK: - Extensions

extension PhotosViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let countItem: CGFloat = 2
        let accessibleWidth = collectionView.frame.width - 32
        let widthItem = (accessibleWidth / countItem)
        return CGSize(width: widthItem, height: widthItem * 0.56)
    }
}

extension PhotosViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoIdent, for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell()}
        cell.configCellCollection(photo: photos[indexPath.item])
        return cell
    }
}

// MARK: - ImageLibrarySubscriber

extension PhotosViewController: ImageLibrarySubscriber {

    // Метод протокола для добавления изображений
    func receive(images: [UIImage]) {
        self.photos.append(contentsOf: images)
        self.photosCollectionView.reloadData() // Обновляем коллекцию после получения новых изображений
    }
}
