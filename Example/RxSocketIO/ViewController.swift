//
//  ViewController.swift
//  RxSocketIO
//
//  Created by sesang06 on 07/28/2019.
//  Copyright (c) 2019 sesang06. All rights reserved.
//

import UIKit
import SocketIO
import RxSocketIO
import RxSwift
import RxCocoa

class ViewController: UIViewController {


  let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    let manager = SocketManager(socketURL: URL(string: "http://localhost:8080")!, config: [.log(true), .compress])
    let socket = manager.defaultSocket

    Observable.just(SocketClientEvent.connect)
      .flatMap { socket.rx.on(clientEvent: $0)
      }
      .subscribe(onNext: { data, ack in
        print("socket connected")
      })
      .disposed(by: self.disposeBag)


    Observable.just("currentAmount")
      .flatMap { socket.rx.on($0)
      }
      .flatMap { data, ack -> Observable<Double> in
        guard let cur = data[0] as? Double else { return .empty() }
        return Observable.zip(
          Observable.just(cur),
          socket.rx.emitWithAck("canUpdate", cur)
          )
          .map { $0.0 }
      }
      .flatMap { cur-> Observable<Void> in
        return socket.rx.emit("update", ["amount": cur + 2.50])
      }
      .subscribe()
      .disposed(by: self.disposeBag)

    Observable.just(())
      .bind(to: socket.rx.connect)
      .disposed(by: self.disposeBag)


  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

