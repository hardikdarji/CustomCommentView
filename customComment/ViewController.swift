//
//  ViewController.swift
//  customComment
//
//  Created by hardik.darji on 3/17/18.
//  THIS IS VIEW CONTROLLER FOR DEMOSTRATION...
// test commit changes
import UIKit
class CommentCell: UITableViewCell {
    @IBOutlet weak var buttonAddComment: UIButton!
    @IBOutlet weak var labelCommentText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

extension ViewController: handleCommentHeightDelegate{
    
    func commentSendCompletionHandler(isSuccess: Bool, indexPath: IndexPath?, commentText: String?) {
        if isSuccess
        {
            print("Success: ...)")
            // ADD COMMENT TO ARRAY...
            self.arrComment[(indexPath?.row)!].commentCount += 1
        }
        // DESELEC AND RELOAD ROW
        self.tableViewComment?.deselectRow(at: indexPath!, animated: true)
        self.tableViewComment?.reloadRows(at: [indexPath!], with: .automatic)
        self.view.layoutIfNeeded()
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            
            self.arrComment.remove(at: indexPath.row)
            self.tableViewComment.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrComment.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        let modelObject = self.arrComment[indexPath.row]
        cell.labelCommentText?.text = modelObject.commentText
        cell.buttonAddComment.addTarget(self, action: #selector(buttonCommentsTouched(sender:)), for: .touchUpInside)
        cell.buttonAddComment.setTitle("Add Comment(\(modelObject.commentCount))", for: .normal)
        cell.selectionStyle = .blue
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableViewComment.deselectRow(at: indexPath, animated: true)
        self.view.endEditing(true)
    }
}

class ViewController: UIViewController {
    var viewCommentView: CommentView = CommentView()
    var arrComment = Model.getInitData()
    
    @IBOutlet internal var tableViewComment: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.viewCommentView)
        self.viewCommentView.initCommentSetup(parentView: self.view)
        self.viewCommentView.delegate = self

    }
    @objc func buttonCommentsTouched(sender:UIButton)
    {
        self.viewCommentView.startCommentView(tableView: self.tableViewComment!, sender: sender)
    }
}

