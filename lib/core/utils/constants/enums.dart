
enum UserRole {
  admin,
  wasteCollector,
  household,
}

enum WasteType {
  recyclable,
  organic,
  nonRecyclable,
}

enum TokenAction {
  wasteSubmission,
  appReferral,
  streakReward,
  challengeCompletion,
}

enum BagSize {
  quarter,
  half,
  threeQuarter,
  full,
}

enum SubmissionStatus {
  pending,
  verified,
  rejected,
  collected,
}

enum AppTheme {
  light,
  dark,
}

enum NotificationType {
  reminder,
  promotion,
  systemAlert,
}

enum CollectionFrequency {
  daily,
  weekly,
  biWeekly,
  monthly,
}

enum RewardType {
  cleaningSupplies,
  certificates,
  discounts,
  vouchers,
}

enum PaymentMethod {
  mobileMoney,
  creditCard,
  cash,
}

enum SortingCenterStatus {
  pending,
  inProcess,
  dispatched,
}

enum CollectionMode {
  individualPickup,
  centralizedDropoff,
}

enum AchievementType {
  environmentalImpact,
  streakMilestone,
  communityContribution,
}

enum FeedbackType {
  bugReport,
  featureRequest,
  generalComment,
}

enum CollectorStatus {
  available,
  onDuty,
  unavailable,
}

enum CertificateType {
  recyclingChampion,
  organicWasteExpert,
  environmentalHero,
}
