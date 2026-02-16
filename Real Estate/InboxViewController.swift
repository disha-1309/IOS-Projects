//
//  InboxViewController.swift
//  Real Estate
//
//  Created by Droisys on 06/10/25.
//

import UIKit

class InboxViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        queueTesting()
//        notifyDispatchGroup()
        synWaitingGroup()
        
        // Do any additional setup after loading the view.
    }
    
    
    // Thread  / Task
    //Serial + Sync - Order
    //Serial + Async - Order
    //Concurrent + Sync - Order
    //Concurrent + Async - Unorder
    
    func queueTesting(/*:-)*/){
        let myQueue = DispatchQueue(label: "Disha.serial.queue",attributes: .concurrent)
        
        //one thread
        myQueue.async {
            print("Task 1 started")
            for index in 1...5 {
                print("\(index) [Task 1] times  5 is \(index * 5)")
            }
            print("Task 1 is completed")
        }
        
        //second thread
        myQueue.async {
            print("Task 2 started")
            for index in 1...30 {
                print("\(index) [Task 2] times  3 is \(index * 5)")
            }
            print("Task 2 is completed")
        }
        
    }
    
    func notifyDispatchGroup(){
        //show loader
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "com.company.app")
        let someQueue = DispatchQueue(label: "com.company.app1")
        queue.async/*(group: group)*/ {
            group.enter()
            for _ in 0...25{
                print("Queue:- Task 1 is running")
            }
            group.leave()
        }
        queue.async/*(group: group)*/{
            group.enter()
            for _ in 0...15{
                print("Queue:-Task 2 is running")
            }
            group.leave()
        }
        someQueue.async/*(group: group)*/ {
            group.enter()
            for _ in 0...5{
                print("SomeQueu:- Task 1 is running")
            }
            group.leave()
        }
        group.notify(queue:DispatchQueue.main){
            //hide loader
            print("All jobs have completed")
        }
    }
    
    func synWaitingGroup(){
        let group = DispatchGroup()
        let queue = DispatchQueue.global(qos:.userInitiated)
        
        queue.async(group: group) {
            print("Job 1 start")
            Thread.sleep(until: Date().addingTimeInterval(10))
            print("End job 1")
        }
        
        queue.async(group: group) {
            print("Job 2 start")
            Thread.sleep(until: Date().addingTimeInterval(70))
            print("End job 2")
        }
        if group.wait(timeout: .now() + 15 ) == .timedOut {
            print("Got tired")
        }
        else {
            print("All jobs completed")
        }
    }
}
