import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:swifty_companion/dtos/search_user_dto.dart' as search_dto;
import 'package:swifty_companion/dtos/user_dto.dart' as user_dto;
import 'package:swifty_companion/entities/search_user.dart';
import 'package:swifty_companion/entities/user_data.dart';
import 'package:swifty_companion/entities/user_image.dart';
import 'package:swifty_companion/repository/school_repository.dart';
import 'package:swifty_companion/service/school_service_facade.dart';
import 'package:swifty_companion/logging_setup.dart';

class MockSchoolService extends Mock implements SchoolServiceFacade {}

void main() {
  late SchoolRepository schoolRepository;
  late MockSchoolService mockSchoolService;

  setUp(() {
    mockSchoolService = MockSchoolService();
    schoolRepository = SchoolRepository(schoolService: mockSchoolService);
  });

  setUpAll(() {
    setupLogging();
  });

  group('SchoolRepository', () {
    group('loginWith42', () {
      test('calls loginWith42() from SchoolServiceFacade', () async {
        when(() => mockSchoolService.loginWith42())
            .thenAnswer((_) async => Future.value());

        await schoolRepository.loginWith42();

        verify(() => mockSchoolService.loginWith42());
      });

      test('thows corrrect exception', () async {
        when(() => mockSchoolService.loginWith42()).thenThrow(Exception());

        expect(schoolRepository.loginWith42(), throwsException);
      });
    });

    group('getUserData', () {
      test('throws exception if school service throws error', () async {
        when(() => mockSchoolService.getUser("1")).thenThrow(TypeError());

        expect(schoolRepository.getUserData("1"), throwsException);
      });

      // Took me 1 hour to write this test
      test('returns correct user profile', () async {
        final expectedProfile = ProfileEntity(
            login: "testLogin",
            firstName: "testFirstName",
            lastName: "testLastName",
            email: "testEmail",
            level: Level(level: 9, maxLevel: 20),
            location: "testLocation",
            profilePicture: const UserImage(url: "testUrl"));

        when(() => mockSchoolService.getUser("1"))
            .thenAnswer((_) async => Future.value(user_dto.UserDto(
                  login: expectedProfile.login,
                  firstName: expectedProfile.firstName,
                  lastName: expectedProfile.lastName,
                  email: expectedProfile.email,
                  cursusUsers: [
                    user_dto.CursusUser(
                        level: Random().nextDouble(), grade: null),
                    user_dto.CursusUser(
                        level: Random().nextDouble(), grade: "Empty"),
                    user_dto.CursusUser(
                        level: expectedProfile.level.level, grade: "Member"),
                  ],
                  location: expectedProfile.location,
                  url: expectedProfile.profilePicture.url,
                )));

        final result = await schoolRepository.getUserData("1");
        final profile = result.profile;

        expect(profile.login, expectedProfile.login);
        expect(profile.firstName, expectedProfile.firstName);
        expect(profile.lastName, expectedProfile.lastName);
        expect(profile.email, expectedProfile.email);
        expect(profile.level.level, expectedProfile.level.level);
        expect(profile.location, expectedProfile.location);
        expect(profile.profilePicture.url, expectedProfile.profilePicture.url);
      });

      // Took me 1 hour to write this test
      test('returns correct user skills', () async {
        final expectedSkills = [
          SkillEntity(
              level: Level(level: 4.68, maxLevel: 20), name: "TesWeb", id: 1),
          SkillEntity(
              level: Level(level: 7.68, maxLevel: 20), name: "TestRigor", id: 4)
        ];

        when(() => mockSchoolService.getUser("1")).thenAnswer(
            (_) async => Future.value(user_dto.UserDto(cursusUsers: [
                  user_dto.CursusUser(grade: "AntiMember", skills: [
                    user_dto.Skill(id: 2, name: "AntiTest1", level: 5.68),
                    user_dto.Skill(id: 3, name: "AntiTest2", level: 6.68),
                  ]),
                  user_dto.CursusUser(grade: "Member", skills: [
                    user_dto.Skill(id: 1, name: "TesWeb", level: 4.68),
                    user_dto.Skill(id: 4, name: "TestRigor", level: 7.68)
                  ]),
                ])));

        final result = await schoolRepository.getUserData("1");
        final skill = result.skills[0];

        expect(result.skills.length, equals(2));
        expect(skill.id, expectedSkills[0].id);
        expect(skill.name, expectedSkills[0].name);
        expect(skill.level.level, expectedSkills[0].level.level);
        expect(skill.level.toPercentage(), 23.4);
      });
    });

    group('searchUsers', () {
      // Took me 29 minutes to write this test
      test('searchUsers returns correct values', () async {
        final expectedSearchUsers = [
          SearchUser(
              id: "1",
              login: "sdukic",
              profilePicture: const UserImage(
                  url:
                      "https://cdn.intra.42.fr/users/9f4f94354e51110de5b62c3d91d99303/sdukic.jpg",
                  versions: ImageVersions(
                      micro:
                          "https://cdn.intra.42.fr/users/871fb28b3af4de2388bda8839376c33a/micro_sdukic.jpg",
                      small:
                          "https://cdn.intra.42.fr/users/88dfc460d9e409f0eb10b3469a3dc098/small_sdukic.jpg",
                      medium:
                          "https://cdn.intra.42.fr/users/490952a161327721163774570f5fa51d/medium_sdukic.jpg",
                      large:
                          "https://cdn.intra.42.fr/users/b5992e8c60c9dcc9eb02f3d57155bf85/large_sdukic.jpg")))
        ];

        when(() => mockSchoolService.searchUsers(any()))
            .thenAnswer((_) async => Future.value([
                  search_dto.SearchUserDto(
                      login: "sdukic",
                      image: search_dto.Image(
                          link:
                              "https://cdn.intra.42.fr/users/9f4f94354e51110de5b62c3d91d99303/sdukic.jpg",
                          versions: search_dto.Versions(
                              micro:
                                  "https://cdn.intra.42.fr/users/871fb28b3af4de2388bda8839376c33a/micro_sdukic.jpg",
                              small:
                                  "https://cdn.intra.42.fr/users/88dfc460d9e409f0eb10b3469a3dc098/small_sdukic.jpg",
                              medium:
                                  "https://cdn.intra.42.fr/users/490952a161327721163774570f5fa51d/medium_sdukic.jpg",
                              large:
                                  "https://cdn.intra.42.fr/users/b5992e8c60c9dcc9eb02f3d57155bf85/large_sdukic.jpg")))
                ]));

        final result = await schoolRepository.searchUsers('sdukic');

        final expectedSearchUser = expectedSearchUsers[0];

        expect(result[0].login, expectedSearchUser.login);
        expect(result[0].profilePicture.url,
            expectedSearchUser.profilePicture.url);
        expect(result[0].profilePicture.versions?.micro,
            expectedSearchUser.profilePicture.versions?.micro);
        expect(result[0].profilePicture.versions?.small,
            expectedSearchUser.profilePicture.versions?.small);
        expect(result[0].profilePicture.versions?.medium,
            expectedSearchUser.profilePicture.versions?.medium);
        expect(result[0].profilePicture.versions?.large,
            expectedSearchUser.profilePicture.versions?.large);
      });

      test('searchUsers throws exception if school service throws error',
          () async {
        when(() => mockSchoolService.searchUsers(any())).thenThrow(TypeError());

        expect(schoolRepository.searchUsers("sdukic"), throwsException);
      });
    });

    group('searchUsersLocally', () {
      test('returns correct search result', () async {
        final file = File('test/data/all_search_users.json');

        when(() => mockSchoolService.getAllSearchUsers()).thenAnswer(
            (_) async => Future.value(
                search_dto.searchUserDtoFromJson(await file.readAsString())));

        final searchUsers =
            await schoolRepository.searchUsersLocally('yulpark');

        final searchUsersMultiple =
            await schoolRepository.searchUsersLocally('dn');

        expect(searchUsers[0].login, 'yulpark');
        expect(searchUsersMultiple.length, 2);
        expect(searchUsersMultiple.map((user) => user.login).toList(),
            containsAll(['dnixdorf', 'dna']));
      });
    });
  });
}
