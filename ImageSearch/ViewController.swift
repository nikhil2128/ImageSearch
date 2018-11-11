//
//  ViewController.swift
//  ImageSearch
//
//  Created by Jyoti Gupta on 10/11/18.
//  Copyright © 2018 Nikhil Bansal. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let photosViewModel = PhotosViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addNavigationBarWithTitle(title: "Search Image")
    }
    
    private func fetchData(text:String){
        UIUtils.showProgressView(view: self.view, animated: true)
        
        weak var weakSelf = self
        
        photosViewModel.searchPhotos(text: text) { (photos) in
            UIUtils.hideProgressView(view: (weakSelf?.view)!, animated: true)
            weakSelf?.collectionView.reloadData()
        }
    }
}

extension ViewController: UISearchBarDelegate{
    //MARK: UISearchBar Delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text == nil || searchBar.text?.isValid() == false {
            UIUtils.showAlert(title: "Oops!", message: "Please enter keyword to search", cntrllr: self)
            return
        }
        fetchData(text: searchBar.text!)
        searchBar.resignFirstResponder()
    }
}

extension ViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (photosViewModel.photosModel.photos.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        let photoModel = photosViewModel.photosModel.photos[indexPath.row]
        
        cell.imgView.image = nil
        
        photosViewModel.downloadImageFromUrl(photoModel.imgUrl!,row: indexPath.row) { (img,row) in
            if img != nil && row == indexPath.row{
                cell.displayData(img: img!)
            }
        }
        
        return cell
    }
}

extension ViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height){
            if photosViewModel.isFetchingData == false {
                weak var weakSelf = self
                photosViewModel.loadNextPage { (photos) in
                    UIUtils.hideProgressView(view: (weakSelf?.view)!, animated: true)
                    
                    if photos != nil {
                        var indexes = [IndexPath]()
                        
                        let totalPhotos = (weakSelf?.photosViewModel.photosModel.photos.count)!
                        
                        let startIndex = totalPhotos - (photos?.count)!
                        
                        
                        for i in startIndex..<totalPhotos{
                            indexes.append(IndexPath(row: i, section: 0))
                        }
                        weakSelf?.collectionView.performBatchUpdates({
                            weakSelf?.collectionView.insertItems(at: indexes)
                        }, completion:{ (isDone) in
                            weakSelf?.photosViewModel.isFetchingData = false
                        } )
                    }
                }
            }
        }
    }
}

