/**
 * Autogenerated by Thrift Compiler (0.12.0)
 *
 * DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
 *  @generated
 */
package rpc.service.gen;

@SuppressWarnings({"cast", "rawtypes", "serial", "unchecked", "unused"})
@javax.annotation.Generated(value = "Autogenerated by Thrift Compiler (0.12.0)", date = "2019-05-04")
public class Author implements org.apache.thrift.TBase<Author, Author._Fields>, java.io.Serializable, Cloneable, Comparable<Author> {
  private static final org.apache.thrift.protocol.TStruct STRUCT_DESC = new org.apache.thrift.protocol.TStruct("Author");

  private static final org.apache.thrift.protocol.TField AUTHOR_ID_FIELD_DESC = new org.apache.thrift.protocol.TField("authorId", org.apache.thrift.protocol.TType.STRING, (short)1);
  private static final org.apache.thrift.protocol.TField FIRST_NAME_FIELD_DESC = new org.apache.thrift.protocol.TField("firstName", org.apache.thrift.protocol.TType.STRING, (short)2);
  private static final org.apache.thrift.protocol.TField LAST_NAME_FIELD_DESC = new org.apache.thrift.protocol.TField("lastName", org.apache.thrift.protocol.TType.STRING, (short)3);
  private static final org.apache.thrift.protocol.TField SPECIALITY_FIELD_DESC = new org.apache.thrift.protocol.TField("speciality", org.apache.thrift.protocol.TType.STRING, (short)4);

  private static final org.apache.thrift.scheme.SchemeFactory STANDARD_SCHEME_FACTORY = new AuthorStandardSchemeFactory();
  private static final org.apache.thrift.scheme.SchemeFactory TUPLE_SCHEME_FACTORY = new AuthorTupleSchemeFactory();

  public @org.apache.thrift.annotation.Nullable java.lang.String authorId; // required
  public @org.apache.thrift.annotation.Nullable java.lang.String firstName; // required
  public @org.apache.thrift.annotation.Nullable java.lang.String lastName; // required
  public @org.apache.thrift.annotation.Nullable java.lang.String speciality; // required

  /** The set of fields this struct contains, along with convenience methods for finding and manipulating them. */
  public enum _Fields implements org.apache.thrift.TFieldIdEnum {
    AUTHOR_ID((short)1, "authorId"),
    FIRST_NAME((short)2, "firstName"),
    LAST_NAME((short)3, "lastName"),
    SPECIALITY((short)4, "speciality");

    private static final java.util.Map<java.lang.String, _Fields> byName = new java.util.HashMap<java.lang.String, _Fields>();

    static {
      for (_Fields field : java.util.EnumSet.allOf(_Fields.class)) {
        byName.put(field.getFieldName(), field);
      }
    }

    /**
     * Find the _Fields constant that matches fieldId, or null if its not found.
     */
    @org.apache.thrift.annotation.Nullable
    public static _Fields findByThriftId(int fieldId) {
      switch(fieldId) {
        case 1: // AUTHOR_ID
          return AUTHOR_ID;
        case 2: // FIRST_NAME
          return FIRST_NAME;
        case 3: // LAST_NAME
          return LAST_NAME;
        case 4: // SPECIALITY
          return SPECIALITY;
        default:
          return null;
      }
    }

    /**
     * Find the _Fields constant that matches fieldId, throwing an exception
     * if it is not found.
     */
    public static _Fields findByThriftIdOrThrow(int fieldId) {
      _Fields fields = findByThriftId(fieldId);
      if (fields == null) throw new java.lang.IllegalArgumentException("Field " + fieldId + " doesn't exist!");
      return fields;
    }

    /**
     * Find the _Fields constant that matches name, or null if its not found.
     */
    @org.apache.thrift.annotation.Nullable
    public static _Fields findByName(java.lang.String name) {
      return byName.get(name);
    }

    private final short _thriftId;
    private final java.lang.String _fieldName;

    _Fields(short thriftId, java.lang.String fieldName) {
      _thriftId = thriftId;
      _fieldName = fieldName;
    }

    public short getThriftFieldId() {
      return _thriftId;
    }

    public java.lang.String getFieldName() {
      return _fieldName;
    }
  }

  // isset id assignments
  public static final java.util.Map<_Fields, org.apache.thrift.meta_data.FieldMetaData> metaDataMap;
  static {
    java.util.Map<_Fields, org.apache.thrift.meta_data.FieldMetaData> tmpMap = new java.util.EnumMap<_Fields, org.apache.thrift.meta_data.FieldMetaData>(_Fields.class);
    tmpMap.put(_Fields.AUTHOR_ID, new org.apache.thrift.meta_data.FieldMetaData("authorId", org.apache.thrift.TFieldRequirementType.DEFAULT, 
        new org.apache.thrift.meta_data.FieldValueMetaData(org.apache.thrift.protocol.TType.STRING)));
    tmpMap.put(_Fields.FIRST_NAME, new org.apache.thrift.meta_data.FieldMetaData("firstName", org.apache.thrift.TFieldRequirementType.DEFAULT, 
        new org.apache.thrift.meta_data.FieldValueMetaData(org.apache.thrift.protocol.TType.STRING)));
    tmpMap.put(_Fields.LAST_NAME, new org.apache.thrift.meta_data.FieldMetaData("lastName", org.apache.thrift.TFieldRequirementType.DEFAULT, 
        new org.apache.thrift.meta_data.FieldValueMetaData(org.apache.thrift.protocol.TType.STRING)));
    tmpMap.put(_Fields.SPECIALITY, new org.apache.thrift.meta_data.FieldMetaData("speciality", org.apache.thrift.TFieldRequirementType.DEFAULT, 
        new org.apache.thrift.meta_data.FieldValueMetaData(org.apache.thrift.protocol.TType.STRING)));
    metaDataMap = java.util.Collections.unmodifiableMap(tmpMap);
    org.apache.thrift.meta_data.FieldMetaData.addStructMetaDataMap(Author.class, metaDataMap);
  }

  public Author() {
  }

  public Author(
    java.lang.String authorId,
    java.lang.String firstName,
    java.lang.String lastName,
    java.lang.String speciality)
  {
    this();
    this.authorId = authorId;
    this.firstName = firstName;
    this.lastName = lastName;
    this.speciality = speciality;
  }

  /**
   * Performs a deep copy on <i>other</i>.
   */
  public Author(Author other) {
    if (other.isSetAuthorId()) {
      this.authorId = other.authorId;
    }
    if (other.isSetFirstName()) {
      this.firstName = other.firstName;
    }
    if (other.isSetLastName()) {
      this.lastName = other.lastName;
    }
    if (other.isSetSpeciality()) {
      this.speciality = other.speciality;
    }
  }

  public Author deepCopy() {
    return new Author(this);
  }

  @Override
  public void clear() {
    this.authorId = null;
    this.firstName = null;
    this.lastName = null;
    this.speciality = null;
  }

  @org.apache.thrift.annotation.Nullable
  public java.lang.String getAuthorId() {
    return this.authorId;
  }

  public Author setAuthorId(@org.apache.thrift.annotation.Nullable java.lang.String authorId) {
    this.authorId = authorId;
    return this;
  }

  public void unsetAuthorId() {
    this.authorId = null;
  }

  /** Returns true if field authorId is set (has been assigned a value) and false otherwise */
  public boolean isSetAuthorId() {
    return this.authorId != null;
  }

  public void setAuthorIdIsSet(boolean value) {
    if (!value) {
      this.authorId = null;
    }
  }

  @org.apache.thrift.annotation.Nullable
  public java.lang.String getFirstName() {
    return this.firstName;
  }

  public Author setFirstName(@org.apache.thrift.annotation.Nullable java.lang.String firstName) {
    this.firstName = firstName;
    return this;
  }

  public void unsetFirstName() {
    this.firstName = null;
  }

  /** Returns true if field firstName is set (has been assigned a value) and false otherwise */
  public boolean isSetFirstName() {
    return this.firstName != null;
  }

  public void setFirstNameIsSet(boolean value) {
    if (!value) {
      this.firstName = null;
    }
  }

  @org.apache.thrift.annotation.Nullable
  public java.lang.String getLastName() {
    return this.lastName;
  }

  public Author setLastName(@org.apache.thrift.annotation.Nullable java.lang.String lastName) {
    this.lastName = lastName;
    return this;
  }

  public void unsetLastName() {
    this.lastName = null;
  }

  /** Returns true if field lastName is set (has been assigned a value) and false otherwise */
  public boolean isSetLastName() {
    return this.lastName != null;
  }

  public void setLastNameIsSet(boolean value) {
    if (!value) {
      this.lastName = null;
    }
  }

  @org.apache.thrift.annotation.Nullable
  public java.lang.String getSpeciality() {
    return this.speciality;
  }

  public Author setSpeciality(@org.apache.thrift.annotation.Nullable java.lang.String speciality) {
    this.speciality = speciality;
    return this;
  }

  public void unsetSpeciality() {
    this.speciality = null;
  }

  /** Returns true if field speciality is set (has been assigned a value) and false otherwise */
  public boolean isSetSpeciality() {
    return this.speciality != null;
  }

  public void setSpecialityIsSet(boolean value) {
    if (!value) {
      this.speciality = null;
    }
  }

  public void setFieldValue(_Fields field, @org.apache.thrift.annotation.Nullable java.lang.Object value) {
    switch (field) {
    case AUTHOR_ID:
      if (value == null) {
        unsetAuthorId();
      } else {
        setAuthorId((java.lang.String)value);
      }
      break;

    case FIRST_NAME:
      if (value == null) {
        unsetFirstName();
      } else {
        setFirstName((java.lang.String)value);
      }
      break;

    case LAST_NAME:
      if (value == null) {
        unsetLastName();
      } else {
        setLastName((java.lang.String)value);
      }
      break;

    case SPECIALITY:
      if (value == null) {
        unsetSpeciality();
      } else {
        setSpeciality((java.lang.String)value);
      }
      break;

    }
  }

  @org.apache.thrift.annotation.Nullable
  public java.lang.Object getFieldValue(_Fields field) {
    switch (field) {
    case AUTHOR_ID:
      return getAuthorId();

    case FIRST_NAME:
      return getFirstName();

    case LAST_NAME:
      return getLastName();

    case SPECIALITY:
      return getSpeciality();

    }
    throw new java.lang.IllegalStateException();
  }

  /** Returns true if field corresponding to fieldID is set (has been assigned a value) and false otherwise */
  public boolean isSet(_Fields field) {
    if (field == null) {
      throw new java.lang.IllegalArgumentException();
    }

    switch (field) {
    case AUTHOR_ID:
      return isSetAuthorId();
    case FIRST_NAME:
      return isSetFirstName();
    case LAST_NAME:
      return isSetLastName();
    case SPECIALITY:
      return isSetSpeciality();
    }
    throw new java.lang.IllegalStateException();
  }

  @Override
  public boolean equals(java.lang.Object that) {
    if (that == null)
      return false;
    if (that instanceof Author)
      return this.equals((Author)that);
    return false;
  }

  public boolean equals(Author that) {
    if (that == null)
      return false;
    if (this == that)
      return true;

    boolean this_present_authorId = true && this.isSetAuthorId();
    boolean that_present_authorId = true && that.isSetAuthorId();
    if (this_present_authorId || that_present_authorId) {
      if (!(this_present_authorId && that_present_authorId))
        return false;
      if (!this.authorId.equals(that.authorId))
        return false;
    }

    boolean this_present_firstName = true && this.isSetFirstName();
    boolean that_present_firstName = true && that.isSetFirstName();
    if (this_present_firstName || that_present_firstName) {
      if (!(this_present_firstName && that_present_firstName))
        return false;
      if (!this.firstName.equals(that.firstName))
        return false;
    }

    boolean this_present_lastName = true && this.isSetLastName();
    boolean that_present_lastName = true && that.isSetLastName();
    if (this_present_lastName || that_present_lastName) {
      if (!(this_present_lastName && that_present_lastName))
        return false;
      if (!this.lastName.equals(that.lastName))
        return false;
    }

    boolean this_present_speciality = true && this.isSetSpeciality();
    boolean that_present_speciality = true && that.isSetSpeciality();
    if (this_present_speciality || that_present_speciality) {
      if (!(this_present_speciality && that_present_speciality))
        return false;
      if (!this.speciality.equals(that.speciality))
        return false;
    }

    return true;
  }

  @Override
  public int hashCode() {
    int hashCode = 1;

    hashCode = hashCode * 8191 + ((isSetAuthorId()) ? 131071 : 524287);
    if (isSetAuthorId())
      hashCode = hashCode * 8191 + authorId.hashCode();

    hashCode = hashCode * 8191 + ((isSetFirstName()) ? 131071 : 524287);
    if (isSetFirstName())
      hashCode = hashCode * 8191 + firstName.hashCode();

    hashCode = hashCode * 8191 + ((isSetLastName()) ? 131071 : 524287);
    if (isSetLastName())
      hashCode = hashCode * 8191 + lastName.hashCode();

    hashCode = hashCode * 8191 + ((isSetSpeciality()) ? 131071 : 524287);
    if (isSetSpeciality())
      hashCode = hashCode * 8191 + speciality.hashCode();

    return hashCode;
  }

  @Override
  public int compareTo(Author other) {
    if (!getClass().equals(other.getClass())) {
      return getClass().getName().compareTo(other.getClass().getName());
    }

    int lastComparison = 0;

    lastComparison = java.lang.Boolean.valueOf(isSetAuthorId()).compareTo(other.isSetAuthorId());
    if (lastComparison != 0) {
      return lastComparison;
    }
    if (isSetAuthorId()) {
      lastComparison = org.apache.thrift.TBaseHelper.compareTo(this.authorId, other.authorId);
      if (lastComparison != 0) {
        return lastComparison;
      }
    }
    lastComparison = java.lang.Boolean.valueOf(isSetFirstName()).compareTo(other.isSetFirstName());
    if (lastComparison != 0) {
      return lastComparison;
    }
    if (isSetFirstName()) {
      lastComparison = org.apache.thrift.TBaseHelper.compareTo(this.firstName, other.firstName);
      if (lastComparison != 0) {
        return lastComparison;
      }
    }
    lastComparison = java.lang.Boolean.valueOf(isSetLastName()).compareTo(other.isSetLastName());
    if (lastComparison != 0) {
      return lastComparison;
    }
    if (isSetLastName()) {
      lastComparison = org.apache.thrift.TBaseHelper.compareTo(this.lastName, other.lastName);
      if (lastComparison != 0) {
        return lastComparison;
      }
    }
    lastComparison = java.lang.Boolean.valueOf(isSetSpeciality()).compareTo(other.isSetSpeciality());
    if (lastComparison != 0) {
      return lastComparison;
    }
    if (isSetSpeciality()) {
      lastComparison = org.apache.thrift.TBaseHelper.compareTo(this.speciality, other.speciality);
      if (lastComparison != 0) {
        return lastComparison;
      }
    }
    return 0;
  }

  @org.apache.thrift.annotation.Nullable
  public _Fields fieldForId(int fieldId) {
    return _Fields.findByThriftId(fieldId);
  }

  public void read(org.apache.thrift.protocol.TProtocol iprot) throws org.apache.thrift.TException {
    scheme(iprot).read(iprot, this);
  }

  public void write(org.apache.thrift.protocol.TProtocol oprot) throws org.apache.thrift.TException {
    scheme(oprot).write(oprot, this);
  }

  @Override
  public java.lang.String toString() {
    java.lang.StringBuilder sb = new java.lang.StringBuilder("Author(");
    boolean first = true;

    sb.append("authorId:");
    if (this.authorId == null) {
      sb.append("null");
    } else {
      sb.append(this.authorId);
    }
    first = false;
    if (!first) sb.append(", ");
    sb.append("firstName:");
    if (this.firstName == null) {
      sb.append("null");
    } else {
      sb.append(this.firstName);
    }
    first = false;
    if (!first) sb.append(", ");
    sb.append("lastName:");
    if (this.lastName == null) {
      sb.append("null");
    } else {
      sb.append(this.lastName);
    }
    first = false;
    if (!first) sb.append(", ");
    sb.append("speciality:");
    if (this.speciality == null) {
      sb.append("null");
    } else {
      sb.append(this.speciality);
    }
    first = false;
    sb.append(")");
    return sb.toString();
  }

  public void validate() throws org.apache.thrift.TException {
    // check for required fields
    // check for sub-struct validity
  }

  private void writeObject(java.io.ObjectOutputStream out) throws java.io.IOException {
    try {
      write(new org.apache.thrift.protocol.TCompactProtocol(new org.apache.thrift.transport.TIOStreamTransport(out)));
    } catch (org.apache.thrift.TException te) {
      throw new java.io.IOException(te);
    }
  }

  private void readObject(java.io.ObjectInputStream in) throws java.io.IOException, java.lang.ClassNotFoundException {
    try {
      read(new org.apache.thrift.protocol.TCompactProtocol(new org.apache.thrift.transport.TIOStreamTransport(in)));
    } catch (org.apache.thrift.TException te) {
      throw new java.io.IOException(te);
    }
  }

  private static class AuthorStandardSchemeFactory implements org.apache.thrift.scheme.SchemeFactory {
    public AuthorStandardScheme getScheme() {
      return new AuthorStandardScheme();
    }
  }

  private static class AuthorStandardScheme extends org.apache.thrift.scheme.StandardScheme<Author> {

    public void read(org.apache.thrift.protocol.TProtocol iprot, Author struct) throws org.apache.thrift.TException {
      org.apache.thrift.protocol.TField schemeField;
      iprot.readStructBegin();
      while (true)
      {
        schemeField = iprot.readFieldBegin();
        if (schemeField.type == org.apache.thrift.protocol.TType.STOP) { 
          break;
        }
        switch (schemeField.id) {
          case 1: // AUTHOR_ID
            if (schemeField.type == org.apache.thrift.protocol.TType.STRING) {
              struct.authorId = iprot.readString();
              struct.setAuthorIdIsSet(true);
            } else { 
              org.apache.thrift.protocol.TProtocolUtil.skip(iprot, schemeField.type);
            }
            break;
          case 2: // FIRST_NAME
            if (schemeField.type == org.apache.thrift.protocol.TType.STRING) {
              struct.firstName = iprot.readString();
              struct.setFirstNameIsSet(true);
            } else { 
              org.apache.thrift.protocol.TProtocolUtil.skip(iprot, schemeField.type);
            }
            break;
          case 3: // LAST_NAME
            if (schemeField.type == org.apache.thrift.protocol.TType.STRING) {
              struct.lastName = iprot.readString();
              struct.setLastNameIsSet(true);
            } else { 
              org.apache.thrift.protocol.TProtocolUtil.skip(iprot, schemeField.type);
            }
            break;
          case 4: // SPECIALITY
            if (schemeField.type == org.apache.thrift.protocol.TType.STRING) {
              struct.speciality = iprot.readString();
              struct.setSpecialityIsSet(true);
            } else { 
              org.apache.thrift.protocol.TProtocolUtil.skip(iprot, schemeField.type);
            }
            break;
          default:
            org.apache.thrift.protocol.TProtocolUtil.skip(iprot, schemeField.type);
        }
        iprot.readFieldEnd();
      }
      iprot.readStructEnd();

      // check for required fields of primitive type, which can't be checked in the validate method
      struct.validate();
    }

    public void write(org.apache.thrift.protocol.TProtocol oprot, Author struct) throws org.apache.thrift.TException {
      struct.validate();

      oprot.writeStructBegin(STRUCT_DESC);
      if (struct.authorId != null) {
        oprot.writeFieldBegin(AUTHOR_ID_FIELD_DESC);
        oprot.writeString(struct.authorId);
        oprot.writeFieldEnd();
      }
      if (struct.firstName != null) {
        oprot.writeFieldBegin(FIRST_NAME_FIELD_DESC);
        oprot.writeString(struct.firstName);
        oprot.writeFieldEnd();
      }
      if (struct.lastName != null) {
        oprot.writeFieldBegin(LAST_NAME_FIELD_DESC);
        oprot.writeString(struct.lastName);
        oprot.writeFieldEnd();
      }
      if (struct.speciality != null) {
        oprot.writeFieldBegin(SPECIALITY_FIELD_DESC);
        oprot.writeString(struct.speciality);
        oprot.writeFieldEnd();
      }
      oprot.writeFieldStop();
      oprot.writeStructEnd();
    }

  }

  private static class AuthorTupleSchemeFactory implements org.apache.thrift.scheme.SchemeFactory {
    public AuthorTupleScheme getScheme() {
      return new AuthorTupleScheme();
    }
  }

  private static class AuthorTupleScheme extends org.apache.thrift.scheme.TupleScheme<Author> {

    @Override
    public void write(org.apache.thrift.protocol.TProtocol prot, Author struct) throws org.apache.thrift.TException {
      org.apache.thrift.protocol.TTupleProtocol oprot = (org.apache.thrift.protocol.TTupleProtocol) prot;
      java.util.BitSet optionals = new java.util.BitSet();
      if (struct.isSetAuthorId()) {
        optionals.set(0);
      }
      if (struct.isSetFirstName()) {
        optionals.set(1);
      }
      if (struct.isSetLastName()) {
        optionals.set(2);
      }
      if (struct.isSetSpeciality()) {
        optionals.set(3);
      }
      oprot.writeBitSet(optionals, 4);
      if (struct.isSetAuthorId()) {
        oprot.writeString(struct.authorId);
      }
      if (struct.isSetFirstName()) {
        oprot.writeString(struct.firstName);
      }
      if (struct.isSetLastName()) {
        oprot.writeString(struct.lastName);
      }
      if (struct.isSetSpeciality()) {
        oprot.writeString(struct.speciality);
      }
    }

    @Override
    public void read(org.apache.thrift.protocol.TProtocol prot, Author struct) throws org.apache.thrift.TException {
      org.apache.thrift.protocol.TTupleProtocol iprot = (org.apache.thrift.protocol.TTupleProtocol) prot;
      java.util.BitSet incoming = iprot.readBitSet(4);
      if (incoming.get(0)) {
        struct.authorId = iprot.readString();
        struct.setAuthorIdIsSet(true);
      }
      if (incoming.get(1)) {
        struct.firstName = iprot.readString();
        struct.setFirstNameIsSet(true);
      }
      if (incoming.get(2)) {
        struct.lastName = iprot.readString();
        struct.setLastNameIsSet(true);
      }
      if (incoming.get(3)) {
        struct.speciality = iprot.readString();
        struct.setSpecialityIsSet(true);
      }
    }
  }

  private static <S extends org.apache.thrift.scheme.IScheme> S scheme(org.apache.thrift.protocol.TProtocol proto) {
    return (org.apache.thrift.scheme.StandardScheme.class.equals(proto.getScheme()) ? STANDARD_SCHEME_FACTORY : TUPLE_SCHEME_FACTORY).getScheme();
  }
}

