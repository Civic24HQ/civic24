import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:models/models.dart';
import 'package:services/services.dart';
import 'package:services/src/services/firebase/firestore_collection_service.dart';
import 'package:stacked/stacked.dart';
import 'package:utils/utils.dart';

class ReportService extends FirestoreCollectionService<Report> with ListenableServiceMixin, AuthObserver {
  ReportService() {
    initialize();
  }

  @override
  @protected
  final log = getLogger('ReportService');

  final _alertService = serviceLocator<AlertService>();

  @override
  String get collectionPath => FirestoreCollections.reports;

  @override
  Report convertFromJson(Map<String, dynamic> json) => Report.fromJson(json);

  final ReactiveValue<List<Report>> _reports = ReactiveValue([]);
  List<Report> get reports => _reports.value;
  Stream<List<Report>> get reportsStream => _reports.values;

  StreamSubscription<List<Report>>? _reportsSubscription;

  Query<Report> getReportQuery({required String state}) {
    return collectionReference.where('state', isEqualTo: state).orderBy('updatedAt', descending: true);
  }

  Future<void> initialize() async {
    log.d('Initializing Report Service');
    listenToReactiveValues([_reports]);
  }

  /// Syncs reports based on the user's region and state
  /// This method fetches the reports from Firestore and updates the local state.
  Future<void> syncReportsByState(String state) async {
    log.i('Syncing reports...');

    if (state.isEmpty) {
      log.w('State is empty. Cannot sync reports.');
      return;
    }

    await fetchReports(state);
    await subscribeToReports(state);
  }

  @visibleForTesting
  Future<void> subscribeToReports(String state) async {
    log.i('Subscribing to reports...');
    await _reportsSubscription?.cancel();

    final query = getReportQuery(state: state);
    _reportsSubscription = subscribeListWithQuery(query: query).listen((List<Report> reports) {
      log.d('Update in report stream');

      if (reports.isEmpty) {
        log.w('No reports found for state: $state');
        return;
      }
      _reports.value = reports;
      log.i('Subscribed to ${reports.length} reports for state: $state');
      notifyListeners();
    });
  }

  /// Fetches reports based on the provided filters
  /// This method fetches the reports from Firestore and updates the local state.
  /// If no filters are provided, it will not fetch any reports.
  /// [state] - The state to filter reports by.
  @visibleForTesting
  Future<void> fetchReports(String state) async {
    log.i('Fetching reports...');

    try {
      final query = getReportQuery(state: state);
      final reports = await getDocumentsWithQuery(query: query);
      _reports.value = reports;
      log.i('Fetched ${reports.length} reports for state: $state');
    } catch (e) {
      log.e('Error fetching reports: $e');
      _alertService.showErrorAlert(
        title: 'Error fetching reports',
        message: 'An error occurred while fetching reports. Please try again later.',
      );
    }
  }

  @visibleForTesting
  Future<void> fetchReportByIds(List<String> reportIds) async {
    log.i('Fetching reports by IDs...');
    try {
      final query = collectionReference.where(FieldPath.documentId, whereIn: reportIds);
      final reports = await getDocumentsWithQuery(query: query);
      _reports.value = reports;
      log.i('Fetched ${reports.length} reports by IDs');
    } catch (e) {
      log.e('Error fetching reports by IDs: $e');
      _alertService.showErrorAlert(
        title: 'Error fetching reports',
        message: 'An error occurred while fetching reports. Please try again later.',
      );
    }
  }

  @visibleForTesting
  Future<void> subscribeToReportsByIds(List<String> reportIds) async {
    log.i('Subscribing to reports by IDs...');
    await _reportsSubscription?.cancel();

    try {
      final query = collectionReference.where(FieldPath.documentId, whereIn: reportIds);
      _reportsSubscription = subscribeListWithQuery(query: query).listen((List<Report> reports) {
        log.d('Update in report stream by IDs');
        if (reports.isEmpty) {
          log.w('No reports found for IDs: $reportIds');
          return;
        }
        _reports.value = reports;
        log.i('Subscribed to ${reports.length} reports by IDs');
        notifyListeners();
      });
    } catch (e) {
      log.e('Error subscribing to reports by IDs: $e');
    }
  }

  /// Seeds fake reports with the provided data
  /// [Fake Data] - The list of fake report data to seed.
  Future<void> seedFakeReports() async {
    log.d('Seeding fake reports...');
    final fakeData = fakeReportDataList;
    if (fakeData.isEmpty) {
      log.w('No fake data provided. Cannot seed reports.');
      return;
    }

    await Future.wait(
      fakeData.map((report) async {
        await create(documentId: report.reportData.reportId, payload: report);
      }),
    );
    log.i('Seeded ${fakeData.length} fake reports successfully.');
  }

  void dispose() {
    log.d('Disposing Report Service...');
    _reportsSubscription?.cancel();
    _reports.value = [];
  }
}
