// Generated by the Protocol Buffers 3.0 compiler.  DO NOT EDIT!
// Source file "Message.proto"
// Syntax "Proto2"

import Foundation
import ProtocolBuffers


public struct MessageRoot {
  public static let `default` = MessageRoot()
  public var extensionRegistry:ExtensionRegistry

  init() {
    extensionRegistry = ExtensionRegistry()
    registerAllExtensions(registry: extensionRegistry)
  }
  public func registerAllExtensions(registry: ExtensionRegistry) {
  }
}

final public class UserInfo : GeneratedMessage {

  public static func == (lhs: UserInfo, rhs: UserInfo) -> Bool {
    if (lhs === rhs) {
      return true
    }
    var fieldCheck:Bool = (lhs.hashValue == rhs.hashValue)
    fieldCheck = fieldCheck && (lhs.hasName == rhs.hasName) && (!lhs.hasName || lhs.name == rhs.name)
    fieldCheck = fieldCheck && (lhs.hasLevel == rhs.hasLevel) && (!lhs.hasLevel || lhs.level == rhs.level)
    fieldCheck = (fieldCheck && (lhs.unknownFields == rhs.unknownFields))
    return fieldCheck
  }

  public fileprivate(set) var name:String = ""
  public fileprivate(set) var hasName:Bool = false

  public fileprivate(set) var level:Int32 = Int32(0)
  public fileprivate(set) var hasLevel:Bool = false

  required public init() {
       super.init()
  }
  override public func isInitialized() -> Bool {
    if !hasName {
      return false
    }
    if !hasLevel {
      return false
    }
   return true
  }
  override public func writeTo(codedOutputStream: CodedOutputStream) throws {
    if hasName {
      try codedOutputStream.writeString(fieldNumber: 1, value:name)
    }
    if hasLevel {
      try codedOutputStream.writeInt32(fieldNumber: 2, value:level)
    }
    try unknownFields.writeTo(codedOutputStream: codedOutputStream)
  }
  override public func serializedSize() -> Int32 {
    var serialize_size:Int32 = memoizedSerializedSize
    if serialize_size != -1 {
     return serialize_size
    }

    serialize_size = 0
    if hasName {
      serialize_size += name.computeStringSize(fieldNumber: 1)
    }
    if hasLevel {
      serialize_size += level.computeInt32Size(fieldNumber: 2)
    }
    serialize_size += unknownFields.serializedSize()
    memoizedSerializedSize = serialize_size
    return serialize_size
  }
  public class func getBuilder() -> UserInfo.Builder {
    return UserInfo.classBuilder() as! UserInfo.Builder
  }
  public func getBuilder() -> UserInfo.Builder {
    return classBuilder() as! UserInfo.Builder
  }
  override public class func classBuilder() -> ProtocolBuffersMessageBuilder {
    return UserInfo.Builder()
  }
  override public func classBuilder() -> ProtocolBuffersMessageBuilder {
    return UserInfo.Builder()
  }
  public func toBuilder() throws -> UserInfo.Builder {
    return try UserInfo.builderWithPrototype(prototype:self)
  }
  public class func builderWithPrototype(prototype:UserInfo) throws -> UserInfo.Builder {
    return try UserInfo.Builder().mergeFrom(other:prototype)
  }
  override public func encode() throws -> Dictionary<String,Any> {
    guard isInitialized() else {
      throw ProtocolBuffersError.invalidProtocolBuffer("Uninitialized Message")
    }

    var jsonMap:Dictionary<String,Any> = Dictionary<String,Any>()
    if hasName {
      jsonMap["name"] = name
    }
    if hasLevel {
      jsonMap["level"] = Int(level)
    }
    return jsonMap
  }
  override class public func decode(jsonMap:Dictionary<String,Any>) throws -> UserInfo {
    return try UserInfo.Builder.decodeToBuilder(jsonMap:jsonMap).build()
  }
  override class public func fromJSON(data:Data) throws -> UserInfo {
    return try UserInfo.Builder.fromJSONToBuilder(data:data).build()
  }
  override public func getDescription(indent:String) throws -> String {
    var output = ""
    if hasName {
      output += "\(indent) name: \(name) \n"
    }
    if hasLevel {
      output += "\(indent) level: \(level) \n"
    }
    output += unknownFields.getDescription(indent: indent)
    return output
  }
  override public var hashValue:Int {
      get {
          var hashCode:Int = 7
          if hasName {
             hashCode = (hashCode &* 31) &+ name.hashValue
          }
          if hasLevel {
             hashCode = (hashCode &* 31) &+ level.hashValue
          }
          hashCode = (hashCode &* 31) &+  unknownFields.hashValue
          return hashCode
      }
  }


  //Meta information declaration start

  override public class func className() -> String {
      return "UserInfo"
  }
  override public func className() -> String {
      return "UserInfo"
  }
  //Meta information declaration end

  final public class Builder : GeneratedMessageBuilder {
    fileprivate var builderResult:UserInfo = UserInfo()
    public func getMessage() -> UserInfo {
        return builderResult
    }

    required override public init () {
       super.init()
    }
    public var hasName:Bool {
         get {
              return builderResult.hasName
         }
    }
    public var name:String {
         get {
              return builderResult.name
         }
         set (value) {
             builderResult.hasName = true
             builderResult.name = value
         }
    }
    @discardableResult
    public func setName(_ value:String) -> UserInfo.Builder {
      self.name = value
      return self
    }
    @discardableResult
    public func clearName() -> UserInfo.Builder{
         builderResult.hasName = false
         builderResult.name = ""
         return self
    }
    public var hasLevel:Bool {
         get {
              return builderResult.hasLevel
         }
    }
    public var level:Int32 {
         get {
              return builderResult.level
         }
         set (value) {
             builderResult.hasLevel = true
             builderResult.level = value
         }
    }
    @discardableResult
    public func setLevel(_ value:Int32) -> UserInfo.Builder {
      self.level = value
      return self
    }
    @discardableResult
    public func clearLevel() -> UserInfo.Builder{
         builderResult.hasLevel = false
         builderResult.level = Int32(0)
         return self
    }
    override public var internalGetResult:GeneratedMessage {
         get {
            return builderResult
         }
    }
    @discardableResult
    override public func clear() -> UserInfo.Builder {
      builderResult = UserInfo()
      return self
    }
    override public func clone() throws -> UserInfo.Builder {
      return try UserInfo.builderWithPrototype(prototype:builderResult)
    }
    override public func build() throws -> UserInfo {
         try checkInitialized()
         return buildPartial()
    }
    public func buildPartial() -> UserInfo {
      let returnMe:UserInfo = builderResult
      return returnMe
    }
    @discardableResult
    public func mergeFrom(other:UserInfo) throws -> UserInfo.Builder {
      if other == UserInfo() {
       return self
      }
      if other.hasName {
           name = other.name
      }
      if other.hasLevel {
           level = other.level
      }
      try merge(unknownField: other.unknownFields)
      return self
    }
    @discardableResult
    override public func mergeFrom(codedInputStream: CodedInputStream) throws -> UserInfo.Builder {
         return try mergeFrom(codedInputStream: codedInputStream, extensionRegistry:ExtensionRegistry())
    }
    @discardableResult
    override public func mergeFrom(codedInputStream: CodedInputStream, extensionRegistry:ExtensionRegistry) throws -> UserInfo.Builder {
      let unknownFieldsBuilder:UnknownFieldSet.Builder = try UnknownFieldSet.builderWithUnknownFields(copyFrom:self.unknownFields)
      while (true) {
        let protobufTag = try codedInputStream.readTag()
        switch protobufTag {
        case 0: 
          self.unknownFields = try unknownFieldsBuilder.build()
          return self

        case 10:
          name = try codedInputStream.readString()

        case 16:
          level = try codedInputStream.readInt32()

        default:
          if (!(try parse(codedInputStream:codedInputStream, unknownFields:unknownFieldsBuilder, extensionRegistry:extensionRegistry, tag:protobufTag))) {
             unknownFields = try unknownFieldsBuilder.build()
             return self
          }
        }
      }
    }
    class override public func decodeToBuilder(jsonMap:Dictionary<String,Any>) throws -> UserInfo.Builder {
      let resultDecodedBuilder = UserInfo.Builder()
      if let jsonValueName = jsonMap["name"] as? String {
        resultDecodedBuilder.name = jsonValueName
      }
      if let jsonValueLevel = jsonMap["level"] as? Int {
        resultDecodedBuilder.level = Int32(jsonValueLevel)
      }
      return resultDecodedBuilder
    }
    override class public func fromJSONToBuilder(data:Data) throws -> UserInfo.Builder {
      let jsonData = try JSONSerialization.jsonObject(with:data, options: JSONSerialization.ReadingOptions(rawValue: 0))
      guard let jsDataCast = jsonData as? Dictionary<String,Any> else {
        throw ProtocolBuffersError.invalidProtocolBuffer("Invalid JSON data")
      }
      return try UserInfo.Builder.decodeToBuilder(jsonMap:jsDataCast)
    }
  }

}

final public class TextMessage : GeneratedMessage {

  public static func == (lhs: TextMessage, rhs: TextMessage) -> Bool {
    if (lhs === rhs) {
      return true
    }
    var fieldCheck:Bool = (lhs.hashValue == rhs.hashValue)
    fieldCheck = fieldCheck && (lhs.hasText == rhs.hasText) && (!lhs.hasText || lhs.text == rhs.text)
    fieldCheck = fieldCheck && (lhs.hasUser == rhs.hasUser) && (!lhs.hasUser || lhs.user == rhs.user)
    fieldCheck = (fieldCheck && (lhs.unknownFields == rhs.unknownFields))
    return fieldCheck
  }

  public fileprivate(set) var text:String = ""
  public fileprivate(set) var hasText:Bool = false

  public fileprivate(set) var user:UserInfo!
  public fileprivate(set) var hasUser:Bool = false
  required public init() {
       super.init()
  }
  override public func isInitialized() -> Bool {
    if !hasText {
      return false
    }
    if !hasUser {
      return false
    }
    if !user.isInitialized() {
      return false
    }
   return true
  }
  override public func writeTo(codedOutputStream: CodedOutputStream) throws {
    if hasText {
      try codedOutputStream.writeString(fieldNumber: 1, value:text)
    }
    if hasUser {
      try codedOutputStream.writeMessage(fieldNumber: 2, value:user)
    }
    try unknownFields.writeTo(codedOutputStream: codedOutputStream)
  }
  override public func serializedSize() -> Int32 {
    var serialize_size:Int32 = memoizedSerializedSize
    if serialize_size != -1 {
     return serialize_size
    }

    serialize_size = 0
    if hasText {
      serialize_size += text.computeStringSize(fieldNumber: 1)
    }
    if hasUser {
        if let varSizeuser = user?.computeMessageSize(fieldNumber: 2) {
            serialize_size += varSizeuser
        }
    }
    serialize_size += unknownFields.serializedSize()
    memoizedSerializedSize = serialize_size
    return serialize_size
  }
  public class func getBuilder() -> TextMessage.Builder {
    return TextMessage.classBuilder() as! TextMessage.Builder
  }
  public func getBuilder() -> TextMessage.Builder {
    return classBuilder() as! TextMessage.Builder
  }
  override public class func classBuilder() -> ProtocolBuffersMessageBuilder {
    return TextMessage.Builder()
  }
  override public func classBuilder() -> ProtocolBuffersMessageBuilder {
    return TextMessage.Builder()
  }
  public func toBuilder() throws -> TextMessage.Builder {
    return try TextMessage.builderWithPrototype(prototype:self)
  }
  public class func builderWithPrototype(prototype:TextMessage) throws -> TextMessage.Builder {
    return try TextMessage.Builder().mergeFrom(other:prototype)
  }
  override public func encode() throws -> Dictionary<String,Any> {
    guard isInitialized() else {
      throw ProtocolBuffersError.invalidProtocolBuffer("Uninitialized Message")
    }

    var jsonMap:Dictionary<String,Any> = Dictionary<String,Any>()
    if hasText {
      jsonMap["text"] = text
    }
    if hasUser {
      jsonMap["user"] = try user.encode()
    }
    return jsonMap
  }
  override class public func decode(jsonMap:Dictionary<String,Any>) throws -> TextMessage {
    return try TextMessage.Builder.decodeToBuilder(jsonMap:jsonMap).build()
  }
  override class public func fromJSON(data:Data) throws -> TextMessage {
    return try TextMessage.Builder.fromJSONToBuilder(data:data).build()
  }
  override public func getDescription(indent:String) throws -> String {
    var output = ""
    if hasText {
      output += "\(indent) text: \(text) \n"
    }
    if hasUser {
      output += "\(indent) user {\n"
      if let outDescUser = user {
        output += try outDescUser.getDescription(indent: "\(indent)  ")
      }
      output += "\(indent) }\n"
    }
    output += unknownFields.getDescription(indent: indent)
    return output
  }
  override public var hashValue:Int {
      get {
          var hashCode:Int = 7
          if hasText {
             hashCode = (hashCode &* 31) &+ text.hashValue
          }
          if hasUser {
              if let hashValueuser = user?.hashValue {
                  hashCode = (hashCode &* 31) &+ hashValueuser
              }
          }
          hashCode = (hashCode &* 31) &+  unknownFields.hashValue
          return hashCode
      }
  }


  //Meta information declaration start

  override public class func className() -> String {
      return "TextMessage"
  }
  override public func className() -> String {
      return "TextMessage"
  }
  //Meta information declaration end

  final public class Builder : GeneratedMessageBuilder {
    fileprivate var builderResult:TextMessage = TextMessage()
    public func getMessage() -> TextMessage {
        return builderResult
    }

    required override public init () {
       super.init()
    }
    public var hasText:Bool {
         get {
              return builderResult.hasText
         }
    }
    public var text:String {
         get {
              return builderResult.text
         }
         set (value) {
             builderResult.hasText = true
             builderResult.text = value
         }
    }
    @discardableResult
    public func setText(_ value:String) -> TextMessage.Builder {
      self.text = value
      return self
    }
    @discardableResult
    public func clearText() -> TextMessage.Builder{
         builderResult.hasText = false
         builderResult.text = ""
         return self
    }
    public var hasUser:Bool {
         get {
             return builderResult.hasUser
         }
    }
    public var user:UserInfo! {
         get {
             if userBuilder_ != nil {
                builderResult.user = userBuilder_.getMessage()
             }
             return builderResult.user
         }
         set (value) {
             builderResult.hasUser = true
             builderResult.user = value
         }
    }
    fileprivate var userBuilder_:UserInfo.Builder! {
         didSet {
            builderResult.hasUser = true
         }
    }
    public func getUserBuilder() -> UserInfo.Builder {
      if userBuilder_ == nil {
         userBuilder_ = UserInfo.Builder()
         builderResult.user = userBuilder_.getMessage()
         if user != nil {
            try! userBuilder_.mergeFrom(other: user)
         }
      }
      return userBuilder_
    }
    @discardableResult
    public func setUser(_ value:UserInfo!) -> TextMessage.Builder {
      self.user = value
      return self
    }
    @discardableResult
    public func mergeUser(value:UserInfo) throws -> TextMessage.Builder {
      if builderResult.hasUser {
        builderResult.user = try UserInfo.builderWithPrototype(prototype:builderResult.user).mergeFrom(other: value).buildPartial()
      } else {
        builderResult.user = value
      }
      builderResult.hasUser = true
      return self
    }
    @discardableResult
    public func clearUser() -> TextMessage.Builder {
      userBuilder_ = nil
      builderResult.hasUser = false
      builderResult.user = nil
      return self
    }
    override public var internalGetResult:GeneratedMessage {
         get {
            return builderResult
         }
    }
    @discardableResult
    override public func clear() -> TextMessage.Builder {
      builderResult = TextMessage()
      return self
    }
    override public func clone() throws -> TextMessage.Builder {
      return try TextMessage.builderWithPrototype(prototype:builderResult)
    }
    override public func build() throws -> TextMessage {
         try checkInitialized()
         return buildPartial()
    }
    public func buildPartial() -> TextMessage {
      let returnMe:TextMessage = builderResult
      return returnMe
    }
    @discardableResult
    public func mergeFrom(other:TextMessage) throws -> TextMessage.Builder {
      if other == TextMessage() {
       return self
      }
      if other.hasText {
           text = other.text
      }
      if (other.hasUser) {
          try mergeUser(value: other.user)
      }
      try merge(unknownField: other.unknownFields)
      return self
    }
    @discardableResult
    override public func mergeFrom(codedInputStream: CodedInputStream) throws -> TextMessage.Builder {
         return try mergeFrom(codedInputStream: codedInputStream, extensionRegistry:ExtensionRegistry())
    }
    @discardableResult
    override public func mergeFrom(codedInputStream: CodedInputStream, extensionRegistry:ExtensionRegistry) throws -> TextMessage.Builder {
      let unknownFieldsBuilder:UnknownFieldSet.Builder = try UnknownFieldSet.builderWithUnknownFields(copyFrom:self.unknownFields)
      while (true) {
        let protobufTag = try codedInputStream.readTag()
        switch protobufTag {
        case 0: 
          self.unknownFields = try unknownFieldsBuilder.build()
          return self

        case 10:
          text = try codedInputStream.readString()

        case 18:
          let subBuilder:UserInfo.Builder = UserInfo.Builder()
          if hasUser {
            try subBuilder.mergeFrom(other: user)
          }
          try codedInputStream.readMessage(builder: subBuilder, extensionRegistry:extensionRegistry)
          user = subBuilder.buildPartial()

        default:
          if (!(try parse(codedInputStream:codedInputStream, unknownFields:unknownFieldsBuilder, extensionRegistry:extensionRegistry, tag:protobufTag))) {
             unknownFields = try unknownFieldsBuilder.build()
             return self
          }
        }
      }
    }
    class override public func decodeToBuilder(jsonMap:Dictionary<String,Any>) throws -> TextMessage.Builder {
      let resultDecodedBuilder = TextMessage.Builder()
      if let jsonValueText = jsonMap["text"] as? String {
        resultDecodedBuilder.text = jsonValueText
      }
      if let jsonValueUser = jsonMap["user"] as? Dictionary<String,Any> {
        resultDecodedBuilder.user = try UserInfo.Builder.decodeToBuilder(jsonMap:jsonValueUser).build()

      }
      return resultDecodedBuilder
    }
    override class public func fromJSONToBuilder(data:Data) throws -> TextMessage.Builder {
      let jsonData = try JSONSerialization.jsonObject(with:data, options: JSONSerialization.ReadingOptions(rawValue: 0))
      guard let jsDataCast = jsonData as? Dictionary<String,Any> else {
        throw ProtocolBuffersError.invalidProtocolBuffer("Invalid JSON data")
      }
      return try TextMessage.Builder.decodeToBuilder(jsonMap:jsDataCast)
    }
  }

}

final public class GiftMessage : GeneratedMessage {

  public static func == (lhs: GiftMessage, rhs: GiftMessage) -> Bool {
    if (lhs === rhs) {
      return true
    }
    var fieldCheck:Bool = (lhs.hashValue == rhs.hashValue)
    fieldCheck = fieldCheck && (lhs.hasGiftName == rhs.hasGiftName) && (!lhs.hasGiftName || lhs.giftName == rhs.giftName)
    fieldCheck = fieldCheck && (lhs.hasGiftUrl == rhs.hasGiftUrl) && (!lhs.hasGiftUrl || lhs.giftUrl == rhs.giftUrl)
    fieldCheck = fieldCheck && (lhs.hasGiftCount == rhs.hasGiftCount) && (!lhs.hasGiftCount || lhs.giftCount == rhs.giftCount)
    fieldCheck = fieldCheck && (lhs.hasUser == rhs.hasUser) && (!lhs.hasUser || lhs.user == rhs.user)
    fieldCheck = (fieldCheck && (lhs.unknownFields == rhs.unknownFields))
    return fieldCheck
  }

  public fileprivate(set) var giftName:String = ""
  public fileprivate(set) var hasGiftName:Bool = false

  public fileprivate(set) var giftUrl:String = ""
  public fileprivate(set) var hasGiftUrl:Bool = false

  public fileprivate(set) var giftCount:Int32 = Int32(0)
  public fileprivate(set) var hasGiftCount:Bool = false

  public fileprivate(set) var user:UserInfo!
  public fileprivate(set) var hasUser:Bool = false
  required public init() {
       super.init()
  }
  override public func isInitialized() -> Bool {
    if !hasGiftName {
      return false
    }
    if !hasGiftUrl {
      return false
    }
    if !hasGiftCount {
      return false
    }
    if !hasUser {
      return false
    }
    if !user.isInitialized() {
      return false
    }
   return true
  }
  override public func writeTo(codedOutputStream: CodedOutputStream) throws {
    if hasGiftName {
      try codedOutputStream.writeString(fieldNumber: 1, value:giftName)
    }
    if hasGiftUrl {
      try codedOutputStream.writeString(fieldNumber: 2, value:giftUrl)
    }
    if hasGiftCount {
      try codedOutputStream.writeInt32(fieldNumber: 3, value:giftCount)
    }
    if hasUser {
      try codedOutputStream.writeMessage(fieldNumber: 4, value:user)
    }
    try unknownFields.writeTo(codedOutputStream: codedOutputStream)
  }
  override public func serializedSize() -> Int32 {
    var serialize_size:Int32 = memoizedSerializedSize
    if serialize_size != -1 {
     return serialize_size
    }

    serialize_size = 0
    if hasGiftName {
      serialize_size += giftName.computeStringSize(fieldNumber: 1)
    }
    if hasGiftUrl {
      serialize_size += giftUrl.computeStringSize(fieldNumber: 2)
    }
    if hasGiftCount {
      serialize_size += giftCount.computeInt32Size(fieldNumber: 3)
    }
    if hasUser {
        if let varSizeuser = user?.computeMessageSize(fieldNumber: 4) {
            serialize_size += varSizeuser
        }
    }
    serialize_size += unknownFields.serializedSize()
    memoizedSerializedSize = serialize_size
    return serialize_size
  }
  public class func getBuilder() -> GiftMessage.Builder {
    return GiftMessage.classBuilder() as! GiftMessage.Builder
  }
  public func getBuilder() -> GiftMessage.Builder {
    return classBuilder() as! GiftMessage.Builder
  }
  override public class func classBuilder() -> ProtocolBuffersMessageBuilder {
    return GiftMessage.Builder()
  }
  override public func classBuilder() -> ProtocolBuffersMessageBuilder {
    return GiftMessage.Builder()
  }
  public func toBuilder() throws -> GiftMessage.Builder {
    return try GiftMessage.builderWithPrototype(prototype:self)
  }
  public class func builderWithPrototype(prototype:GiftMessage) throws -> GiftMessage.Builder {
    return try GiftMessage.Builder().mergeFrom(other:prototype)
  }
  override public func encode() throws -> Dictionary<String,Any> {
    guard isInitialized() else {
      throw ProtocolBuffersError.invalidProtocolBuffer("Uninitialized Message")
    }

    var jsonMap:Dictionary<String,Any> = Dictionary<String,Any>()
    if hasGiftName {
      jsonMap["giftName"] = giftName
    }
    if hasGiftUrl {
      jsonMap["giftUrl"] = giftUrl
    }
    if hasGiftCount {
      jsonMap["giftCount"] = Int(giftCount)
    }
    if hasUser {
      jsonMap["user"] = try user.encode()
    }
    return jsonMap
  }
  override class public func decode(jsonMap:Dictionary<String,Any>) throws -> GiftMessage {
    return try GiftMessage.Builder.decodeToBuilder(jsonMap:jsonMap).build()
  }
  override class public func fromJSON(data:Data) throws -> GiftMessage {
    return try GiftMessage.Builder.fromJSONToBuilder(data:data).build()
  }
  override public func getDescription(indent:String) throws -> String {
    var output = ""
    if hasGiftName {
      output += "\(indent) giftName: \(giftName) \n"
    }
    if hasGiftUrl {
      output += "\(indent) giftUrl: \(giftUrl) \n"
    }
    if hasGiftCount {
      output += "\(indent) giftCount: \(giftCount) \n"
    }
    if hasUser {
      output += "\(indent) user {\n"
      if let outDescUser = user {
        output += try outDescUser.getDescription(indent: "\(indent)  ")
      }
      output += "\(indent) }\n"
    }
    output += unknownFields.getDescription(indent: indent)
    return output
  }
  override public var hashValue:Int {
      get {
          var hashCode:Int = 7
          if hasGiftName {
             hashCode = (hashCode &* 31) &+ giftName.hashValue
          }
          if hasGiftUrl {
             hashCode = (hashCode &* 31) &+ giftUrl.hashValue
          }
          if hasGiftCount {
             hashCode = (hashCode &* 31) &+ giftCount.hashValue
          }
          if hasUser {
              if let hashValueuser = user?.hashValue {
                  hashCode = (hashCode &* 31) &+ hashValueuser
              }
          }
          hashCode = (hashCode &* 31) &+  unknownFields.hashValue
          return hashCode
      }
  }


  //Meta information declaration start

  override public class func className() -> String {
      return "GiftMessage"
  }
  override public func className() -> String {
      return "GiftMessage"
  }
  //Meta information declaration end

  final public class Builder : GeneratedMessageBuilder {
    fileprivate var builderResult:GiftMessage = GiftMessage()
    public func getMessage() -> GiftMessage {
        return builderResult
    }

    required override public init () {
       super.init()
    }
    public var hasGiftName:Bool {
         get {
              return builderResult.hasGiftName
         }
    }
    public var giftName:String {
         get {
              return builderResult.giftName
         }
         set (value) {
             builderResult.hasGiftName = true
             builderResult.giftName = value
         }
    }
    @discardableResult
    public func setGiftName(_ value:String) -> GiftMessage.Builder {
      self.giftName = value
      return self
    }
    @discardableResult
    public func clearGiftName() -> GiftMessage.Builder{
         builderResult.hasGiftName = false
         builderResult.giftName = ""
         return self
    }
    public var hasGiftUrl:Bool {
         get {
              return builderResult.hasGiftUrl
         }
    }
    public var giftUrl:String {
         get {
              return builderResult.giftUrl
         }
         set (value) {
             builderResult.hasGiftUrl = true
             builderResult.giftUrl = value
         }
    }
    @discardableResult
    public func setGiftUrl(_ value:String) -> GiftMessage.Builder {
      self.giftUrl = value
      return self
    }
    @discardableResult
    public func clearGiftUrl() -> GiftMessage.Builder{
         builderResult.hasGiftUrl = false
         builderResult.giftUrl = ""
         return self
    }
    public var hasGiftCount:Bool {
         get {
              return builderResult.hasGiftCount
         }
    }
    public var giftCount:Int32 {
         get {
              return builderResult.giftCount
         }
         set (value) {
             builderResult.hasGiftCount = true
             builderResult.giftCount = value
         }
    }
    @discardableResult
    public func setGiftCount(_ value:Int32) -> GiftMessage.Builder {
      self.giftCount = value
      return self
    }
    @discardableResult
    public func clearGiftCount() -> GiftMessage.Builder{
         builderResult.hasGiftCount = false
         builderResult.giftCount = Int32(0)
         return self
    }
    public var hasUser:Bool {
         get {
             return builderResult.hasUser
         }
    }
    public var user:UserInfo! {
         get {
             if userBuilder_ != nil {
                builderResult.user = userBuilder_.getMessage()
             }
             return builderResult.user
         }
         set (value) {
             builderResult.hasUser = true
             builderResult.user = value
         }
    }
    fileprivate var userBuilder_:UserInfo.Builder! {
         didSet {
            builderResult.hasUser = true
         }
    }
    public func getUserBuilder() -> UserInfo.Builder {
      if userBuilder_ == nil {
         userBuilder_ = UserInfo.Builder()
         builderResult.user = userBuilder_.getMessage()
         if user != nil {
            try! userBuilder_.mergeFrom(other: user)
         }
      }
      return userBuilder_
    }
    @discardableResult
    public func setUser(_ value:UserInfo!) -> GiftMessage.Builder {
      self.user = value
      return self
    }
    @discardableResult
    public func mergeUser(value:UserInfo) throws -> GiftMessage.Builder {
      if builderResult.hasUser {
        builderResult.user = try UserInfo.builderWithPrototype(prototype:builderResult.user).mergeFrom(other: value).buildPartial()
      } else {
        builderResult.user = value
      }
      builderResult.hasUser = true
      return self
    }
    @discardableResult
    public func clearUser() -> GiftMessage.Builder {
      userBuilder_ = nil
      builderResult.hasUser = false
      builderResult.user = nil
      return self
    }
    override public var internalGetResult:GeneratedMessage {
         get {
            return builderResult
         }
    }
    @discardableResult
    override public func clear() -> GiftMessage.Builder {
      builderResult = GiftMessage()
      return self
    }
    override public func clone() throws -> GiftMessage.Builder {
      return try GiftMessage.builderWithPrototype(prototype:builderResult)
    }
    override public func build() throws -> GiftMessage {
         try checkInitialized()
         return buildPartial()
    }
    public func buildPartial() -> GiftMessage {
      let returnMe:GiftMessage = builderResult
      return returnMe
    }
    @discardableResult
    public func mergeFrom(other:GiftMessage) throws -> GiftMessage.Builder {
      if other == GiftMessage() {
       return self
      }
      if other.hasGiftName {
           giftName = other.giftName
      }
      if other.hasGiftUrl {
           giftUrl = other.giftUrl
      }
      if other.hasGiftCount {
           giftCount = other.giftCount
      }
      if (other.hasUser) {
          try mergeUser(value: other.user)
      }
      try merge(unknownField: other.unknownFields)
      return self
    }
    @discardableResult
    override public func mergeFrom(codedInputStream: CodedInputStream) throws -> GiftMessage.Builder {
         return try mergeFrom(codedInputStream: codedInputStream, extensionRegistry:ExtensionRegistry())
    }
    @discardableResult
    override public func mergeFrom(codedInputStream: CodedInputStream, extensionRegistry:ExtensionRegistry) throws -> GiftMessage.Builder {
      let unknownFieldsBuilder:UnknownFieldSet.Builder = try UnknownFieldSet.builderWithUnknownFields(copyFrom:self.unknownFields)
      while (true) {
        let protobufTag = try codedInputStream.readTag()
        switch protobufTag {
        case 0: 
          self.unknownFields = try unknownFieldsBuilder.build()
          return self

        case 10:
          giftName = try codedInputStream.readString()

        case 18:
          giftUrl = try codedInputStream.readString()

        case 24:
          giftCount = try codedInputStream.readInt32()

        case 34:
          let subBuilder:UserInfo.Builder = UserInfo.Builder()
          if hasUser {
            try subBuilder.mergeFrom(other: user)
          }
          try codedInputStream.readMessage(builder: subBuilder, extensionRegistry:extensionRegistry)
          user = subBuilder.buildPartial()

        default:
          if (!(try parse(codedInputStream:codedInputStream, unknownFields:unknownFieldsBuilder, extensionRegistry:extensionRegistry, tag:protobufTag))) {
             unknownFields = try unknownFieldsBuilder.build()
             return self
          }
        }
      }
    }
    class override public func decodeToBuilder(jsonMap:Dictionary<String,Any>) throws -> GiftMessage.Builder {
      let resultDecodedBuilder = GiftMessage.Builder()
      if let jsonValueGiftName = jsonMap["giftName"] as? String {
        resultDecodedBuilder.giftName = jsonValueGiftName
      }
      if let jsonValueGiftUrl = jsonMap["giftUrl"] as? String {
        resultDecodedBuilder.giftUrl = jsonValueGiftUrl
      }
      if let jsonValueGiftCount = jsonMap["giftCount"] as? Int {
        resultDecodedBuilder.giftCount = Int32(jsonValueGiftCount)
      }
      if let jsonValueUser = jsonMap["user"] as? Dictionary<String,Any> {
        resultDecodedBuilder.user = try UserInfo.Builder.decodeToBuilder(jsonMap:jsonValueUser).build()

      }
      return resultDecodedBuilder
    }
    override class public func fromJSONToBuilder(data:Data) throws -> GiftMessage.Builder {
      let jsonData = try JSONSerialization.jsonObject(with:data, options: JSONSerialization.ReadingOptions(rawValue: 0))
      guard let jsDataCast = jsonData as? Dictionary<String,Any> else {
        throw ProtocolBuffersError.invalidProtocolBuffer("Invalid JSON data")
      }
      return try GiftMessage.Builder.decodeToBuilder(jsonMap:jsDataCast)
    }
  }

}

extension UserInfo: GeneratedMessageProtocol {
  public class func parseArrayDelimitedFrom(inputStream: InputStream) throws -> Array<UserInfo> {
    var mergedArray = Array<UserInfo>()
    while let value = try parseDelimitedFrom(inputStream: inputStream) {
      mergedArray.append(value)
    }
    return mergedArray
  }
  public class func parseDelimitedFrom(inputStream: InputStream) throws -> UserInfo? {
    return try UserInfo.Builder().mergeDelimitedFrom(inputStream: inputStream)?.build()
  }
  public class func parseFrom(data: Data) throws -> UserInfo {
    return try UserInfo.Builder().mergeFrom(data: data, extensionRegistry:MessageRoot.default.extensionRegistry).build()
  }
  public class func parseFrom(data: Data, extensionRegistry:ExtensionRegistry) throws -> UserInfo {
    return try UserInfo.Builder().mergeFrom(data: data, extensionRegistry:extensionRegistry).build()
  }
  public class func parseFrom(inputStream: InputStream) throws -> UserInfo {
    return try UserInfo.Builder().mergeFrom(inputStream: inputStream).build()
  }
  public class func parseFrom(inputStream: InputStream, extensionRegistry:ExtensionRegistry) throws -> UserInfo {
    return try UserInfo.Builder().mergeFrom(inputStream: inputStream, extensionRegistry:extensionRegistry).build()
  }
  public class func parseFrom(codedInputStream: CodedInputStream) throws -> UserInfo {
    return try UserInfo.Builder().mergeFrom(codedInputStream: codedInputStream).build()
  }
  public class func parseFrom(codedInputStream: CodedInputStream, extensionRegistry:ExtensionRegistry) throws -> UserInfo {
    return try UserInfo.Builder().mergeFrom(codedInputStream: codedInputStream, extensionRegistry:extensionRegistry).build()
  }
}
extension TextMessage: GeneratedMessageProtocol {
  public class func parseArrayDelimitedFrom(inputStream: InputStream) throws -> Array<TextMessage> {
    var mergedArray = Array<TextMessage>()
    while let value = try parseDelimitedFrom(inputStream: inputStream) {
      mergedArray.append(value)
    }
    return mergedArray
  }
  public class func parseDelimitedFrom(inputStream: InputStream) throws -> TextMessage? {
    return try TextMessage.Builder().mergeDelimitedFrom(inputStream: inputStream)?.build()
  }
  public class func parseFrom(data: Data) throws -> TextMessage {
    return try TextMessage.Builder().mergeFrom(data: data, extensionRegistry:MessageRoot.default.extensionRegistry).build()
  }
  public class func parseFrom(data: Data, extensionRegistry:ExtensionRegistry) throws -> TextMessage {
    return try TextMessage.Builder().mergeFrom(data: data, extensionRegistry:extensionRegistry).build()
  }
  public class func parseFrom(inputStream: InputStream) throws -> TextMessage {
    return try TextMessage.Builder().mergeFrom(inputStream: inputStream).build()
  }
  public class func parseFrom(inputStream: InputStream, extensionRegistry:ExtensionRegistry) throws -> TextMessage {
    return try TextMessage.Builder().mergeFrom(inputStream: inputStream, extensionRegistry:extensionRegistry).build()
  }
  public class func parseFrom(codedInputStream: CodedInputStream) throws -> TextMessage {
    return try TextMessage.Builder().mergeFrom(codedInputStream: codedInputStream).build()
  }
  public class func parseFrom(codedInputStream: CodedInputStream, extensionRegistry:ExtensionRegistry) throws -> TextMessage {
    return try TextMessage.Builder().mergeFrom(codedInputStream: codedInputStream, extensionRegistry:extensionRegistry).build()
  }
}
extension GiftMessage: GeneratedMessageProtocol {
  public class func parseArrayDelimitedFrom(inputStream: InputStream) throws -> Array<GiftMessage> {
    var mergedArray = Array<GiftMessage>()
    while let value = try parseDelimitedFrom(inputStream: inputStream) {
      mergedArray.append(value)
    }
    return mergedArray
  }
  public class func parseDelimitedFrom(inputStream: InputStream) throws -> GiftMessage? {
    return try GiftMessage.Builder().mergeDelimitedFrom(inputStream: inputStream)?.build()
  }
  public class func parseFrom(data: Data) throws -> GiftMessage {
    return try GiftMessage.Builder().mergeFrom(data: data, extensionRegistry:MessageRoot.default.extensionRegistry).build()
  }
  public class func parseFrom(data: Data, extensionRegistry:ExtensionRegistry) throws -> GiftMessage {
    return try GiftMessage.Builder().mergeFrom(data: data, extensionRegistry:extensionRegistry).build()
  }
  public class func parseFrom(inputStream: InputStream) throws -> GiftMessage {
    return try GiftMessage.Builder().mergeFrom(inputStream: inputStream).build()
  }
  public class func parseFrom(inputStream: InputStream, extensionRegistry:ExtensionRegistry) throws -> GiftMessage {
    return try GiftMessage.Builder().mergeFrom(inputStream: inputStream, extensionRegistry:extensionRegistry).build()
  }
  public class func parseFrom(codedInputStream: CodedInputStream) throws -> GiftMessage {
    return try GiftMessage.Builder().mergeFrom(codedInputStream: codedInputStream).build()
  }
  public class func parseFrom(codedInputStream: CodedInputStream, extensionRegistry:ExtensionRegistry) throws -> GiftMessage {
    return try GiftMessage.Builder().mergeFrom(codedInputStream: codedInputStream, extensionRegistry:extensionRegistry).build()
  }
}

// @@protoc_insertion_point(global_scope)
