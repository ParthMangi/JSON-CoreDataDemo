//
//  PMAddress.swift
//
//  Created by ravi on 27/04/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class PMAddress: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let street = "street"
    static let city = "city"
    static let geo = "geo"
    static let suite = "suite"
    static let zipcode = "zipcode"
  }

  // MARK: Properties
  public var street: String?
  public var city: String?
  public var geo: PMGeo?
  public var suite: String?
  public var zipcode: String?

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
    street <- map[SerializationKeys.street]
    city <- map[SerializationKeys.city]
    geo <- map[SerializationKeys.geo]
    suite <- map[SerializationKeys.suite]
    zipcode <- map[SerializationKeys.zipcode]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = street { dictionary[SerializationKeys.street] = value }
    if let value = city { dictionary[SerializationKeys.city] = value }
    if let value = geo { dictionary[SerializationKeys.geo] = value.dictionaryRepresentation() }
    if let value = suite { dictionary[SerializationKeys.suite] = value }
    if let value = zipcode { dictionary[SerializationKeys.zipcode] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.street = aDecoder.decodeObject(forKey: SerializationKeys.street) as? String
    self.city = aDecoder.decodeObject(forKey: SerializationKeys.city) as? String
    self.geo = aDecoder.decodeObject(forKey: SerializationKeys.geo) as? PMGeo
    self.suite = aDecoder.decodeObject(forKey: SerializationKeys.suite) as? String
    self.zipcode = aDecoder.decodeObject(forKey: SerializationKeys.zipcode) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(street, forKey: SerializationKeys.street)
    aCoder.encode(city, forKey: SerializationKeys.city)
    aCoder.encode(geo, forKey: SerializationKeys.geo)
    aCoder.encode(suite, forKey: SerializationKeys.suite)
    aCoder.encode(zipcode, forKey: SerializationKeys.zipcode)
  }

}
