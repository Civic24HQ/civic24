enum DeleteFeedbackReason {
  difficultToUse,
  foundAlternative,
  privacyConcerns,
  noLongerNeeded,
  technicalIssues,
  other;

  String get label => switch (this) {
    difficultToUse => 'Difficult to use',
    foundAlternative => 'Found an alternative',
    privacyConcerns => 'Privacy concerns',
    noLongerNeeded => 'No longer need the service',
    technicalIssues => 'Technical issues (App is buggy or unreliable)',
    other => 'Other',
  };
}

List<DeleteFeedbackReason> get citizenFeedbackReasons => [
  DeleteFeedbackReason.difficultToUse,
  DeleteFeedbackReason.foundAlternative,
  DeleteFeedbackReason.privacyConcerns,
  DeleteFeedbackReason.noLongerNeeded,
  DeleteFeedbackReason.technicalIssues,
  DeleteFeedbackReason.other,
];
