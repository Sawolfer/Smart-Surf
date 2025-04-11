//
//  SummirizeInfo.swift
//  Smart Surf
//
//  Created by Савва Пономарев on 17.02.2025.
//
import Foundation

class TextSummarizer{
    func summarizeText(text: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8000/summarize/") else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ["text": text]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let summary = json["summary"] as? String {
                completion(summary)
            } else {
                completion(nil)
            }
        }

        task.resume()
    }
}
