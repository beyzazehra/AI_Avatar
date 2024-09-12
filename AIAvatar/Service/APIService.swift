import UIKit
import AVKit

func makeAPIRequestForUUID(with prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
    let headers = [
        "x-rapidapi-key": "your-api-key",
        "x-rapidapi-host": "runwayml.p.rapidapi.com",
        "Content-Type": "application/json"
    ]
    
    let parameters: [String: Any] = [
        "text_prompt": prompt,
        "model": "gen3",
        "width": 380,
        "height": 200,
        "motion": false,
        "iterations": 1
    ]
    
    guard let url = URL(string: "https://runwayml.p.rapidapi.com/generate/text") else {
        completion(.failure(URLError(.badURL)))
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = headers
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
    } catch {
        completion(.failure(error))
        return
    }
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            let error = NSError(domain: NSURLErrorDomain, code: (response as? HTTPURLResponse)?.statusCode ?? -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
            completion(.failure(error))
            return
        }
        
        guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []), let responseDict = json as? [String: Any], let uuid = responseDict["uuid"] as? String else {
            completion(.failure(URLError(.cannotParseResponse)))
            return
        }
        
        checkTaskStatus(uuid: uuid) { result in
            completion(result)
        }
    }
    
    task.resume()
}

func checkTaskStatus(uuid: String, completion: @escaping (Result<String, Error>) -> Void) {
    let headers = [
        "x-rapidapi-key": "your-api-key",
        "x-rapidapi-host": "runwayml.p.rapidapi.com"
    ]
    
    guard let url = URL(string: "https://runwayml.p.rapidapi.com/status?uuid=\(uuid)") else {
        completion(.failure(URLError(.badURL)))
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            let error = NSError(domain: NSURLErrorDomain, code: (response as? HTTPURLResponse)?.statusCode ?? -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
            completion(.failure(error))
            return
        }
        
        guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []), let responseDict = json as? [String: Any], let status = responseDict["status"] as? String else {
            completion(.failure(URLError(.cannotParseResponse)))
            return
        }
        
        if status == "success" {
            if let imageUrl = responseDict["url"] as? String {
                completion(.success(imageUrl))
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { 
                checkTaskStatus(uuid: uuid, completion: completion)
            }
        }
    }
    
    task.resume()
}

func downloadVideo(from url: URL, completion: @escaping (Result<AVPlayerViewController, Error>) -> Void) {
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        DispatchQueue.main.async {
            let playerViewController = AVPlayerViewController()
            if let data = data {
                let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString + ".mp4")
                try? data.write(to: tempURL)
                let player = AVPlayer(url: tempURL)
                playerViewController.player = player
                completion(.success(playerViewController))
            } else {
                completion(.failure(NSError(domain: "VideoDataError", code: -1, userInfo: nil)))
            }
        }
    }
    task.resume()
}
