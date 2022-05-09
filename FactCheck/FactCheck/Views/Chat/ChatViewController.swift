//
//  ChatViewController.swift
//  FactCheck
//
//  Created by Med Aziz on 22/4/2022.
//

import UIKit
import MessageKit
import CloudKit

struct Sender : SenderType{
    var senderId: String
    var displayName: String
}

struct Message : MessageType{
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

class ChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate{
    
    //var
    var currentUser = Sender(senderId: "self", displayName: "FactCheck")
    var otherUser = Sender(senderId: "other", displayName: "Med Aziz")
    
    var messages = [MessageType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messages.append(Message(
            sender: otherUser,
            messageId: "1",
            sentDate: Date(),
            kind: .text("Hello! Your'e speaking with FactCheck Bot, how may i help?")))
        
        
        messages.append(Message(sender: currentUser, messageId: "2", sentDate: Date().addingTimeInterval(-86400), kind: .text("Hello!")))
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
        title: "Home",
        style: .done,
        target: self,
        action: nil
        )
    }
    
    func currentSender() -> SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
  
}
