//
//  NewsViewModel.swift
//  NewsTestApp
//
//  Created by MacBook Pro on 02.08.22.
//

import Foundation
import XMLMapper

protocol NewsViewModelType: BaseViewModel {
    var updateTableView: Observable<Bool?> { get set }
    var showLoader: Observable<Bool?> { get }
    var uploadJsone: Bool { get set }
    var errorMessage: Observable<String?> { get }
    var message: Observable<String?> { get }
    func getTotalNews()
    func getNewsCount() -> Int
    func getNewsBy(_ indexPath: IndexPath) -> NewsModel
    func createJSONEFile()
    func createXMlFile()
}



final class NewsViewModel: NewsViewModelType {
    
    //MARK: - Dependencies -
    
    private let repo: NewsRepo
    
    
    
    //MARK: - Properties -
    
    let fileManager = FileManager()
    let tempDir = NSTemporaryDirectory()
    let fileName = "newsFile.txt"
    var uploadJsone = true
    let group = DispatchGroup()
    var newsData: Observable<[NewsModel]> = Observable([])
    var errorMessage: Observable<String?> = Observable(nil)
    var message: Observable<String?> = Observable(nil)
    var updateTableView: Observable<Bool?> = Observable(false)
    var showLoader: Observable<Bool?> = Observable(nil)
    
    
    
    //MARK: - Init -
    
    init(repo: NewsRepo) {
        self.repo = repo
    }
    
    
    
    //MARK: - Functions -
    
    func getNewsDate(completion: @escaping ([NewsModel]) -> Void) {
        self.repo.getNews(completionHandler: { [weak self] status, newsData, errorMessage  in
            self!.showLoader.value = true
            DispatchQueue.main.async {
                switch status {
                case .success:
                    completion(newsData!)
                case .failure:
                    self?.errorMessage.value = errorMessage
                    return
                }
            }
        })
    }
    
    func getBBCNewsDate(completion: @escaping ([NewsModel]) -> Void) {
        self.repo.getBBcNews(completionHandler: { [weak self] status, newsData, errorMessage  in
            self!.showLoader.value = true
            DispatchQueue.main.async {
                switch status {
                case .success:
                    
                    completion(newsData!)
                    
                case .failure:
                    self?.errorMessage.value = errorMessage
                    return
                }
            }
        })
    }
    
    func getTotalNews() {
        self.reachabilityService.isReachable { [weak self] in
            var dataNews: [NewsModel] = []
            self!.group.enter()
            self!.getNewsDate { data in
                dataNews += data
                print("get NewsApi news data")
                self!.group.leave()
            }
            
            self!.group.enter()
            self!.getBBCNewsDate { data in
                dataNews += data
                print("get BBC news data")
                self!.group.leave()
            }
            
            self!.group.notify(queue: .main) {
                self?.newsData.value = dataNews.sorted(by: {$0.getPublishDate() < $1.getPublishDate()})
                self?.updateTableView.value = true
                self?.showLoader.value = false
                print("All requests completed")
            }
        }
        self.reachabilityService.isUnreachable { [weak self] in
            self!.showLoader.value = false
            self!.readFile()
        }
        
    }
    
    func getNewsCount() -> Int {
        guard let newsData = newsData.value else { return 0 }
        return newsData.count
    }
    
    
    func getNewsBy(_ indexPath: IndexPath) -> NewsModel {
        self.newsData.value![indexPath.row]
    }
    
    func createJSONEFile() {
        self.deleteNewsFile()
        let encoder = JSONEncoder()
        var jsonString = ""
        do {
            let modelData = try encoder.encode(self.newsData.value)
            jsonString = String(data: modelData, encoding: .utf8)!
        } catch {
            print(error)
        }
        let path = (tempDir as NSString).appendingPathComponent(fileName)
        let contentsOfFile = jsonString
        do {
            try contentsOfFile.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
            self.message.value = "File text.txt created at temp directory"
            print("File text.txt created at temp directory")
        } catch let error as NSError {
            print("could't create file text.txt because of error: \(error)")
        }
    }
    
    func createXMlFile() {
        self.deleteNewsFile()
        let xmlString = self.newsData.value!.toXMLString()
        let path = (tempDir as NSString).appendingPathComponent(fileName)
        let contentsOfFile = xmlString
        do {
            try contentsOfFile!.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
            self.message.value = "File text.txt created at temp directory"
            print("File text.txt created at temp directory")
        } catch let error as NSError {
            print("could't create file text.txt because of error: \(error)")
        }
    }
    
    func readFile() {
        let directoryWithFiles = checkDirectory() ?? "Empty"
        let path = (tempDir as NSString).appendingPathComponent(directoryWithFiles)
        do {
            let contentsOfFile = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue) as String
            if uploadJsone {
                if let dataFromJsonString = contentsOfFile.data(using: .utf8) {
                    let newsFromData = try JSONDecoder().decode([NewsModel].self,from: dataFromJsonString)
                    self.newsData.value = newsFromData
                }
            } else {
                print(contentsOfFile)
                let data = Data(contentsOfFile.utf8) // Data for deserialization (from XML to object)
                do {
                    let xml = try XMLSerialization.xmlObject(with: data, options: [.default, .cdataAsString])
                    self.newsData.value = XMLMapper<Channel>().map(XMLString: contentsOfFile)?.item
                } catch {
                    print(error)
                }
            }
        } catch let error as NSError {
            self.errorMessage.value = ""
            print("there is an file reading error: \(error)")
        }
    }
    
    func deleteNewsFile() {
        let directoryWithFiles = checkDirectory() ?? "Empty"
        do {
            let path = (tempDir as NSString).appendingPathComponent(directoryWithFiles)
            try fileManager.removeItem(atPath: path)
            print("file deleted")
        } catch let error as NSError {
            print("error occured while deleting file: \(error.localizedDescription)")
        }
    }
    
    func checkDirectory() -> String? {
        do {
            let filesInDirectory = try fileManager.contentsOfDirectory(atPath: tempDir)
            let files = filesInDirectory
            if files.count > 0 {
                if files.first == fileName {
                    print("newsFile.txt found")
                    return files.first
                } else {
                    print("File not found")
                    return nil
                }
            }
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
}
