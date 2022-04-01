//
//  APICaller.swift
//  Netflix
//
//  Created by Abraam on 28.03.2022.
//

import Foundation
struct Constants {
    static let API_KEY = "k_az1ipaoz"
    static let baseURL = "https://imdb-api.com/API/Search/k_az1ipaoz/star"
    static let baseURLTV = "https://imdb-api.com/en/API/SearchSeries/k_az1ipaoz/lost"
    static let basePopularMovies = "https://imdb-api.com/en/API/InTheaters/k_az1ipaoz"
    static let baseUpComing = "https://imdb-api.com/en/API/SearchMovie/k_az1ipaoz/inception 2010"
    
}
enum ApiError: Error {
    case failedTogedData
}
class APICaller {
    static let shared = APICaller()
    func getTradingMovies(complition:@escaping(Result<[Title],Error>) ->Void ){
        guard let url = URL(string: "\(Constants.baseURL)") else {return}
    URLSession.shared.dataTask(with: url) { (data,response,error) in
        DispatchQueue.main.async {
            if let error = error {
                print("Error",error)
                complition(.failure(ApiError.failedTogedData))
                return
            }
            guard let data = data else {return}
            do {
                let result = try JSONDecoder().decode(TitleResponse.self, from: data)
              
                complition(.success(result.results))
                
            }catch  {
                complition(.failure(ApiError.failedTogedData))
            }
        }
    }.resume()
}
    
    func getTradingTv(complition:@escaping(Result<[Title],Error>) ->Void ){
        guard let url = URL(string: "\(Constants.baseURLTV)") else {return}
        URLSession.shared.dataTask(with: url) { (data,response,error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error",error)
                    complition(.failure(ApiError.failedTogedData))
                    return
                }
                guard let data = data else {return}
                do {
                    let result = try JSONDecoder().decode(TitleResponse.self, from: data)
                    complition(.success(result.results))
                 
                }catch  {
                    complition(.failure(ApiError.failedTogedData))
                }
            }
        }.resume()
    }
    
    func getPopular(complition:@escaping(Result<[Title],Error>) ->Void ){
        guard let url = URL(string: "\(Constants.basePopularMovies)") else {return}
        URLSession.shared.dataTask(with: url) { (data,response,error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error",error)
                    complition(.failure(ApiError.failedTogedData))
                    return
                }
                guard let data = data else {return}
                do {
                    let result = try JSONDecoder().decode(TitleResponse.self, from: data)
                    complition(.success(result.results))
                 
                }catch  {
                    complition(.failure(ApiError.failedTogedData))
                }
            }
        }.resume()
    }
    func getComing(complition:@escaping(Result<[Title],Error>) ->Void ){
        guard let url = URL(string: "\(Constants.baseUpComing)") else {return}
        URLSession.shared.dataTask(with: url) { (data,response,error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error")
                   
                    complition(.failure(error))
                    return
                }
                guard let data = data else {return}
                do {
                    let result = try JSONDecoder().decode(TitleResponse.self, from: data)
                    complition(.success(result.results))
                 
                }catch {
                    complition(.failure(ApiError.failedTogedData))
                }
            }
        }.resume()

    }

}
