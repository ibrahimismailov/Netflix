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
    static let baseURLTV = "https://imdb-api.com/en/API/Title/k_az1ipaoz/tt1375666"
    static let basePopularMovies = "https://imdb-api.com/en/API/SearchSeries/k_az1ipaoz/The Leftovers 2014"
    static let baseUpComing = "https://imdb-api.com/en/API/SearchMovie/k_az1ipaoz/inception 2010"
    static let youtubeAPi_Key = "AIzaSyABX2JcaBCxiuxbsFWbHYay4uQ3r6vTrT0"
    
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
        guard let url = URL(string: "https://imdb-api.com/API/SearchSeries/k_az1ipaoz/selena") else {return}
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
        guard let url = URL(string: "https://imdb-api.com/API/SearchEpisode/k_az1ipaoz/moon") else {return}
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
    func getComingMovies(complition:@escaping(Result<[Title],Error>) ->Void ){
        guard let url = URL(string: "https://imdb-api.com/API/SearchEpisode/k_az1ipaoz/love") else {return}
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
    func getSearchMovies (complition:@escaping(Result<[Title],Error>) ->Void ) {
        guard let url = URL(string: "https://imdb-api.com/en/API/Search/k_az1ipaoz/love") else {return}
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
    func search (with query: String, complition:@escaping(Result<[Title],Error>) ->Void ) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "https://imdb-api.com/en/API/Search/k_az1ipaoz/\(query)") else {return}
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
    func getMovies(with query: String, complition:@escaping(Result<VideoElements,Error>) ->Void ) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "https://youtube.googleapis.com/youtube/v3/search?q=\(query)&key=\(Constants.youtubeAPi_Key)") else
        { return}
        let task =  URLSession.shared.dataTask(with: url) { (data,response,error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error",error)
                   
                    return
                }
                guard let data = data else {return}
                do {
                    let result = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                    complition(.success(result.items[0]))
                    print(result)
                  
                 
                }catch let error {
                    complition(.failure(error))
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
