import Foundation
import Combine

extension CoffStore {

    func getSelectedInterestGroup() -> AnyPublisher<InterestGroup?, Error> {
        let subject = PassthroughSubject<InterestGroup?, Error>()

        loadSelectedInterestGroup {
            do {
                let interestGroup = try $0.get()
                subject.send(interestGroup)
                subject.send(completion: .finished)
            } catch {
                subject.send(completion: .failure(error))
            }
        }

        return subject.eraseToAnyPublisher()
    }

    func setSelectedInterestGroup(_ interestGroup: InterestGroup) -> AnyPublisher<Never, Error> {
        let subject = PassthroughSubject<Never, Error>()

        storeSelectedInterestGroup(interestGroup) {
            if let error = $0 {
                subject.send(completion: .failure(error))
            } else {
                subject.send(completion: .finished)
            }
        }

        return subject.eraseToAnyPublisher()
    }

    func getEvents(completionHandler: @escaping (Result<Events, Error>) -> Void) -> AnyPublisher<Events, Error> {
        let subject = PassthroughSubject<Events, Error>()

        loadEvents {
            do {
                let events = try $0.get()
                subject.send(events)
                subject.send(completion: .finished)
            } catch {
                subject.send(completion: .failure(error))
            }
        }

        return subject.eraseToAnyPublisher()
    }

    func setEvents(_ events: Events) -> AnyPublisher<Never, Error> {
        let subject = PassthroughSubject<Never, Error>()

        storeEvents(events) {
            if let error = $0 {
                subject.send(completion: .failure(error))
            } else {
                subject.send(completion: .finished)
            }
        }

        return subject.eraseToAnyPublisher()
    }

}
