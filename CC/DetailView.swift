//
//  DetailView.swift
//  CC
//
//  Created by Vahid Ghanbarpour on 12/8/17.
//  Copyright © 2017 Vahid Ghanbarpour. All rights reserved.
//

import UIKit

class DetailView: UIViewController, UIScrollViewDelegate {

    var detailArray = [String]()
    var contentScrollView = UIScrollView()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        navigationController?.setToolbarHidden(false, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        navigationController?.setToolbarHidden(true, animated: true)
        self.title = Global.name
        
        contentScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        contentScrollView.contentSize.height = view.frame.size.height
        contentScrollView.delegate = self
        contentScrollView.showsVerticalScrollIndicator = false
        contentScrollView.showsHorizontalScrollIndicator = false
        view.backgroundColor = UIColor(hex: "344f8d")
        view.addSubview(self.contentScrollView)
        
        let rankNsymbolView = UIView(frame: CGRect(x: 8, y: 8, width: view.frame.size.width - 16, height: 50))
        rankNsymbolView.layer.cornerRadius = 5.0
        rankNsymbolView.backgroundColor = UIColor(hex: "2c3881")
        let trophyImage = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        trophyImage.image = UIImage(named: "trophy")
        rankNsymbolView.addSubview(trophyImage)
        let rankNsymbol = UILabel(frame: CGRect(x: 45, y: 10, width: rankNsymbolView.frame.size.width - 45, height: 30))
        rankNsymbol.textColor = UIColor.white
        rankNsymbol.text = Global.rank + "  " + Global.symbol
        rankNsymbolView.addSubview(rankNsymbol)
        contentScrollView.addSubview(rankNsymbolView)
        
        let usdPriceView = UIView(frame: CGRect(x: 8, y: 64, width: view.frame.size.width - 16, height: 80))
        usdPriceView.layer.cornerRadius = 5.0
        usdPriceView.backgroundColor = UIColor(hex: "2c3881")
        let usdPriceImage = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        usdPriceImage.image = UIImage(named: "usd")
        usdPriceView.addSubview(usdPriceImage)
        let usdPriceDescription = UILabel(frame: CGRect(x: 0, y: 0, width: usdPriceView.frame.size.width, height: 40))
        usdPriceDescription.text = "USD Price"
        usdPriceDescription.textColor = UIColor.white
        usdPriceDescription.textAlignment = .center
        usdPriceView.addSubview(usdPriceDescription)
        let usdPrice = UILabel(frame: CGRect(x: 0, y: 40, width: usdPriceView.frame.size.width, height: 40))
        usdPrice.textColor = UIColor(hex: "2c3881")
        usdPrice.text = "$" + Global.usdPrice
        usdPrice.textAlignment = .center
        let rectShape = CAShapeLayer()
        rectShape.bounds = usdPrice.frame
        rectShape.position = usdPrice.center
        rectShape.path = UIBezierPath(roundedRect: usdPrice.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        usdPrice.layer.backgroundColor = UIColor.white.cgColor
        usdPrice.layer.mask = rectShape
        usdPriceView.addSubview(usdPrice)
        contentScrollView.addSubview(usdPriceView)

        
        let bitcoinPriceView = UIView(frame: CGRect(x: 8, y: 152, width: view.frame.size.width - 16, height: 80))
        bitcoinPriceView.layer.cornerRadius = 5.0
        bitcoinPriceView.backgroundColor = UIColor(hex: "2c3881")
        let bitcoinPriceDescription = UILabel(frame: CGRect(x: 0, y: 0, width: usdPriceView.frame.size.width, height: 40))
        bitcoinPriceDescription.text = "Bitcoin Price"
        bitcoinPriceDescription.textColor = UIColor.white
        bitcoinPriceDescription.textAlignment = .center
        let bitcoinImage = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        bitcoinImage.image = UIImage(named: "bitcoin")
        bitcoinPriceDescription.addSubview(bitcoinImage)
        bitcoinPriceView.addSubview(bitcoinPriceDescription)
        let bitcoinPrice = UILabel(frame: CGRect(x: 0, y: 40, width: bitcoinPriceView.frame.size.width, height: 40))
        bitcoinPrice.textColor = UIColor(hex: "2c3881")
        bitcoinPrice.text = Global.btcPrice
        bitcoinPrice.backgroundColor = UIColor.white
        bitcoinPrice.textAlignment = .center
        
        let rectShape1 = CAShapeLayer()
        rectShape1.bounds = bitcoinPrice.frame
        rectShape1.position = bitcoinPrice.center
        rectShape1.path = UIBezierPath(roundedRect: bitcoinPrice.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        bitcoinPrice.layer.backgroundColor = UIColor.white.cgColor
        bitcoinPrice.layer.mask = rectShape1
        
        bitcoinPriceView.addSubview(bitcoinPrice)
        contentScrollView.addSubview(bitcoinPriceView)

        let usdMarketCapView = UIView(frame: CGRect(x: 8, y: 240, width: view.frame.size.width - 16, height: 80))
        usdMarketCapView.layer.cornerRadius = 5.0
        usdMarketCapView.backgroundColor = UIColor(hex: "2c3881")
        let usdMarketCapDescription = UILabel(frame: CGRect(x: 0, y: 0, width: usdPriceView.frame.size.width, height: 40))
        usdMarketCapDescription.text = "USD Market Cap"
        usdMarketCapDescription.textColor = UIColor.white
        usdMarketCapDescription.textAlignment = .center
        usdMarketCapView.addSubview(usdMarketCapDescription)
        let usdMarketCap = UILabel(frame: CGRect(x: 0, y: 40, width: usdPriceView.frame.size.width, height: 40))
        usdMarketCap.backgroundColor = UIColor.white
        usdMarketCap.textColor = UIColor(hex: "2c3881")
        usdMarketCap.text = "$" + Global.usdMarketCap
        usdMarketCap.textAlignment = .center
        let rectShape2 = CAShapeLayer()
        rectShape2.bounds = usdMarketCap.frame
        rectShape2.position = usdMarketCap.center
        rectShape2.path = UIBezierPath(roundedRect: usdMarketCap.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        usdMarketCap.layer.backgroundColor = UIColor.white.cgColor
        usdMarketCap.layer.mask = rectShape2
        usdMarketCapView.addSubview(usdMarketCap)
        contentScrollView.addSubview(usdMarketCapView)
        
        let usd24hVView = UIView(frame: CGRect(x: 8, y: 328, width: view.frame.size.width - 16, height: 80))
        usd24hVView.layer.cornerRadius = 5.0
        usd24hVView.backgroundColor = UIColor(hex: "2c3881")
        let usd24hVDescription = UILabel(frame: CGRect(x: 0, y: 0, width: usdPriceView.frame.size.width, height: 40))
        usd24hVDescription.text = "USD last 24h Market Volume"
        usd24hVDescription.textColor = UIColor.white
        usd24hVDescription.textAlignment = .center
        usd24hVView.addSubview(usd24hVDescription)
        let usd24hV = UILabel(frame: CGRect(x: 0, y: 40, width: usdPriceView.frame.size.width, height: 40))
        usd24hV.backgroundColor = UIColor.white
        usd24hV.textColor = UIColor(hex: "2c3881")
        usd24hV.text = "$" + Global.usd24hV
        usd24hV.textAlignment = .center
        let rectShape3 = CAShapeLayer()
        rectShape3.bounds = usd24hV.frame
        rectShape3.position = usd24hV.center
        rectShape3.path = UIBezierPath(roundedRect: usd24hV.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        usd24hV.layer.backgroundColor = UIColor.white.cgColor
        usd24hV.layer.mask = rectShape3
        usd24hVView.addSubview(usd24hV)
        contentScrollView.addSubview(usd24hVView)

        
        
        let CPView = UIView(frame: CGRect(x: 8, y: 416, width: view.frame.size.width - 16, height: 80))
        CPView.layer.cornerRadius = 5.0
        CPView.backgroundColor = UIColor(hex: "2c3881")
        
        let CPVDescription = UILabel(frame: CGRect(x: 0, y: 0, width: CPView.frame.size.width / 3, height: 40))
        CPVDescription.text = "1h"
        CPVDescription.textColor = UIColor.white
        CPVDescription.textAlignment = .center
        CPView.addSubview(CPVDescription)
        let CP = UILabel(frame: CGRect(x: 0, y: 40, width: CPView.frame.size.width / 3, height: 40))
        CP.backgroundColor = UIColor.white
        CP.textColor = UIColor(hex: "2c3881")
        CP.text = "%" + Global.CP1h
        CP.textAlignment = .center
        
        let rectShape4 = CAShapeLayer()
        rectShape4.bounds = CP.frame
        rectShape4.position = CP.center
        rectShape4.path = UIBezierPath(roundedRect: CP.bounds, byRoundingCorners: [.bottomLeft], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        CP.layer.backgroundColor = UIColor.white.cgColor
        CP.layer.mask = rectShape4

        let CPVDescription1 = UILabel(frame: CGRect(x: CPView.frame.size.width / 3, y: 0, width: CPView.frame.size.width / 3, height: 40))
        CPVDescription1.text = "24h"
        CPVDescription1.textColor = UIColor.white
        CPVDescription1.textAlignment = .center
        CPView.addSubview(CPVDescription1)
        let CP1 = UILabel(frame: CGRect(x: CPView.frame.size.width / 3, y: 40, width: CPView.frame.size.width / 3, height: 40))
        CP1.backgroundColor = UIColor.white
        CP1.textColor = UIColor(hex: "2c3881")
        CP1.text = "%" + Global.CP24h
        CP1.textAlignment = .center

        let CPVDescription2 = UILabel(frame: CGRect(x: CPView.frame.size.width * (2 / 3), y: 0, width: CPView.frame.size.width / 3, height: 40))
        CPVDescription2.text = "7d"
        CPVDescription2.textColor = UIColor.white
        CPVDescription2.textAlignment = .center
        CPView.addSubview(CPVDescription2)
        let CP2 = UILabel(frame: CGRect(x: CPView.frame.size.width * (2 / 3) - 1, y: 40, width: CPView.frame.size.width / 3 + 1, height: 40))
        CP2.backgroundColor = UIColor.white
        CP2.textColor = UIColor(hex: "2c3881")
        CP2.text = "%" + Global.CP7d
        CP2.textAlignment = .center

        let rectShape5 = CAShapeLayer()
        rectShape5.bounds = usd24hV.frame
        rectShape5.position = usd24hV.center
        rectShape5.path = UIBezierPath(roundedRect: CP2.bounds, byRoundingCorners: [.bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        CP2.layer.backgroundColor = UIColor.white.cgColor
        CP2.layer.mask = rectShape5
        
        CPView.addSubview(CP)
        CPView.addSubview(CP1)
        CPView.addSubview(CP2)
        contentScrollView.addSubview(CPView)

        
        
        
        detailArray.append(Global.rank)
        detailArray.append(Global.name)
        detailArray.append(Global.symbol)
        detailArray.append(Global.usdPrice)
        detailArray.append(Global.btcPrice)
        detailArray.append(Global.usd24hV)
        detailArray.append(Global.usdMarketCap)
        detailArray.append(Global.CP1h)
        detailArray.append(Global.CP24h)
        detailArray.append(Global.CP7d)
    }
}
