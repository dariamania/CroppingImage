//
//  ViewController.swift
//  CroppingImage
//
//  Created by Dariia Pavlovskaya on 17.12.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private let squareView = UIView()
    private let imageView = CustomImageView()
    private let anotherView = UIView()
    private let split3Button = UIButton()
    private let split5Button = UIButton()
    private var imageArray = [[UIImage]]()
    private var imageViewArray = [[UIImageView]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        split3Button.addTarget(self, action: #selector(split3ButtonTapped), for: UIControl.Event.touchDown)
        split5Button.addTarget(self, action: #selector(Split5ButtonTapped), for: UIControl.Event.touchDown)
    }

}

private extension ViewController {
    private func setupSubviews() {
        view.backgroundColor = .white
        
        view.addSubview(split3Button)
        split3Button.translatesAutoresizingMaskIntoConstraints = false
        split3Button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        split3Button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        split3Button.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        split3Button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        split3Button.setTitle("Split in 3!", for: UIControl.State.normal)
        split3Button.setTitleColor(UIColor.purple, for: UIControl.State.normal)
        
        view.addSubview(split5Button)
        split5Button.translatesAutoresizingMaskIntoConstraints = false
        split5Button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        split5Button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        split5Button.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        split5Button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        split5Button.setTitle("Split in 5!", for: UIControl.State.normal)
        split5Button.setTitleColor(UIColor.purple, for: UIControl.State.normal)
        
        view.addSubview(squareView)
        squareView.backgroundColor = .lightGray
        squareView.translatesAutoresizingMaskIntoConstraints = false
        squareView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
        squareView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
        squareView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        squareView.topAnchor.constraint(equalTo: split3Button.bottomAnchor, constant: 30).isActive = true
        squareView.clipsToBounds = true
        
        view.addSubview(anotherView)
        anotherView.backgroundColor = .cyan
        anotherView.translatesAutoresizingMaskIntoConstraints = false
        anotherView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
        anotherView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
        anotherView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        anotherView.topAnchor.constraint(equalTo: split3Button.bottomAnchor, constant: 30).isActive = true
        anotherView.clipsToBounds = true
        anotherView.isHidden = true
        
        squareView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: squareView.leftAnchor, constant: 0).isActive = true
        imageView.rightAnchor.constraint(equalTo: squareView.rightAnchor, constant: 0).isActive = true
        imageView.topAnchor.constraint(equalTo: squareView.topAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: squareView.bottomAnchor, constant: 0).isActive = true
        imageView.downloadImageFrom(urlString: "https://i.imgur.com/wmeS8PL.jpg", imageMode: .scaleAspectFill)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
    }
    
    @objc private func split3ButtonTapped() {
        imageView.isHidden.toggle()
        let height = imageView.image?.size.height
        let width = imageView.image?.size.width
        print("height = \(height ?? 0), width = \(width ?? 0)")
        print(imageView.image?.scale)
        print(squareView.frame.width)
        print(squareView.frame.height)
        if imageView.isHidden {
            let size = Double(squareView.frame.width / 3) - 1.0
            //print(squareView.frame.width)
            //print(size)
            splitImage(into: 3)
            layoutCroppedImage(from: imageViewArray)
//            squareView.addSubview(smallImageView)
//            smallImageView.translatesAutoresizingMaskIntoConstraints = false
//            smallImageView.backgroundColor = .systemPink
//            smallImageView.leftAnchor.constraint(equalTo: squareView.leftAnchor, constant: 0).isActive = true
//            smallImageView.topAnchor.constraint(equalTo: squareView.topAnchor, constant: 0).isActive = true
//            smallImageView.widthAnchor.constraint(equalToConstant: size).isActive = true
//            smallImageView.heightAnchor.constraint(equalToConstant: size).isActive = true
//            smallImageView.isHidden = false
//            smallImageView.image = imageArray[0][0]
//            smallImageView.contentMode = .scaleAspectFit
//            smallImageView.clipsToBounds = true
        }
    }
    
    @objc private func Split5ButtonTapped() {
        imageView.isHidden.toggle()
        let height = imageView.image?.size.height
        let width = imageView.image?.size.width
        print("height = \(height ?? 0), width = \(width ?? 0)")
        if imageView.isHidden {
            let size = Double(squareView.frame.width / 5) - 1.0
            print(size)
            splitImage(into: 5)
            layoutCroppedImage(from: imageViewArray)
        }
    }
    
    private func splitImage(into number: Int) {
        
        let oImg = imageView.image

        let height = (imageView.image?.size.height)! /  CGFloat(number) //height of each image tile
        let width = (imageView.image?.size.width)!  / CGFloat(number)  //width of each image tile

        let scale = (imageView.image?.scale)! //scale conversion factor is needed as UIImage make use of "points" whereas CGImage use pixels.

        var imageArr = [[UIImage]]() // will contain small pieces of image
        var viewArr = [[UIImageView]]()
        for y in 0..<number {
            var yArr = [UIImage]()
            var yImgArr = [UIImageView]()
            for x in 0..<number {

                UIGraphicsBeginImageContextWithOptions(
                    CGSize(width: width, height: height),
                    false, 0)
                let i =  oImg?.cgImage?.cropping(to: CGRect.init(
                    x: CGFloat(x) * width * scale,
                    y:  CGFloat(y) * height * scale  ,
                    width: (width * scale) ,
                    height: (height * scale)) )

                let newImg = UIImage.init(cgImage: i!)
                var newImgView = UIImageView()
                newImgView.image = newImg
                yArr.append(newImg)
                yImgArr.append(newImgView)

                UIGraphicsEndImageContext();
            }
            imageArr.append(yArr)
            viewArr.append(yImgArr)
        }
        imageArray = imageArr
        imageViewArray = viewArr
    }
    
    private func layoutCroppedImage(from array: [[UIImageView]]) {
        let rows = array.count
        if rows == 0 { return print("Zero rows in array of UIImageViews") }
        let columns = array[0].count
        if rows != columns {
            return print("Image is not square")
        }
        let cell = Int(squareView.frame.width / Double(rows))
        let size = Double(squareView.frame.width / Double(rows)) - 3.0
        let intSize = Int(size)
        print(size)
        print(intSize)
        for y in 0..<rows {
            for x in 0..<columns {
                let viewItem = array[y][x]
                squareView.addSubview(viewItem)
                viewItem.translatesAutoresizingMaskIntoConstraints = false
                viewItem.backgroundColor = .systemPink
                viewItem.leftAnchor.constraint(equalTo: squareView.leftAnchor, constant: CGFloat(x * cell)).isActive = true
                viewItem.topAnchor.constraint(equalTo: squareView.topAnchor, constant: CGFloat(y * cell)).isActive = true
                viewItem.widthAnchor.constraint(equalToConstant: size).isActive = true
                viewItem.heightAnchor.constraint(equalToConstant: size).isActive = true
                viewItem.contentMode = .scaleAspectFit
                viewItem.clipsToBounds = true
            }
        }
    }
}

