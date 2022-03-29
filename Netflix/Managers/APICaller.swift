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
    static let basePopularMovies = "https://imdb-api.com/en/API/MostPopularTVs/k_az1ipaoz"
    static let baseUpComing = "https://imdb-api.com/en/API/ComingSoon/k_az1ipaoz"
    
}
enum ApiError: Error {
    case failedTogedData
}
class APICaller {
    static let shared = APICaller()
    func getTradingMovies(urlString:String,complition:@escaping(Result<SearchResponse,Error>) ->Void ){
        guard let url = URL(string: urlString) else {return}
    URLSession.shared.dataTask(with: url) { (data,response,error) in
        DispatchQueue.main.async {
            if let error = error {
                print("Error",error)
                complition(.failure(ApiError.failedTogedData))
                return
            }
            guard let data = data else {return}
            do {
                let movies = try JSONDecoder().decode(SearchResponse.self, from: data)
                complition(.success(movies))
                print(movies.results[0].title)
                
            }catch  {
                complition(.failure(ApiError.failedTogedData))
            }
        }
    }.resume()
}
    
    func getTradingTv(urlString:String,complition:@escaping(Result<[Tv],Error>) ->Void ){
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
                    let movies = try JSONDecoder().decode(MoviesTv.self, from: data)
                    complition(.success(movies.results))
                    print(movies.results[0].id)
                    print(movies)
                }catch  {
                    complition(.failure(ApiError.failedTogedData))
                }
            }
        }.resume()
    }
    
    func getPopular(urlString:String,complition:@escaping(Result<[ComeMovie],Error>) ->Void ){
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
                    let movies = try JSONDecoder().decode(Coming.self, from: data)
                    complition(.success(movies.items))
                    print(movies.items[0].title)
                    print("oldu")
                   
                }catch {
                    complition(.failure(ApiError.failedTogedData))
                }
                
            }
        }.resume()

    }
    func getComing(urlString:String,complition:@escaping(Result<[Pop],Error>) ->Void ){
        guard let url = URL(string: "\(Constants.basePopularMovies)") else {return}
        URLSession.shared.dataTask(with: url) { (data,response,error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error")
                   
                    complition(.failure(error))
                    return
                }
                guard let data = data else {return}
                do {
                    let movies = try JSONDecoder().decode(MoviesPop.self, from: data)
                    complition(.success(movies.items))
                    print(movies.items[0].title)
                    print("oldu")
                }catch {
                    complition(.failure(ApiError.failedTogedData))
                }
            }
        }.resume()

    }

}
