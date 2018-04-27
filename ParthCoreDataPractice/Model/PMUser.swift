//
//  PMUser.swift
//
//  Created by ravi on 27/04/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class PMUser: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let name = "name"
    static let email = "email"
    static let id = "id"
    static let website = "website"
    static let address = "address"
    static let phone = "phone"
    static let company = "company"
    static let username = "username"
  }

  // MARK: Properties
  public var name: String?
  public var email: String?
  public var id: Int?
  public var website: String?
  public var address: PMAddress?
  public var phone: String?
  public var company: PMCompany?
  public var username: String?

  // MARK: ObjectMapper Initializers
  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public required init?(map: Map){

  }

  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public func mapping(map: Map) {
    name <- map[SerializationKeys.name]
    email <- map[SerializationKeys.email]
    id <- map[SerializationKeys.id]
    website <- map[SerializationKeys.website]
    address <- map[SerializationKeys.address]
    phone <- map[SerializationKeys.phone]
    company <- map[SerializationKeys.company]
    username <- map[SerializationKeys.username]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = email { dictionary[SerializationKeys.email] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = website { dictionary[SerializationKeys.website] = value }
    if let value = address { dictionary[SerializationKeys.address] = value.dictionaryRepresentation() }
    if let value = phone { dictionary[SerializationKeys.phone] = value }
    if let value = company { dictionary[SerializationKeys.company] = value.dictionaryRepresentation() }
    if let value = username { dictionary[SerializationKeys.username] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.email = aDecoder.decodeObject(forKey: SerializationKeys.email) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.website = aDecoder.decodeObject(forKey: SerializationKeys.website) as? String
    self.address = aDecoder.decodeObject(forKey: SerializationKeys.address) as? PMAddress
    self.phone = aDecoder.decodeObject(forKey: SerializationKeys.phone) as? String
    self.company = aDecoder.decodeObject(forKey: SerializationKeys.company) as? PMCompany
    self.username = aDecoder.decodeObject(forKey: SerializationKeys.username) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(email, forKey: SerializationKeys.email)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(website, forKey: SerializationKeys.website)
    aCoder.encode(address, forKey: SerializationKeys.address)
    aCoder.encode(phone, forKey: SerializationKeys.phone)
    aCoder.encode(company, forKey: SerializationKeys.company)
    aCoder.encode(username, forKey: SerializationKeys.username)
  }

}
