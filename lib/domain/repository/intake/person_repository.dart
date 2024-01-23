import 'package:hive_flutter/adapters.dart';

import '../../../model/intake/person_dto.dart';
import '../../db_model_hive/intake/person.model.dart';


const String personBox = 'personDtoBox';

class PersonRepository {
  PersonRepository._constructor();

  static final PersonRepository _instance = PersonRepository._constructor();

  factory PersonRepository() => _instance;

  late Box<PersonModel> _personsBox;

  Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter<PersonModel>(PersonModelAdapter());
    _personsBox = await Hive.openBox<PersonModel>(personBox);
  }

  Future<void> savePersonItems(List<PersonDto> personsDto, int? userId) async {
    for (var personDto in personsDto) {
      await _personsBox.put(
          personDto.personId,
          (PersonModel(
              personId: personDto.personId,
              firstName: personDto.firstName,
              lastName: personDto.lastName,
              knownAs: personDto.knownAs,
              identificationTypeId: personDto.identificationTypeId,
              identificationNumber: personDto.identificationNumber,
              isPivaValidated: personDto.isPivaValidated,
              pivaTransactionId: personDto.pivaTransactionId,
              dateOfBirth: personDto.dateOfBirth,
              age: personDto.age,
              isEstimatedAge: personDto.isEstimatedAge,
              sexualOrientationId: personDto.sexualOrientationId,
              languageId: personDto.languageId,
              genderId: personDto.genderId,
              maritalStatusId: personDto.maritalStatusId,
              preferredContactTypeId: personDto.preferredContactTypeId,
              religionId: personDto.religionId,
              phoneNumber: personDto.phoneNumber,
              mobilePhoneNumber: personDto.mobilePhoneNumber,
              emailAddress: personDto.emailAddress,
              populationGroupId: personDto.populationGroupId,
              nationalityId: personDto.nationalityId,
              disabilityTypeId: personDto.disabilityTypeId,
              citizenshipId: personDto.citizenshipId,
              dateLastModified: personDto.dateLastModified,
              modifiedBy: personDto.modifiedBy,
              createdBy: personDto.createdBy,
              userId: userId,

              )));
    }
  }

  Future<void> savePerson(PersonDto personDto, int? userId) async {
    await _personsBox.put(
        personDto.personId,
        PersonModel(
            personId: personDto.personId,
            firstName: personDto.firstName,
            lastName: personDto.lastName,
            knownAs: personDto.knownAs,
            identificationTypeId: personDto.identificationTypeId,
            identificationNumber: personDto.identificationNumber,
            isPivaValidated: personDto.isPivaValidated,
            pivaTransactionId: personDto.pivaTransactionId,
            dateOfBirth: personDto.dateOfBirth,
            age: personDto.age,
            isEstimatedAge: personDto.isEstimatedAge,
            sexualOrientationId: personDto.sexualOrientationId,
            languageId: personDto.languageId,
            genderId: personDto.genderId,
            maritalStatusId: personDto.maritalStatusId,
            preferredContactTypeId: personDto.preferredContactTypeId,
            religionId: personDto.religionId,
            phoneNumber: personDto.phoneNumber,
            mobilePhoneNumber: personDto.mobilePhoneNumber,
            emailAddress: personDto.emailAddress,
            populationGroupId: personDto.populationGroupId,
            nationalityId: personDto.nationalityId,
            disabilityTypeId: personDto.disabilityTypeId,
            citizenshipId: personDto.citizenshipId,
            dateLastModified: personDto.dateLastModified,
            modifiedBy: personDto.modifiedBy,
            createdBy: personDto.createdBy,
            userId: userId,
         ));
  }

  Future<void> savePersonNewDbRecord(
      PersonDto personDto, int? userId, int? responsePersonId) async {
    await _personsBox.put(
        responsePersonId,
        PersonModel(
            personId: responsePersonId,
            firstName: personDto.firstName,
            lastName: personDto.lastName,
            knownAs: personDto.knownAs,
            identificationTypeId: personDto.identificationTypeId,
            identificationNumber: personDto.identificationNumber,
            isPivaValidated: personDto.isPivaValidated,
            pivaTransactionId: personDto.pivaTransactionId,
            dateOfBirth: personDto.dateOfBirth,
            age: personDto.age,
            isEstimatedAge: personDto.isEstimatedAge,
            sexualOrientationId: personDto.sexualOrientationId,
            languageId: personDto.languageId,
            genderId: personDto.genderId,
            maritalStatusId: personDto.maritalStatusId,
            preferredContactTypeId: personDto.preferredContactTypeId,
            religionId: personDto.religionId,
            phoneNumber: personDto.phoneNumber,
            mobilePhoneNumber: personDto.mobilePhoneNumber,
            emailAddress: personDto.emailAddress,
            populationGroupId: personDto.populationGroupId,
            nationalityId: personDto.nationalityId,
            disabilityTypeId: personDto.disabilityTypeId,
            citizenshipId: personDto.citizenshipId,
            dateLastModified: personDto.dateLastModified,
            modifiedBy: personDto.modifiedBy,
            createdBy: personDto.createdBy,
            userId: userId,
        ));
  }

  List<PersonDto> getAllPersons() {
    return _personsBox.values.map(personFromDb).toList();
  }

  PersonDto? getPersonById(int id) {
    final bookDb = _personsBox.get(id);
    if (bookDb != null) {
      return personFromDb(bookDb);
    }
    return null;
  }

  Future<void> deletePerson(int id) async {
    await _personsBox.delete(id);
  }

  Future<void> deleteAllPersons() async {
    await _personsBox.clear();
  }

  PersonDto personFromDb(PersonModel personModel) => PersonDto(
      personId: personModel.personId,
      firstName: personModel.firstName,
      lastName: personModel.lastName,
      knownAs: personModel.knownAs,
      identificationTypeId: personModel.identificationTypeId,
      identificationNumber: personModel.identificationNumber,
      isPivaValidated: personModel.isPivaValidated,
      pivaTransactionId: personModel.pivaTransactionId,
      dateOfBirth: personModel.dateOfBirth,
      age: personModel.age,
      isEstimatedAge: personModel.isEstimatedAge,
      sexualOrientationId: personModel.sexualOrientationId,
      languageId: personModel.languageId,
      genderId: personModel.genderId,
      maritalStatusId: personModel.maritalStatusId,
      preferredContactTypeId: personModel.preferredContactTypeId,
      religionId: personModel.religionId,
      phoneNumber: personModel.phoneNumber,
      mobilePhoneNumber: personModel.mobilePhoneNumber,
      emailAddress: personModel.emailAddress,
      populationGroupId: personModel.populationGroupId,
      nationalityId: personModel.nationalityId,
      disabilityTypeId: personModel.disabilityTypeId,
      citizenshipId: personModel.citizenshipId,
      dateLastModified: personModel.dateLastModified,
      modifiedBy: personModel.modifiedBy,
      createdBy: personModel.createdBy,
    );

  PersonModel personToDb(PersonDto? personDto) => PersonModel(
      personId: personDto?.personId,
      firstName: personDto?.firstName,
      lastName: personDto?.lastName,
      knownAs: personDto?.knownAs,
      identificationTypeId: personDto?.identificationTypeId,
      identificationNumber: personDto?.identificationNumber,
      isPivaValidated: personDto?.isPivaValidated,
      pivaTransactionId: personDto?.pivaTransactionId,
      dateOfBirth: personDto?.dateOfBirth,
      age: personDto?.age,
      isEstimatedAge: personDto?.isEstimatedAge,
      sexualOrientationId: personDto?.sexualOrientationId,
      languageId: personDto?.languageId,
      genderId: personDto?.genderId,
      maritalStatusId: personDto?.maritalStatusId,
      preferredContactTypeId: personDto?.preferredContactTypeId,
      religionId: personDto?.religionId,
      phoneNumber: personDto?.phoneNumber,
      mobilePhoneNumber: personDto?.mobilePhoneNumber,
      emailAddress: personDto?.emailAddress,
      populationGroupId: personDto?.populationGroupId,
      nationalityId: personDto?.nationalityId,
      disabilityTypeId: personDto?.disabilityTypeId,
      citizenshipId: personDto?.citizenshipId,
      dateLastModified: personDto?.dateLastModified,
      modifiedBy: personDto?.modifiedBy,
      createdBy: personDto?.createdBy,
     );
}
