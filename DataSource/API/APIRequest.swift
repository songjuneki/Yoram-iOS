//
//  APIRequest.swift
//  Yoram
//
//  Created by 송준기 on 2022/11/12.
//

import Foundation
import Alamofire
import Combine

struct DataResponse<T:Codable>:Codable {
    let data: [T]
}

class APIRequest {
    
    static func request<T: Codable>(type: T.Type, urlRequset: URLRequestConvertible) -> Future<DataResponse<T>, AFError> {
        return Future<DataResponse<T>,AFError> { promise in
            AF.request(urlRequset)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: DataResponse<T>.self) { response in
                    switch response.result {
                    case .failure(let error):
                        promise(.failure(error))
                    case .success(let data):
                        promise(.success(data))
                    }
                }
        }
    }
}

extension AnyPublisher {
    func async() async throws -> Output {
        try await withCheckedThrowingContinuation({ continuation in
            var cancellable: AnyCancellable?
            
            cancellable = first()
                .sink(receiveCompletion: { result in
                    switch result {
                    case .finished: break
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                    cancellable?.cancel()
                }, receiveValue: { value in
                    continuation.resume(with: .success(value))
                })
        })
    }
}
