//
//  ViewController.swift
//  CC
//
//  Created by Vahid Ghanbarpour on 12/6/17.
//  Copyright © 2017 Vahid Ghanbarpour. All rights reserved.
//

import UIKit

struct Global {
    static var rankArray = [String]()
    static var nameArray = [String]()
    static var symbolArray = [String]()
    static var usdPriceArray = [String]()
    static var btcPriceArray = [String]()
    static var usd24hVArray = [String]()
    static var usdMarketCapArray = [String]()
    static var CP1hArray = [String]()
    static var CP24hArray = [String]()
    static var CP7dArray = [String]()
    static var rank = String()
    static var name = String()
    static var symbol = String()
    static var usdPrice = String()
    static var btcPrice = String()
    static var usd24hV = String()
    static var usdMarketCap = String()
    static var CP1h = String()
    static var CP24h = String()
    static var CP7d = String()
    
    static var internetStatus: Bool! = false
}

import SystemConfiguration

public class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
         */
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
}

class Home: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var dataCollection: UICollectionView!
    var startingPoint = 0
    var nextButton: UIButton!
    var previousButton: UIButton!
    var nextLabel: UILabel!
    var previousLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if Global.internetStatus == true {
            makeRequest()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.title = "Cryptopenny"

        navigationController?.navigationBar.barTintColor = UIColor(hex: "2c3881")
        navigationController?.navigationBar.backgroundColor = UIColor(hex: "2c3881")
        let titleDict: NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedStringKey : Any]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.toolbar.barTintColor = UIColor(hex: "2c3881")
        navigationController?.toolbar.backgroundColor = UIColor(hex: "2c3881")
        navigationController?.toolbar.tintColor = UIColor.white

        view.backgroundColor = UIColor(hex: "344f8d")
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        dataCollection = UICollectionView(frame: CGRect(x: 8, y: 0, width: self.view.frame.size.width - 16, height: self.view.frame.size.height - 108), collectionViewLayout: flowLayout)
        dataCollection.register(dataCollectionCell.self, forCellWithReuseIdentifier: "dataCollectionCell")
        dataCollection.delegate = self
        dataCollection.dataSource = self
        dataCollection.backgroundColor = UIColor.clear
        dataCollection.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
        dataCollection.showsVerticalScrollIndicator = false
        dataCollection.showsHorizontalScrollIndicator = false
        view.addSubview(dataCollection)

        makeRequest()
        
        
        nextButton = UIButton(type: .custom)
        nextButton.setTitle("Next", for: UIControlState())
        nextButton.setTitleColor(UIColor.white, for: UIControlState())
        nextButton.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        nextButton.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: nextButton)
        
        previousButton = UIButton(type: .custom)
        previousButton.setTitle("Previous", for: UIControlState())
        previousButton.setTitleColor(UIColor.gray, for: UIControlState())
        previousButton.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        let item2 = UIBarButtonItem(customView: previousButton)
        
        setToolbarItems([item2, item1], animated: true)
    }
    
    func makeRequest() {
        if Reachability.isConnectedToNetwork() {
            StartIndicator()
            let url = URL(string: "https://api.coinmarketcap.com/v1/ticker/?start=" + "\(startingPoint)")
            let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if error != nil {
                    print(error!)
                } else {
                    if let urlContent = data {
                        do {
                            let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as! [AnyObject]
                            var i: Int!
                            for i in 0..<jsonResult.count {
                                Global.rankArray.append(String(describing: jsonResult[i]["rank"]!!))
                                Global.nameArray.append(String(describing: jsonResult[i]["name"]!!))
                                Global.symbolArray.append(String(describing: jsonResult[i]["symbol"]!!))
                                Global.usdPriceArray.append(String(describing: jsonResult[i]["price_usd"]!!))
                                Global.btcPriceArray.append(String(describing: jsonResult[i]["price_btc"]!!))
                                Global.usd24hVArray.append(String(describing: jsonResult[i]["24h_volume_usd"]!!))
                                Global.usdMarketCapArray.append(String(describing: jsonResult[i]["market_cap_usd"]!!))
                                Global.CP1hArray.append(String(describing: jsonResult[i]["percent_change_1h"]!!))
                                Global.CP24hArray.append(String(describing: jsonResult[i]["percent_change_24h"]!!))
                                Global.CP7dArray.append(String(describing: jsonResult[i]["percent_change_7d"]!!))
                            }
                            
                            DispatchQueue.main.async {
                                self.dataCollection.reloadData()
                                self.EndIndicator()
                            }
                            
                        } catch {
                            print("Error")
                        }
                    }
                }
            }
            task.resume()
        } else {
            self.performSegue(withIdentifier: "noConnection", sender: self)
        }
    }
    
    @objc func nextPressed() {
        startingPoint = startingPoint + 100
        
        Global.rankArray.removeAll()
        Global.nameArray.removeAll()
        Global.symbolArray.removeAll()
        Global.usdPriceArray.removeAll()
        Global.btcPriceArray.removeAll()
        Global.usd24hVArray.removeAll()
        Global.usdMarketCapArray.removeAll()
        Global.CP1hArray.removeAll()
        Global.CP24hArray.removeAll()
        Global.CP7dArray.removeAll()

        if startingPoint == 1300 {
            nextButton.removeTarget(self, action: #selector(self.nextPressed), for: .touchUpInside)
            nextButton.setTitleColor(UIColor.gray, for: UIControlState())
        } else {
            nextButton.addTarget(self, action: #selector(self.nextPressed), for: .touchUpInside)
            nextButton.setTitleColor(UIColor.white, for: UIControlState())
        }

        if self.startingPoint == 0 {
            previousButton.removeTarget(self, action: #selector(self.previousPressed), for: .touchUpInside)
            previousButton.setTitleColor(UIColor.gray, for: UIControlState())
        } else {
            previousButton.addTarget(self, action: #selector(self.previousPressed), for: .touchUpInside)
            previousButton.setTitleColor(UIColor.white, for: UIControlState())
        }

        makeRequest()
        self.dataCollection.reloadData()
    }

    @objc func previousPressed() {
        startingPoint = startingPoint - 100
        
        Global.rankArray.removeAll()
        Global.nameArray.removeAll()
        Global.symbolArray.removeAll()
        Global.usdPriceArray.removeAll()
        Global.btcPriceArray.removeAll()
        Global.usd24hVArray.removeAll()
        Global.usdMarketCapArray.removeAll()
        Global.CP1hArray.removeAll()
        Global.CP24hArray.removeAll()
        Global.CP7dArray.removeAll()

        if startingPoint == 1300 {
            nextButton.removeTarget(self, action: #selector(self.nextPressed), for: .touchUpInside)
            nextButton.setTitleColor(UIColor.gray, for: UIControlState())
        } else {
            nextButton.addTarget(self, action: #selector(self.nextPressed), for: .touchUpInside)
            nextButton.setTitleColor(UIColor.white, for: UIControlState())
        }
        
        if self.startingPoint == 0 {
            previousButton.removeTarget(self, action: #selector(self.previousPressed), for: .touchUpInside)
            previousButton.setTitleColor(UIColor.gray, for: UIControlState())
        } else {
            previousButton.addTarget(self, action: #selector(self.previousPressed), for: .touchUpInside)
            previousButton.setTitleColor(UIColor.white, for: UIControlState())
        }

        makeRequest()
        self.dataCollection.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Global.rankArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dataCollectionCell", for: indexPath) as! dataCollectionCell
        
        if Global.rankArray.count > 0 {
            cell.rankNsymbol?.text = Global.rankArray[indexPath.row] + "   " + Global.symbolArray[indexPath.row]
            cell.recentChange?.text = "%" + Global.CP24hArray[indexPath.row]
            if Global.CP24hArray[indexPath.row][0] == "-" {
                cell.recentChangeImage.image = UIImage(named: "decrease")
                cell.recentChange.textColor = UIColor(hex: "EE2A2B")
                cell.usdPrice.textColor = UIColor(hex: "EE2A2B")
            } else {
                cell.recentChangeImage.image = UIImage(named: "increase")
                cell.recentChange.textColor = UIColor(hex: "41A340")
                cell.usdPrice.textColor = UIColor(hex: "41A340")
            }
            cell.name?.text = Global.nameArray[indexPath.row]
            cell.usdPrice?.text = "$" + Global.usdPriceArray[indexPath.row]
            
            let coinName = Global.nameArray[indexPath.row]
            let lowecasedCoinName = coinName.lowercased()
            let coinNameForIcon = (lowecasedCoinName as NSString).replacingOccurrences(of: " ", with: "-")
            let url = "https://files.coinmarketcap.com/static/img/coins/32x32/\(coinNameForIcon).png"
            self.downloadImage(url, inView: cell.cellImage)
        }
        
        cell.layer.cornerRadius = 5.0
        cell.backgroundColor = UIColor(hex: "eaeaf6")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Global.rank = Global.rankArray[indexPath.row]
        Global.name = Global.nameArray[indexPath.row]
        Global.symbol = Global.symbolArray[indexPath.row]
        Global.usdPrice = Global.usdPriceArray[indexPath.row]
        Global.btcPrice = Global.btcPriceArray[indexPath.row]
        Global.usd24hV = Global.usd24hVArray[indexPath.row]
        Global.usdMarketCap = Global.usdMarketCapArray[indexPath.row]
        Global.CP1h = Global.CP1hArray[indexPath.row]
        Global.CP24h = Global.CP24hArray[indexPath.row]
        Global.CP7d = Global.CP7dArray[indexPath.row]
        
        performSegue(withIdentifier: "details", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width - 16, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func StartIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func EndIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func downloadImage(_ uri : String, inView: UIImageView) {
        
        let url = URL(string: uri)
        
        let task = URLSession.shared.dataTask(with: url!) {responseData,response,error in
            if error == nil {
                if let data = responseData {
                    
                    DispatchQueue.main.async {
                        inView.image = UIImage(data: data)
                    }
                    
                } else {
                    let alert = UIAlertController(title: "Error", message:"No data", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                    self.present(alert, animated: true){}
                }
            } else {
                let alert = UIAlertController(title: "Error", message:"\(error!)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                self.present(alert, animated: true){}
            }
        }
        task.resume()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[Range(start ..< end)])
    }
}
