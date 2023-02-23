//
//  APIManager.swift
//  SchoolAPI
//
//  Created by Adel Al-Aali on 2/11/23.
//

import Foundation
import Combine


//enum Endpoint: String {
//    case schools
//    case details
//}


class APIManager {
    
    static let shared = APIManager()
    private var schoolDataCancellable = Set<AnyCancellable>()
    private var gradesCancellable = Set<AnyCancellable>()
    
    @Published var allSchools : [Schools] = []
    @Published var allGrades : [Grades] = []
    
    
    private var schoolsURL = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
    private var gradesURL = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
    
    @Published var data : [Schools] = []
    
    init() {
        fetchSchoolData()
        fetchGrades()
    }
    
    // This is a simple function to get data using Combine
    func fetchSchoolData() {
        print("running  school data grab")
        
        print("[simple] starting url parse on \(schoolsURL)")
        guard let url = URL(string: schoolsURL) else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) in
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300
                else {
                    throw URLError(.badServerResponse)
                }
                print("[simple] found data \(data.description)")
                return data
            }
        
        
            .decode(type: [Schools].self, decoder: JSONDecoder())
        
        
            .sink { (completion) in
                switch completion {
                case .finished:
                    print("[+] Simple API Completion \(completion)")
                    break
                case .failure (let error):
                    print("[-] Error in school data fetching")
                }
                
            } receiveValue: { [weak self] (data) in
                self?.allSchools = data
                print(data.first)
            }
            .store(in: &schoolDataCancellable)
    }
    
    
    func fetchGrades() {
        print("running school grade data grab")
        
        print("[simple] starting url parse on \(gradesURL)")
        guard let url = URL(string: gradesURL) else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
        
            .tryMap { (data, response) in
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300
                else {
                    throw URLError(.badServerResponse)
                }
                print("[simple] found data \(data.description)")
                return data
            }
        
        
            .decode(type: [Grades].self, decoder: JSONDecoder())
            .sink { (completion) in
                
                switch completion {
                case .finished:
                    print("[+] Simple API Completion \(completion)")
                    break
                case .failure (let error):
                    print("[-] Error in school data fetching")
                }
            
            } receiveValue: { [weak self] (data) in
                self?.allGrades = data
                print(data.first)
            }
            .store(in: &gradesCancellable)
    }
    
    
    
    
    // NOTE: getData func takes in global paramaters, and produces pass / fail using enums error handling
    /// This can be used to parse any object type
    func getData<T: Decodable>(endpoint: Endpoint, id: Int? = nil, type: T.Type) -> Future<[T], Error> {
        print("starting url parse on \(schoolsURL)")
        return Future<[T], Error> { [weak self] promise in
            // MARK: To ensure URL string is proper, returns invalide promise if not possible
            guard let self = self, let url = URL(string: self.schoolsURL.appending(endpoint.rawValue).appending(id == nil ? "" : "/\(id ?? 0)")) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            print("URL is \(url.absoluteString)")
            
            // MARK: Get using URLSessions and Combines extension dataTaskPublisher--> returns a publisher
            /// creates data and response object, receives data on mainloop using JSONDecoder
            /// .sink creates the subcriber for success / failure as promise conditions
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.responseError
                    }
                    return data
                }
                .decode(type: [T].self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                }, receiveValue: { promise(.success($0)) })
                .store(in: &self.schoolDataCancellable)
        }
    }
}



enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknown
}

extension NetworkError : LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("[-] Invalid URL", comment: "[-] Invalid URL")
        case .responseError:
            return NSLocalizedString("[-] Unexpected status code", comment: "[-] Invalid response")
        case .unknown:
            return NSLocalizedString("[-] Unknown error", comment: "[-] Unknown error")
        }
    }
}


