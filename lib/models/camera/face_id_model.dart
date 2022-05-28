import 'dart:convert';

FaceIdModel faceIdModelFromJson(String str) => FaceIdModel.fromJson(json.decode(str));

class FaceIdModel {
    FaceIdModel({
        this.responseId,
        this.resultCode,
        this.resultNote,
        this.profile,
    });

    String? responseId;
    int? resultCode;
    String? resultNote;
    Profile? profile;

    factory FaceIdModel.fromJson(Map<String, dynamic> json) => FaceIdModel(
        responseId: json["response_id"],
        resultCode: json["result_code"],
        resultNote: json["result_note"],
        profile: Profile.fromJson(json["profile"]),
    );

   
}

class Profile {
    Profile({
        this.commonData,
        this.docData,
        this.contacts,
        this.address,
        this.authenticationMethod,
    });

    CommonData? commonData;
    DocData? docData;
    Contacts? contacts;
    Address? address;
    String? authenticationMethod;

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        commonData: CommonData.fromJson(json["common_data"]),
        docData: DocData.fromJson(json["doc_data"]),
        contacts: Contacts.fromJson(json["contacts"]),
        address: Address.fromJson(json["address"]),
        authenticationMethod: json["authentication_method"],
    );

   
}

class Address {
    Address({
        this.permanentAddress,
        this.temporaryAddress,
        this.permanentRegistration,
        this.temporaryRegistration,
    });

    String? permanentAddress;
    String? temporaryAddress;
    Registration? permanentRegistration;
    Registration? temporaryRegistration;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        permanentAddress: json["permanent_address"],
        temporaryAddress: json["temporary_address"],
        permanentRegistration: Registration.fromJson(json["permanent_registration"]),
        temporaryRegistration: Registration.fromJson(json["temporary_registration"]),
    );

 
}

class Registration {
    Registration({
        this.region,
        this.address,
        this.country,
        this.cadastre,
        this.district,
        this.regionId,
        this.countryId,
        this.districtId,
        this.registrationDate,
        this.dateFrom,
        this.dateTill,
    });

    String? region;
    String? address;
    String? country;
    String? cadastre;
    String? district;
    String? regionId;
    String? countryId;
    String? districtId;
    String? registrationDate;
    String? dateFrom;
    String? dateTill;

    factory Registration.fromJson(Map<String, dynamic> json) => Registration(
        region: json["region"],
        address: json["address"],
        country: json["country"],
        cadastre: json["cadastre"],
        district: json["district"],
        regionId: json["region_id"],
        countryId: json["country_id"],
        districtId: json["district_id"],
        registrationDate: json["registration_date"],
        dateFrom: json["date_from"],
        dateTill: json["date_till"],
    );


}

class CommonData {
    CommonData({
        this.firstName,
        this.middleName,
        this.lastName,
        this.pinfl,
        this.inn,
        this.gender,
        this.birthPlace,
        this.birthCountry,
        this.birthCountryId,
        this.birthDate,
        this.nationality,
        this.nationalityId,
        this.citizenship,
        this.citizenshipId,
        this.sdkHash,
        this.lastUpdatePassData,
        this.lastUpdateInn,
        this.lastUpdateAddress,
        this.fullName,
        this.lastUpdatePassDataValue,
        this.birthDateValue,
    });

    String? firstName;
    String? middleName;
    String? lastName;
    String? pinfl;
    String? inn;
    String? gender;
    String? birthPlace;
    String? birthCountry;
    String? birthCountryId;
    String? birthDate;
    String? nationality;
    String? nationalityId;
    String? citizenship;
    String? citizenshipId;
    String? sdkHash;
    String? lastUpdatePassData;
    String? lastUpdateInn;
    String? lastUpdateAddress;
    String? fullName;
    String? lastUpdatePassDataValue;
    DateTime? birthDateValue;

    factory CommonData.fromJson(Map<String, dynamic> json) => CommonData(
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        pinfl: json["pinfl"],
        inn: json["inn"],
        gender: json["gender"],
        birthPlace: json["birth_place"],
        birthCountry: json["birth_country"],
        birthCountryId: json["birth_country_id"],
        birthDate: json["birth_date"],
        nationality: json["nationality"],
        nationalityId: json["nationality_id"],
        citizenship: json["citizenship"],
        citizenshipId: json["citizenship_id"],
        sdkHash: json["sdk_hash"],
        lastUpdatePassData: json["last_update_pass_data"],
        lastUpdateInn: json["last_update_inn"],
        lastUpdateAddress: json["last_update_address"],
        fullName: json["full_name"],
        lastUpdatePassDataValue: json["last_update_pass_data_value"],
        birthDateValue: DateTime.parse(json["birth_date_value"]),
    );

  
}

class Contacts {
    Contacts({
        this.phone,
        this.email,
    });

    String? phone;
    String? email;

    factory Contacts.fromJson(Map<String, dynamic> json) => Contacts(
        phone: json["phone"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "phone": phone,
        "email": email,
    };
}

class DocData {
    DocData({
        this.passData,
        this.issuedBy,
        this.issuedById,
        this.issuedDate,
        this.expiryDate,
        this.issuedDateValue,
        this.expiryDateValue,
        this.expiryDateDatetime,
        this.issuedDateDatetime,
    });

    String? passData;
    String? issuedBy;
    String? issuedById;
    String? issuedDate;
    String? expiryDate;
    String? issuedDateValue;
    String? expiryDateValue;
    DateTime? expiryDateDatetime;
    DateTime? issuedDateDatetime;

    factory DocData.fromJson(Map<String, dynamic> json) => DocData(
        passData: json["pass_data"],
        issuedBy: json["issued_by"],
        issuedById: json["issued_by_id"],
        issuedDate: json["issued_date"],
        expiryDate: json["expiry_date"],
        issuedDateValue: json["issued_date_value"],
        expiryDateValue: json["expiry_date_value"],
        expiryDateDatetime: DateTime.parse(json["expiry_date_datetime"]),
        issuedDateDatetime: DateTime.parse(json["issued_date_datetime"]),
    );

 
}
