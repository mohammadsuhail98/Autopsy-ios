//
//  FileExtensions.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 30/8/24.
//

import Foundation

struct FileExtensions {
    static let imageExtensions: [String] = [
        ".jpg", ".jpeg", ".png", ".psd", ".nef", ".tiff", ".bmp", ".tec", ".tif", ".webp"
    ]
    
    static let videoExtensions: [String] = [
        ".aaf", ".3gp", ".asf", ".avi", ".m1v", ".m2v", ".m4v", ".mp4", ".mov", ".mpeg", ".mpg",
        ".mpe", ".rm", ".wmv", ".mpv", ".flv", ".swf"
    ]
    
    static let audioExtensions: [String] = [
        ".aiff", ".aif", ".flac", ".wav", ".m4a", ".ape", ".wma", ".mp2", ".mp1", ".mp3", ".aac",
        ".m4p", ".m1a", ".m2a", ".m4r", ".mpa", ".m3u", ".mid", ".midi", ".ogg"
    ]
    
    static let documentExtensions: [String] = [
        ".doc", ".docx", ".odt", ".xls", ".xlsx", ".ppt", ".pptx"
    ]
    
    static let executableExtensions: [String] = [
        ".exe", ".msi", ".cmd", ".com", ".bat", ".reg", ".scr", ".dll", ".ini"
    ]
    
    static let textExtensions: [String] = [
        ".txt", ".rtf", ".log", ".text", ".xml"
    ]
    
    static let webExtensions: [String] = [
        ".html", ".htm", ".css", ".js", ".php", ".aspx"
    ]
    
    static let pdfExtensions: [String] = [
        ".pdf"
    ]
    
    static let archiveExtensions: [String] = [
        ".zip", ".rar", ".7zip", ".7z", ".arj", ".tar", ".gzip", ".bzip", ".bzip2", ".cab",
        ".jar", ".cpio", ".ar", ".gz", ".tgz", ".bz2"
    ]
    
    static let databaseExtensions: [String] = [
        ".db", ".db3", ".sqlite", ".sqlite3"
    ]
}
