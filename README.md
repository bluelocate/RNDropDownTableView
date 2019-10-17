# RNDropDownTableView

[![Platform](https://img.shields.io/cocoapods/p/RNPulseButton.svg?style=flat)](http://cocoapods.org/pods/RNPulseButton)
![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
[![License](https://img.shields.io/cocoapods/l/RNPulseButton.svg?style=flat)](http://cocoapods.org/pods/RNPulseButton)

Simple drop-down menu selection UI with TableView

## Demo

![Example gif](https://media.giphy.com/media/MZXNzYojwnqHVbjOEr/giphy.gif)


![Example gif](https://media.giphy.com/media/XgBNKOodoLWOKx48Ju/giphy.gif)
This component is using in 'ProtoPie Player' 

## Installation

Just download RNDropDownTableView.swift file and use it!

## At a Glance

### Create RNDropDownTableView

### Adjustable Property : 
``` swift
    @IBInspectable var cellBackgroundColor: UIColor = .white    //Cell background color
    @IBInspectable var cellHighlightedColor: UIColor = .white   //Cell color when highlighted
    @IBInspectable var duration: Double = 0.2                   //Duration of TableView opening/closing
    @IBInspectable var delay: Double = 0                        //Delay of TableView opening/closing
    
    var animationOptions: UIView.AnimationOptions = .init()     //Easing options of Tableview opening/closing
    var completion: ((Bool) -> Void)? = nil                     //Completion of Tableview opening/closing
    var dropDownArrowFrame: CGRect = .zero                      //It is for give specific position of row 0 to open drop down 
```
### Delegate Function: 
``` swift
    func typeDidSelected(_ tableView: RNDropDownTableView, _ indexPath: IndexPath)
```


## Author

Ryan Kwon, planon21@gmail.com

## License

RNDropDownTableView is available under the MIT license. See the LICENSE file for more info.
