//
//  Rx+SocketIOClient.swift
//  socket-io-rxSwift
//
//  Created by 조세상 on 27/07/2019.
//  Copyright © 2019 조세상. All rights reserved.
//
import RxSwift
import RxCocoa
import SocketIO


public extension Reactive where Base: SocketIOClient {

  var connect: Binder<Void> {
    return Binder(self.base) { client, _  in
      client.connect()
    }
  }

  func connect(timeoutAfter: Double) -> Observable<Void> {
    return Observable<Void>.create { observer -> Disposable in
      self.base.connect(timeoutAfter: timeoutAfter, withHandler: {
        observer.onNext(())
      })
      return Disposables.create()
    }
  }

  var didConnect: Binder<String> {
    return Binder(self.base) { client, namespace in

      client.didConnect(toNamespace: namespace)
    }
  }

  var didDisconnect: Binder<String> {
    return Binder(self.base) { client, reason in
      client.didDisconnect(reason: reason)
    }
  }

   var disconnect: Binder<Void> {
    return Binder(self.base) { client, _ in
      client.disconnect()
    }
  }

  @discardableResult
   func emit(_ event: String, _ items: SocketData...) -> Observable<Void> {
    return Observable<Void>.create { observer -> Disposable in
      self.base.emit(event, items) {
        observer.onNext(())
      }
      return Disposables.create()
    }
  }

  @discardableResult
   func emit(_ event: String, _ items: [Any]) -> Observable<Void> {
    return Observable<Void>.create { observer -> Disposable in
      self.base.emit(event, items) {
        observer.onNext(())
      }
      return Disposables.create()
    }
  }

   func emitWithAck(_ event: String, with items: [Any]) -> Observable<OnAckCallback> {
    return Observable<OnAckCallback>.create { observer -> Disposable in
      observer.onNext(self.base.emitWithAck(event, with: items))
      return Disposables.create()
    }
  }

   func emitWithAck(_ event: String, _ items: SocketData...) ->  Observable<OnAckCallback> {
    return Observable<OnAckCallback>.create { observer -> Disposable in
      observer.onNext(self.base.emitWithAck(event, items))
      return Disposables.create()
    }
  }

   var emitAck: Binder<(Int, [Any])> {
    return Binder(self.base) { client, datas  in
      let (ack, items) = datas
      client.emitAck(ack, with: items)
      
    }
  }

   var handleAck: Binder<(Int, [Any])> {
    return Binder(self.base) { client, datas  in
      let (ack, data) = datas
      client.handleAck(ack, data: data)
    }
  }

   var handleClientEvent: Binder<(SocketClientEvent, [Any])> {
    return Binder(self.base) { client, datas  in
      let (event, data) = datas
      client.handleClientEvent(event, data: data)
    }
  }

   var handleEvent: Binder<(String, [Any], Bool, Int)> {
    return Binder(self.base) { client, datas  in
      let (event, data, isInternalMessage, ack) = datas
      client.handleEvent(
        event,
        data: data,
        isInternalMessage: isInternalMessage,
        withAck: ack
      )
    }
  }

   var handlePacket: Binder<SocketPacket> {
    return Binder(self.base) { client, packet in
      client.handlePacket(packet)
    }
  }

   var leaveNameSpace: Binder<Void> {
    return Binder(self.base) { client, _ in
      client.leaveNamespace()
    }
  }


   var joinNamespace: Binder<Void> {
    return Binder(self.base) { client, _ in
      client.joinNamespace()
    }
  }

   var offClientEvent: Binder<SocketClientEvent> {
    return Binder(self.base) { client, event in
      client.off(clientEvent: event)
    }
  }

   var offEvent: Binder<String> {
    return Binder(self.base) { client, event in
      client.off(event)
    }
  }

   var offId: Binder<UUID> {
    return Binder(self.base) { client, id in
      client.off(id: id)
    }
  }

   func on(_ event: String) -> Observable<([Any], SocketAckEmitter)> {
    return Observable<([Any], SocketAckEmitter)>.create { observer -> Disposable in
      let id = self.base.on(event, callback: { data, emitter in
        observer.onNext((data, emitter))
      })
      return Disposables.create {
        self.base.off(id: id)
      }
    }
  }


  func on(clientEvent event: SocketClientEvent) -> Observable<([Any], SocketAckEmitter)> {
    return Observable<([Any], SocketAckEmitter)>.create { observer -> Disposable in
      let id = self.base.on(clientEvent: event, callback: { data, emitter in
        observer.onNext((data, emitter))
      })
      return Disposables.create {
        self.base.off(id: id)
      }
    }
  }

  func once(_ event: String) -> Observable<([Any], SocketAckEmitter)> {
    return Observable<([Any], SocketAckEmitter)>.create { observer -> Disposable in
      let id = self.base.once(event, callback: { data, emitter in
        observer.onNext((data, emitter))
      })
      return Disposables.create {
        self.base.off(id: id)
      }
    }
  }

  func once(clientEvent event: SocketClientEvent) -> Observable<([Any], SocketAckEmitter)> {
    return Observable<([Any], SocketAckEmitter)>.create { observer -> Disposable in
      let id = self.base.once(clientEvent: event, callback: { data, emitter in
        observer.onNext((data, emitter))
      })
      return Disposables.create {
        self.base.off(id: id)
      }
    }
  }

  func onAny() -> Observable<SocketAnyEvent> {
    return Observable<SocketAnyEvent>.create{ observer -> Disposable in
      self.base.onAny{ event in
        observer.onNext(event)
      }
      return Disposables.create()
    }
  }

  var removeAllHandler: Binder<Void> {
    return Binder(self.base) { client, _ in
      client.removeAllHandlers()
    }
  }

  var setReconnecting: Binder<String> {
    return Binder(self.base) { client, reason in
      client.setReconnecting(reason: reason)
    }
  }

}
