//  CommentView.swift
//  Created by hardik.darji on 3/17/18.

import UIKit

// MARK: CONSTANTS.....
let maxCharForComment: Int = 300
let minCommentViewHeight: CGFloat = 93
let minTextViewHeight: CGFloat = 36
let maxTextViewHeight: CGFloat = 105

// MARK: SEND COMMENT PROTOCOL DECLARATION....
protocol handleCommentHeightDelegate: class
{
    func commentSendCompletionHandler(isSuccess: Bool, indexPath: IndexPath?, commentText: String?)
}

// MARK: CUSTOM COMMENT VIEW CLASS.....
class CommentView: UIView, UITextViewDelegate {
    @IBOutlet internal var contentView: UIView! // CONTENT VIEW CONTAINER
    @IBOutlet var textViewComment: UITextView!  // COMMENT TEXTVIEW
    @IBOutlet var labelCharCount: UILabel!      // CHAR COUNTER FOR SHOW LIMIT
    @IBOutlet var buttonSend: UIButton!
    @IBOutlet var buttonCancel: UIButton!
    
    weak var delegate:handleCommentHeightDelegate?  // DELEGATE VAR FOR RETURN IN PARENT VC
    
    var bottomSpace:NSLayoutConstraint!         // BOTTOM CONSTRAIN FOR HANDLE WHEN KEYBOARD APPEARED
    var heightConstraint:NSLayoutConstraint!    // TO MANAGE HEIGHT DYNAMICALLY WHEN TYPE IN TEXTVIEW
    
    // MANAGE KEYBOARD CONSTARAIN AND HEIGHT VAR
    var addCommentViewHeight: CGFloat = minCommentViewHeight   //   INITIAL HEIGHT OF COMMENT BOX
    var keyboardHeight: CGFloat = 0.0
    
    var indexPathAddComment:IndexPath?          // IndexPath of Tableview for select/deselect and scroll up to selected row
    var currentTableView: UITableView?
    
    // MARK: COMMENT VIEW INIT METHODS
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    // MARK: COMMENT VIEW BUTTONS METHODS
    @IBAction func buttonClearTextTouched(_ sender: Any) {
        self.resetTextComment()
    }
    @IBAction func buttonCancelTouched(sender: UIButton)
    {
        self.addCommentFinished(isSuccess: false)
    }
    @IBAction func buttonSendTouched(sender: UIButton)
    {
        if textViewComment.text == ""
        {
            return
        }
       self.addCommentFinished(isSuccess: true)
    }

    // MARK: COMMENT VIEW PRIVATE METHODS
    private func addCommentFinished(isSuccess: Bool)
    {
        self.endEditing(true)
        if self.delegate?.commentSendCompletionHandler != nil
        {
            self.delegate?.commentSendCompletionHandler(isSuccess: isSuccess,
                                                        indexPath: self.indexPathAddComment, commentText: self.textViewComment.text)
        }
        self.indexPathAddComment = nil
        self.resetTextComment()
        self.removeKeyboardObserver()
    }
    private func commonInit()
    {
        Bundle.main.loadNibNamed("CommentView", owner: self, options: nil)
        self.addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.textViewComment.delegate = self
        self.setCountChar(charCount: 0)
        
    }
    private func removeKeyboardObserver()
    {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow , object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide , object: nil)
    }
    private func addKeyboardObserver()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    // MARK: COMMENT VIEW METHODS,
    // initCommentSetup NEED TO CALL ONE TIME FROM PARENT VIEW CONTROLLER
    func initCommentSetup(parentView: UIView)
    {
        let leadingSpace = NSLayoutConstraint(item: self,
                                              attribute: NSLayoutAttribute.leading,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: parentView,
                                              attribute: NSLayoutAttribute.leading,
                                              multiplier: 1, constant: 0)
        
        let trailingSpace = NSLayoutConstraint(item: self,
                                               attribute: NSLayoutAttribute.trailing,
                                               relatedBy: NSLayoutRelation.equal,
                                               toItem: parentView,
                                               attribute: NSLayoutAttribute.trailing,
                                               multiplier: 1, constant: 0)
        
        
        bottomSpace = NSLayoutConstraint(item: self,
                                         attribute: NSLayoutAttribute.bottom,
                                         relatedBy: NSLayoutRelation.equal,
                                         toItem: parentView,
                                         attribute: NSLayoutAttribute.bottom,
                                         multiplier: 1, constant: minCommentViewHeight)
        
        heightConstraint = NSLayoutConstraint(item: self,
                                              attribute: NSLayoutAttribute.height,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: nil,
                                              attribute: NSLayoutAttribute.notAnAttribute,
                                              multiplier: 1,
                                              constant: minCommentViewHeight)
        NSLayoutConstraint.activate([leadingSpace, trailingSpace, bottomSpace, heightConstraint])
        self.layoutIfNeeded()
    }

    // startCommentView NEED TO CALL WHEN COMMENT BUTTON TOUCHED OF UITableViewCell
    func startCommentView(tableView: UITableView, sender: UIButton?)
    {
        if self.bottomSpace.constant < 0
        {
            return
        }
        
        self.addKeyboardObserver()
        self.currentTableView = tableView
        
        if sender != nil
        {
            self.indexPathAddComment =  tableView.indexPathForView(view: sender!)!
            self.currentTableView?.selectRow(at: self.indexPathAddComment!, animated: true, scrollPosition: .none)
        }
        self.textViewComment?.becomeFirstResponder()
    }
    
    //MARK: KEYBOARD NOTIFICATION METHODS...
    @objc
    func keyboardWillAppear(notification: NSNotification?) {
        
        guard let keyboardFrame = notification?.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardHeight: CGFloat
        keyboardHeight = keyboardFrame.cgRectValue.height

        if self.indexPathAddComment != nil // WILL BE NEEL FOR COMMENT VC
        {
            if let tableView = self.currentTableView
            {
                let rectOfCellInTableView = tableView.rectForRow(at: self.indexPathAddComment!)
                let offset = rectOfCellInTableView.origin.y - (tableView.frame.height - (keyboardHeight + minCommentViewHeight + rectOfCellInTableView.size.height))
                if offset > 0
                {
                    tableView.contentOffset.y = offset
                }
            }
            
        }
        
        self.buttonCancel.isHidden = false
        self.heightConstraint.constant = minCommentViewHeight
        self.bottomSpace.constant = keyboardHeight * -1
        self.layoutIfNeeded()
    }
    
    @objc
    func keyboardWillDisappear(notification: NSNotification?) {
        self.buttonCancel.isHidden = true
        self.bottomSpace.constant = minCommentViewHeight
        UIView.animate(withDuration: 0.33, animations: {
            self.layoutIfNeeded()
        })
    }
    
    // MARK: TEXTVIEW DELEGATE METHODS..
    //textViewDidChange FOR MANAGE TEXTVIEW HEIGHT CHANGES
    func textViewDidChange(_ textView: UITextView) {
        
        var height = ceil(textView.contentSize.height) // ceil to avoid decimal
        
        if (height < minTextViewHeight) { // min cap, + 5 to avoid tiny height difference at min height
            height = minTextViewHeight
        }
        if (height > maxTextViewHeight) { // max cap
            height = maxTextViewHeight
        }
        
        if height != addCommentViewHeight { // set when height changed
            addCommentViewHeight = height + 57 // change the value of NSLayoutConstraint
            self.heightConstraint.constant = addCommentViewHeight
        }
    }
    
    //LIMITATION OF CHAR ...E.G. MAX = 300 HERE
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        self.setCountChar(charCount: newText.count)
        return newText.count < maxCharForComment
    }
    
    func setCountChar(charCount: Int)
    {
        self.labelCharCount.text = "\(charCount)/\(maxCharForComment)"
    }
    func resetTextComment()
    {
        self.textViewComment?.text = ""
        self.setCountChar(charCount: 0)
        self.heightConstraint.constant = minCommentViewHeight
    }
    
}

