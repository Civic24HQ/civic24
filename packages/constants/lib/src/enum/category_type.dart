import 'package:localization/localization.dart';

enum CategoryType {
  road,
  light,
  waste,
  abandoned,
  health,
  security,
  education,
  governance,
  urban;

  String get label => switch (this) {
    road => l10n.featureCategoryTypeRoad,
    light => l10n.featureCategoryTypeLight,
    waste => l10n.featureCategoryTypeWaste,
    abandoned => l10n.featureCategoryTypeAbandoned,
    health => l10n.featureCategoryTypeHealth,
    security => l10n.featureCategoryTypeSecurity,
    education => l10n.featureCategoryTypeEducation,
    governance => l10n.featureCategoryTypeGovernance,
    urban => l10n.featureCategoryTypeUrban,
  };

  String get detailedLabel => switch (this) {
    road => l10n.featureCategoryTypeDetailedRoad,
    light => l10n.featureCategoryTypeDetailedLight,
    waste => l10n.featureCategoryTypeDetailedWaste,
    abandoned => l10n.featureCategoryTypeDetailedAbandoned,
    health => l10n.featureCategoryTypeDetailedHealth,
    security => l10n.featureCategoryTypeDetailedSecurity,
    education => l10n.featureCategoryTypeDetailedEducation,
    governance => l10n.featureCategoryTypeDetailedGovernance,
    urban => l10n.featureCategoryTypeDetailedUrban,
  };

  String get description => switch (this) {
    road => l10n.featureCategoryTypeRoadDescription,
    light => l10n.featureCategoryTypeLightDescription,
    waste => l10n.featureCategoryTypeWasteDescription,
    abandoned => l10n.featureCategoryTypeAbandonedDescription,
    health => l10n.featureCategoryTypeHealthDescription,
    security => l10n.featureCategoryTypeSecurityDescription,
    education => l10n.featureCategoryTypeEducationDescription,
    governance => l10n.featureCategoryTypeGovernanceDescription,
    urban => l10n.featureCategoryTypeUrbanDescription,
  };
}
