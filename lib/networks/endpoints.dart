// ignore_for_file: constant_identifier_names

const String url = "https://sticker.zobayer.xyz";

String websocketBaseUrl = url.split('://').last;

final class NetworkConstants {
  NetworkConstants._();
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "en";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

final class PaymentGateway {
  PaymentGateway._();
  static String gateway(String orderId) => "";
}

final class Endpoints {
  Endpoints._();
  // * Sticker Packs API ENDPOINT
  static String getPacks() => "/api/packs.php";

  // * Auth API ENDPOINT
  static String logIn() => "/api/signin/";
  static String signUpUrl() => "/api/signup/";
  static String securityQuestionUrl() => "/api/security-questions/setup/";
  static String logOut() => "/api/signout/";
  static String changePassword() => "/api/change-password/";
  static String deleteAccount() => "/api/account-delete/";
  static String googleAuth() => "/api/google-auth/";

  // * exam select api
  static String getExamTypes() => "/api/student/onboarding/examinations/";
  static String selectExamTypes() =>
      "/api/student/onboarding/practice-solo/initiate/";
  static String getFirstTimeQuestion({required int examId}) =>
      "/api/student/onboarding/practice-solo/$examId/question/";
  static String submitFirstTimeQuestion({required int examId}) =>
      "/api/student/onboarding/practice-solo/$examId/question/submit/";
  static String allQuestionAnalysisFirstTime({required int examId}) =>
      "/api/student/onboarding/practice-solo/$examId/submit/";
  static String getHomeStats() => "/api/student/learning/home/stats/";
  static String getRank() => "/api/student/learning/leaderboard/";
  static String getHomeUpcomingOrComplete({required String filter}) =>
      "/api/student/learning/lessons/?status=$filter";
  static String getProfile() => "/api/profile-get/";
  static String updateProfile() => "/api/profile-update/";
  static String securityQuestionsVerify() => "/api/security-questions/verify/";
  static String resetPassword() => "/api/reset-password-confirm/";
  static String overAllLessonProgress() =>
      "/api/student/learning/overall-progress/";
  static String getAllLesson() => "/api/student/learning/lessons/";
  static String getLessonView({required int lessonId}) =>
      "/api/student/learning/lessons/$lessonId/videos/";
  static String flashcardSolution({required int flashcardId}) =>
      "/api/student/flashcards/$flashcardId/";
  static String getFlashcard({String? filter}) => filter == null
      ? "/api/student/flashcards/"
      : "/api/student/flashcards/?type=$filter";
  static String getlessonVideo({required int lessonId, required int videoId}) =>
      "/api/student/learning/lessons/$lessonId/videos/$videoId/";
  static String downloadFormulaSheet({
    required int lessonId,
    required int videoId,
  }) =>
      "/api/student/learning/lessons/$lessonId/videos/$videoId/formula-sheet/download/";
  static String createGroup() => "/api/groups/create_group/";
  static String joinGroup() => "/api/groups/join_group/";
  static String deleteGroup({required int groupId}) => "/api/groups/$groupId/";
  static String getAllGroup() => "/api/groups/";
  static String getGroupDetails({required int groupId}) =>
      "/api/groups/$groupId";
  static String uploadGroupImage({required int groupId}) =>
      "/api/groups/$groupId/upload_image/";
  static String groupMemberList({required int groupId}) =>
      "/api/groups/$groupId/members/";
  static String removeGroupMember({
    required int groupId,
    required int memberId,
  }) => "/api/groups/$groupId/members/$memberId/";
  static String getOrganizationSettings() =>
      "/api/head-teacher/organization/settings/";
  static String getVideoQuestion({
    required int lessonId,
    required int videoId,
  }) => "/api/student/learning/lessons/$lessonId/videos/$videoId/question/";
  static String submitVideoQuestion({
    required int lessonId,
    required int videoId,
  }) =>
      "/api/student/learning/lessons/$lessonId/videos/$videoId/question/submit/";
  static String addToFlashcard() => "/api/student/flashcards/toggle-save/";
  static String createLessTestAttId({required int lessonId}) =>
      "/api/student/learning/lessons/$lessonId/quiz/initiate/";
  static String getLessTestQue({
    required int lessonId,
    required int attemptId,
  }) => "/api/student/learning/lessons/$lessonId/quiz/$attemptId/question/";
  static String submitLessTestQue({
    required int lessonId,
    required int attemptId,
  }) =>
      "/api/student/learning/lessons/$lessonId/quiz/$attemptId/question/submit/";
  static String completeLessTestQue({
    required int lessonId,
    required int attemptId,
  }) => "/api/student/learning/lessons/$lessonId/quiz/$attemptId/submit/";
  static String testResultDetails({
    required int lessonId,
    required int attemptId,
  }) => "/api/student/learning/lessons/$lessonId/quiz/$attemptId/results/";
  static String createAiQuiz() => "/api/ai/quiz/initiate/";
  static String getAiQuiz({required int attemptId}) =>
      "/api/ai/quiz/$attemptId/question/";
  static String submitAiQuiz({required int attemptId}) =>
      "/api/ai/quiz/$attemptId/question/submit/";
  static String anylasisAiQuiz({required int attemptId}) =>
      "/api/ai/quiz/$attemptId/submit/";
  static String chatbotChat() => "/api/ai/chat/query/";
  static String chatbotChatHistory() => "/api/ai/chat/sessions/";
  static String chatbotChatDetails({required int sessionId}) =>
      "/api/ai/chat/sessions/$sessionId/";
  static String chatbotChatEdit({required int sessionId}) =>
      "/api/ai/chat/sessions/$sessionId/";
  static String chatbotChatDelete({required int sessionId}) =>
      "/api/ai/chat/sessions/$sessionId/";
  static String getOrganizationList() =>
      "/api/student/onboarding/organizations/";
  static String joinOrganization() =>
      "/api/student/onboarding/join-organization/";
  static String leaveOrganization() => "/api/organization/leave/";
  static String headTeacherHomeData() =>
      "/api/head-teacher/dashboard-overview/";
  static String headControlData() => "/api/head-teacher/control-master/";
  static String getExamList() => "/api/head-teacher/classes-overview/";
  static String getTeachersList({int? classId}) => classId != null
      ? "/api/head-teacher/teachers/?class_id=$classId"
      : "/api/head-teacher/teachers/";
  static String getTeacherBatchList({required int teacherId, int? classId}) =>
      classId != null
      ? "/api/head-teacher/teachers/$teacherId/batches/?$classId"
      : "/api/head-teacher/teachers/$teacherId/batches/";
  static String getTeacherProfile({required int teacherId}) =>
      "/api/head-teacher/teachers/$teacherId/";
  static String getBatchDetails({required int batchId}) =>
      "/api/head-teacher/batches/$batchId/";
  static String editAssisTeacher({required int teacherId}) =>
      "/api/head-teacher/teachers/$teacherId/";
  static String getStudentList() => "/api/head-teacher/students/";
  static String getBatchBreakdown() => "/api/head-teacher/batch-breakdown/";
  static String getHeadTeacBatches() => "/api/head-teacher/batches/";
  static String createBatch() => "/api/head-teacher/batches/";
  static String createBatchGroup({required int batchId}) =>
      "/api/head-teacher/batches/$batchId/groups/";
  static String getTeacGroupList() => "/api/head-teacher/groups/";
  static String addStudent() => "/api/head-teacher/students/";
  static String removeStudent({required int studentId}) =>
      "/api/head-teacher/students/$studentId/";
  static String editStudent({required int studentId}) =>
      "/api/head-teacher/students/$studentId/";
  static String inviteAssisTeac() => "/api/head-teacher/assistant-invites/";
  static String getNotification() => "/api/notification-list/";
  static String responseInvitation({required String responseUrl}) =>
      responseUrl;
  static String getSubjects({required int batchId}) =>
      "/api/head-teacher/subjects/?batch_id=$batchId";
  static String customTestCreate() => "/api/head-teacher/tests/create-custom/";
  static String getTestRoom({required String status}) =>
      "/api/head-teacher/tests/?status=$status";
  static String getStudentDetails({required int studentId}) =>
      "/api/head-teacher/students/$studentId/performance/";
  static String getTestHistoryDetails({
    required int studentId,
    required int attemptId,
  }) => "/api/head-teacher/students/$studentId/attempts/$attemptId/";
  static String getTestRoomStudentDetails({
    required int studentId,
    required int testId,
  }) => "/api/head-teacher/tests/$testId/students/$studentId/live/";
  static String getSettingsData() => "/api/settings-overview/";
  static String shareTest({required int testId}) =>
      "/api/head-teacher/tests/$testId/share/";
  static String getTeacGroupMembes({required int groupId}) =>
      "/api/head-teacher/groups/$groupId/members/";
  static String joinTestRoom() => "/api/student/learning/tests/verify-room/";
  static String getTestRoomQuestion({required int roomId}) =>
      "/api/student/learning/tests/$roomId/next-question/";
  static String submitTestRoomQuestion({required int roomId}) =>
      "/api/monitoring/$roomId/save_answer/";
  static String submitTestRoomExam({required int roomId}) =>
      "/api/dashboard/tests/$roomId/submit/";
  static String getLiveTestResult({required int attemptId}) =>
      "/api/student/learning/tests/results/$attemptId/";
  static String aiQuestion() => "/api/ai/questions/generate/";
  static String getTestDetails({required int testId}) =>
      "/api/head-teacher/tests/$testId/details/";
  static String liveMonitor({required int testId}) =>
      "/api/head-teacher/tests/$testId/live-monitor/";
  static String getTeacChat({required int groupId}) =>
      "/api/head-teacher/groups/$groupId/messages/";
  static String getStudentChat({required int groupId}) =>
      "/api/groups/$groupId/messages/";
  static String getAllUploadedLeeson() => "/api/head-teacher/lessons/";
  static String uploadLeeson() => "/api/head-teacher/lessons/";
  static String editLeeson({required int lessonId}) =>
      "/api/head-teacher/lessons/$lessonId/";
  static String getAllVideos({required int lessonId}) =>
      "/api/head-teacher/lessons/$lessonId/";
  static String uploadLessonVideo({required int lessonId}) =>
      "/api/head-teacher/lessons/$lessonId/videos/";
  static String editLessonVideo({
    required int lessonId,
    required int videoId,
  }) => "/api/head-teacher/lessons/$lessonId/videos/$videoId/";
  static String deleteLessonVideo({
    required int lessonId,
    required int videoId,
  }) => "/api/head-teacher/lessons/$lessonId/videos/$videoId/";
  static String getVideoDetails({
    required int lessonId,
    required int videoId,
  }) => "/api/head-teacher/lessons/$lessonId/videos/$videoId/";
  static String editVideo({required int lessonId, required int videoId}) =>
      "/api/head-teacher/lessons/$lessonId/videos/$videoId/";
  static String uploadTempMedia() => "/api/groups/temp_media_upload/";
  static String pinUnpinMessage({
    required int groupId,
    required String messageId,
  }) => "/api/groups/$groupId/messages/$messageId/pin/";
  static String deleteMessage({required String messageId}) =>
      "/api/messages/$messageId/";
  static String getJoinOrgBatchList() =>
      "/api/student/onboarding/my-organization/";
  static String joinBatch() => "/api/student/onboarding/join-batch/";
  static String videoProgreshSave() => "/api/student/learning/video-progress/";
  static String getCertificate() => "/api/certificates/my-certificates/";
  static String createLessonQuiz({required int lessonId}) =>
      "/api/head-teacher/lessons/$lessonId/tests/";
  static String lessonQuizShow({required int lessonId, required int testId}) =>
      "/api/head-teacher/lessons/$lessonId/tests/$testId/";
  static String lessonQuizEdit({required int lessonId, required int testId}) =>
      "/api/head-teacher/lessons/$lessonId/tests/$testId/";
  static String lessonQuizDelete({
    required int lessonId,
    required int testId,
  }) => "/api/head-teacher/lessons/$lessonId/tests/$testId/";
  static String getTestRoomDetails({required int testRoomId}) =>
      "/api/head-teacher/tests/$testRoomId/update-custom/";
  static String editTestRoomDetails({required int testRoomId}) =>
      "/api/head-teacher/tests/$testRoomId/update-custom/";
  static String headTeacherAiTestCreate() =>
      "/api/head-teacher/tests/create-ai/";
  static String getAlert() => "/api/head-teacher/performance-alerts/";
  static String getGroupResources({required int groupId}) =>
      "/api/head-teacher/groups/$groupId/resources/";
  static String headCertificateList() => "/api/head-teacher/certificates/";
  static String markAllRead() => "/api/mark-all-read/";
  static String contactUsUrl() => "/api/contact/";
  static String aboutUsUrl() => "/api/pages/about-us/";
  static String privacyPolicyUrl() => "/api/pages/privacy-policy/";
  static String termsAndConditionsUrl() => "/api/pages/terms-conditions/";
  static String createOrganizationUrl() =>
      "/api/head-teacher/organization/settings/";
}
