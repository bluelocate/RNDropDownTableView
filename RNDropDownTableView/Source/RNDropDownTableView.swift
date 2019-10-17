import UIKit

protocol DropDownMenuDelegate: class {
    func typeDidSelected(_ tableView: RNDropDownTableView, _ indexPath: IndexPath)
}

class RNDropDownTableView: UITableView {
    @IBInspectable var cellBackgroundColor: UIColor = .white
    @IBInspectable var cellHighlightedColor: UIColor = .white
    @IBInspectable var duration: Double = 0.2
    @IBInspectable var delay: Double = 0
    
    var animationOptions: UIView.AnimationOptions = .init()
    var completion: ((Bool) -> Void)? = nil
    var dropDownArrowFrame: CGRect = .zero
    
    private var currentFocusedIndexPath: IndexPath?
    
    weak var dropDownMenuDelegate: DropDownMenuDelegate?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        allowsSelection = false
        isScrollEnabled = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        let touchPosition = touch.location(in: self)
        if let cellIndexPath = self.indexPathForRow(at: touchPosition) {
            currentFocusedIndexPath = cellIndexPath
            
            if cellIndexPath.row == 0 { //You can add another condition too (Ex If position is some point of row 0)
                if dropDownArrowFrame.contains(touchPosition) {
                    openDropDownMenu()
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let touch = touches.first else { return }
        let touchPosition = touch.location(in: self)
        
        if let cellIndexPath = indexPathForRow(at: touchPosition), let cell = cellForRow(at: cellIndexPath) {
            currentFocusedIndexPath = cellIndexPath
            
            //If you want to also highlight first row. Remove this condition
            if cellIndexPath.row == 0, cell.frame.contains(touchPosition) {
                currentFocusedIndexPath = nil
            } else {
                cell.backgroundColor = cellHighlightedColor
            }
        } else {
            currentFocusedIndexPath = nil
        }
        
        if bounds.contains(touchPosition) {
            //When inside of tableview bounds
            visibleCells.forEach { cell in
                if let currentFocusedIndex = currentFocusedIndexPath, cell != cellForRow(at: currentFocusedIndex) {
                    cell.backgroundColor = cellBackgroundColor
                }
            }
        } else {
            //When drag out side of tableview bound
            currentFocusedIndexPath = nil
            visibleCells.forEach { cell in
                cell.backgroundColor = cellBackgroundColor
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        visibleCells.forEach { $0.backgroundColor = cellBackgroundColor }
        currentFocusedIndexPath = nil
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        visibleCells.forEach { $0.backgroundColor = cellBackgroundColor }
        
        //You can also control which indexPath will trigger event EX) currentFocusedIndex.row != 0
        if let currentFocusedIndex = currentFocusedIndexPath {
            dropDownMenuDelegate?.typeDidSelected(self, currentFocusedIndex)
        }
        currentFocusedIndexPath = nil
        closeDropDownMenu()
    }
    
    private func openDropDownMenu() {
        UIView.animate(withDuration: duration, delay: delay, options: animationOptions, animations: {
            self.frame.size.height = CGFloat(self.numberOfRows(inSection: 0)) * self.rowHeight
        }, completion: completion)
    }
        
    private func closeDropDownMenu() {
        UIView.animate(withDuration: duration, delay: delay, options: animationOptions, animations: {
            self.frame.size.height = self.rowHeight
        }, completion: completion)
    }
}
