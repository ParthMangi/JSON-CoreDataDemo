//
//  PMCompany.swift
//
//  Created by ravi on 27/04/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class PMCompany: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let bs = "bs"
    static let name = "name"
    static let catchPhrase = "catchPhrase"
  }

  // MARK: Properties
  public var bs: String?
  public var name: String?
  public var catchPhrase: String?

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
    bs <- map[SerializationKeys.bs]
    name <- map[SerializationKeys.name]
    catchPhrase <- map[SerializationKeys.catchPhrase]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = bs { dictionary[SerializationKeys.bs] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = catchPhrase { dictionary[SerializationKeys.catchPhrase] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.bs = aDecoder.decodeObject(forKey: SerializationKeys.bs) as? String
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.catchPhrase = aDecoder.decodeObject(forKey: SerializationKeys.catchPhrase) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(bs, forKey: SerializationKeys.bs)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(catchPhrase, forKey: SerializationKeys.catchPhrase)
  }

}
