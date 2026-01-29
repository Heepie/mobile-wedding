/// 결혼식 초대장 설정 파일
///
/// 이 파일 하나만 수정하면 나만의 모바일 청첩장을 만들 수 있습니다.
/// 아래 항목들은 앱 화면에 나타나는 순서대로 정렬되어 있습니다.
class WeddingConfig {
  WeddingConfig._();

  // ╔══════════════════════════════════════════════════════════╗
  // ║  0. 공통 설정                                             ║
  // ║  앱 이름, 프로필 사진, 대화창 발신자 이름 등                    ║
  // ╚══════════════════════════════════════════════════════════╝

  /// 브라우저 탭에 표시되는 앱 제목
  static const String appTitle = '철수\u{2764}\uFE0F영희 결혼해요!';

  /// 엔딩 애니메이션에 사용되는 이름 글자 목록
  static const List<String> nameCharacters = ['철', '수', '영', '희'];

  /// 대화창 상단에 표시되는 발신자 이름
  static const String senderDisplayName = '철수, 영희';

  /// 대화창 프로필 사진 (원형)
  static const String profileImage = 'assets/images/circle_profile.jpg';

  /// 프로필 사진 탭 시 보여줄 큰 사진
  static const String profileTapImage = 'assets/images/main/wedding/wedding10.jpg';

  /// 타이핑 중 표시 GIF
  static const String typingGif = 'assets/images/typing.gif';

  // ╔══════════════════════════════════════════════════════════╗
  // ║  1. 첫 화면 (Announcement)                               ║
  // ║  앱 실행 직후 보이는 메인 이미지 + 제목 + 날짜                 ║
  // ╚══════════════════════════════════════════════════════════╝

  /// 신랑 이름
  static const String groomName = '철수';

  /// 신부 이름
  static const String brideName = '영희';

  /// 첫 화면 메인 이미지
  static const String introImage = 'assets/images/main/intro.jpg';

  /// 첫 화면 날짜/장소 한 줄 요약
  static const String announcementDateVenue = '2026년 1월 24일 11시, 보테가마지오';

  // ╔══════════════════════════════════════════════════════════╗
  // ║  2. 인사 + 웨딩 사진 앨범                                  ║
  // ║  "안녕하세요! 결혼식에 초대합니다" + 사진 캐러셀               ║
  // ╚══════════════════════════════════════════════════════════╝

  /// 첫 인사 메시지
  static const String inviteGreeting =
      '안녕하세요! 철수, 영희 결혼식에 초대합니다 :)';

  /// 웨딩 사진 (로컬)
  static const List<String> localWeddingImages = [
    'assets/images/main/wedding/wedding1.jpeg',
    'assets/images/main/wedding/wedding2.jpg',
    'assets/images/main/wedding/wedding10.jpg',
    'assets/images/main/wedding/wedding11.jpg',
  ];

  /// 웨딩 사진 (원격 URL)
  static const List<String> remoteWeddingImages = [
    'https://raw.githubusercontent.com/Heepie/mobile-wedding/master/sample/wedding/wedding_3.jpg',
    'https://raw.githubusercontent.com/Heepie/mobile-wedding/master/sample/wedding/wedding_4.jpg',
    'https://raw.githubusercontent.com/Heepie/mobile-wedding/master/sample/wedding/wedding_5.jpg',
    'https://raw.githubusercontent.com/Heepie/mobile-wedding/master/sample/wedding/wedding_6.jpg',
    'https://raw.githubusercontent.com/Heepie/mobile-wedding/master/sample/wedding/wedding_7.jpg',
    'https://raw.githubusercontent.com/Heepie/mobile-wedding/master/sample/wedding/wedding_8.jpg',
    'https://raw.githubusercontent.com/Heepie/mobile-wedding/master/sample/wedding/wedding_9.jpg',
    'https://raw.githubusercontent.com/Heepie/mobile-wedding/master/sample/wedding/wedding_10.jpg',
  ];

  // ╔══════════════════════════════════════════════════════════╗
  // ║  3. 날짜/장소 안내                                        ║
  // ║  "언제 어디서?" → 날짜/장소 답변 + 지도                      ║
  // ╚══════════════════════════════════════════════════════════╝

  /// 상대방 질문: 날짜/장소
  static const String questionWhen = '와! 축하드려요! 언제, 어디서 하나요?';

  /// 날짜/장소 답변 메시지
  static const String dateVenueMessage =
      '2026년 1월 24일(토) 11시,\n서울숲2길 32-14 갤러리아포레 G층\n\'보테가마지오\'에요! \u{1F495}\n여기 지도 보내드릴께요!';

  /// 지도 이미지
  static const String mapImage = 'assets/images/main/map.jpeg';

  /// 네이버 지도 링크
  static const String naverMapLink =
      'https://m.place.naver.com/place/31494641/location?subtab=location';

  /// 카카오 지도 링크
  static const String kakaoMapLink = 'https://kko.to/cgz6iQNuaF';

  // ╔══════════════════════════════════════════════════════════╗
  // ║  4. 축의금 안내                                           ║
  // ║  "마음 전하고 싶으면?" → 계좌번호                            ║
  // ╚══════════════════════════════════════════════════════════╝

  /// 상대방 질문: 축의금
  static const String questionAccount = '마음만 전하고 싶으면 어떻게 하나요?';

  /// 축의금 안내 메시지
  static const String accountGuideMessage =
      '여기로 보내주시면 돼요!\n감사인사를 전하고 싶어서요, 꼭 연락주세요!';

  /// 계좌 복사 안내 문구
  static const String copyableTitle = '버튼을 누르면 복사 돼요.';

  /// 신랑측 라벨
  static const String groomSideLabel = '신랑';

  /// 신랑측 계좌 목록
  static const List<String> groomAccounts = [
    '신한 XXY-ZYX-XYZXYZ (김OO)',
    '국민 XYZXYZ-YZ-XXYZYZ (이OO)',
    '국민 ZXYXYZ-XY-YZYXYZ (박OO)',
  ];

  /// 신부측 라벨
  static const String brideSideLabel = '신부';

  /// 신부측 계좌 목록
  static const List<String> brideAccounts = [
    '카카오 XYZY-YX-ZYXYZXZ (정OO)',
    '국민 YZXZXY-XZ-XYZXZY (최OO)',
    '카카오 ZXYZ-ZY-XZYXYZX (강OO)',
  ];

  // ╔══════════════════════════════════════════════════════════╗
  // ║  5. 신랑 성장과정                                         ║
  // ║  "더 궁금해요!" → 신랑 사진 + 소개                          ║
  // ╚══════════════════════════════════════════════════════════╝

  /// 상대방 질문: 성장과정
  static const String questionHistory = '철수 영희에 대해 더 궁금해요!';

  /// 성장과정 소개 멘트
  static const String historyIntro = '성장과정을 함께 보시죠! :)';

  /// 신랑 성장 사진 (로컬)
  static const List<String> localGroomHistoryImages = [
    'assets/images/main/history_groom_1.jpg',
    'assets/images/main/history_groom_2.jpg',
    'assets/images/main/history_groom_5.jpeg',
  ];

  /// 신랑 성장 사진 (원격 URL)
  static const List<String> remoteGroomHistoryImages = [
    'https://raw.githubusercontent.com/Heepie/mobile-wedding/master/sample/history/history_groom_3.jpg',
    'https://raw.githubusercontent.com/Heepie/mobile-wedding/master/sample/history/history_groom_4.jpg',
    'https://raw.githubusercontent.com/Heepie/mobile-wedding/master/sample/history/history_groom_5.jpeg',
  ];

  /// 신랑 소개 메시지
  static const String groomHistoryDescription =
      '어릴 적부터 레고를 좋아하던 철수는 개발자되었어요. 그리고 사랑, 일, 취미, 관계의 균형을 중요하게 생각하는 친구랍니다!\u{1F4BB}';

  // ╔══════════════════════════════════════════════════════════╗
  // ║  6. 신부 성장과정                                         ║
  // ║  신부 사진 + 소개                                         ║
  // ╚══════════════════════════════════════════════════════════╝

  /// 신부 성장 사진 (로컬)
  static const List<String> localBrideHistoryImages = [
    'assets/images/main/history_bride_1.jpg',
    'assets/images/main/history_bride_2.jpg',
    'assets/images/main/history_bride_5.jpeg',
  ];

  /// 신부 성장 사진 (원격 URL)
  static const List<String> remoteBrideHistoryImages = [
    'https://raw.githubusercontent.com/Heepie/mobile-wedding/master/sample/history/history_bride_2.jpeg',
    'https://raw.githubusercontent.com/Heepie/mobile-wedding/master/sample/history/history_bride_3.jpg',
    'https://raw.githubusercontent.com/Heepie/mobile-wedding/master/sample/history/history_bride_4.jpeg',
  ];

  /// 신부 소개 메시지
  static const String brideHistoryDescription =
      '어릴 적부터 흥이 많고 동생들을 잘 돌보던 영희는 초등교사가 되었고, 교육과정과 평가 전문가가 되는 꿈을 가진 친구랍니다!\u{1F3EB}';

  // ╔══════════════════════════════════════════════════════════╗
  // ║  7. 서로의 매력 + 취미                                     ║
  // ║  "어떤 매력?" → 답변 + 취미 사진/영상                       ║
  // ╚══════════════════════════════════════════════════════════╝

  /// 상대방 질문: 매력
  static const String questionAttraction =
      '두 분 정말 잘 어울려요!\n어떤 부분이 서로에게 매력이었어요?';

  /// 매력 답변 (**굵게** 표시 가능)
  static const String attractionAnswer =
      '영희는 **철수의 따뜻한 마음과 책임감**에,\n철수는 **영희의 작은 일에도 감사하고 야무진 모습**에 결혼을 결심했어요.';

  /// 취미 소개 메시지
  static const String hobbyMessage =
      '우리 둘은 시간을 보내는 방법이 비슷했어요!\n음악과 수영을 즐긴답니다! ㅎㅎ';

  /// 취미 사진 (로컬)
  static const List<String> localHobbyImages = [
    'assets/images/detail/hobby/hobby_together_1.jpeg',
    'assets/images/detail/hobby/hobby_bride_1.jpeg',
    'assets/images/detail/hobby/hobby_swimming_1.jpeg',
  ];

  /// 취미 영상 - 신부
  static const String hobbyBrideVideo =
      'https://raw.githubusercontent.com/Heepie/mobile-wedding/master/sample/hobby/bobby_bride.mp4';
  static const String hobbyBrideVideoThumbnail =
      'https://raw.githubusercontent.com/Heepie/mobile-wedding/master/sample/hobby/hobby_bride_video_1.jpeg';

  /// 취미 영상 - 신랑
  static const String hobbyGroomVideo =
      'https://raw.githubusercontent.com/Heepie/mobile-wedding/master/sample/hobby/bobby_groom.mp4';
  static const String hobbyGroomVideoThumbnail =
      'https://raw.githubusercontent.com/Heepie/mobile-wedding/master/sample/hobby/hobby_groom_video_1.jpeg';

  /// 취미 사진 (원격 URL)
  static const List<String> remoteHobbyImages = [
    'https://raw.githubusercontent.com/Heepie/mobile-wedding/master/sample/hobby/hobby_groom_1.jpeg',
    'https://raw.githubusercontent.com/Heepie/mobile-wedding/master/sample/hobby/hobby_groom_2.png',
    'https://raw.githubusercontent.com/Heepie/mobile-wedding/master/sample/hobby/hobby_bride_2.png',
    'https://raw.githubusercontent.com/Heepie/mobile-wedding/master/sample/hobby/hobby_together_1.jpeg',
  ];

  /// 상대방 반응: 취미
  static const String hobbyReaction = '취미가 같아 함께하는 신혼이 더 행복하겠어요!';

  // ╔══════════════════════════════════════════════════════════╗
  // ║  8. 엔딩                                                ║
  // ║  마지막 사진 → 엔딩 메시지 → 하단 푸터                      ║
  // ╚══════════════════════════════════════════════════════════╝

  /// 엔딩 메시지 (글자 애니메이션 적용, nameCharacters로 시작하는 4행시)
  static const String endingMessage =
      '철석같이 지킨 사랑의 약속\n수많은 날들을 함께하기로 한 이 날\n영원히 함께할 것을 맹세하며\n희망찬 새 출발을 축복해주세요';

  /// 하단 푸터 텍스트
  static const String footerText =
      'Developed by 철수\u{1F495}영희 with Flutter';

  // ╔══════════════════════════════════════════════════════════╗
  // ║  9. 웹 공유 미리보기 (OG 태그)                             ║
  // ║  카카오톡/SNS로 링크 공유 시 보이는 제목, 설명, 이미지         ║
  // ║  변경 후 dart run tool/generate_index_html.dart 실행       ║
  // ╚══════════════════════════════════════════════════════════╝

  /// 공유 미리보기 제목
  static const String ogTitle = '철수❤️영희 결혼해요!';

  /// 공유 미리보기 설명
  static const String ogDescription = '2026년 1월 24일 11시, 보테가마지오';

  /// 공유 미리보기 이미지 URL
  static const String ogImage =
      'https://raw.githubusercontent.com/Heepie/mobile-wedding/master/sample/preview/preview.jpg';

  // ╔══════════════════════════════════════════════════════════╗
  // ║  미리 로딩할 이미지 (수정 불필요)                            ║
  // ╚══════════════════════════════════════════════════════════╝

  static List<String> get imagesToPreload => [
    profileImage,
    typingGif,
    mapImage,
    ...localWeddingImages,
  ];
}
