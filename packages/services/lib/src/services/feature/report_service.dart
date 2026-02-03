import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:models/models.dart';
import 'package:services/services.dart';
import 'package:services/src/services/firebase/firebase_storage_service.dart';
import 'package:services/src/services/firebase/firestore_collection_service.dart';
import 'package:stacked/stacked.dart';
import 'package:utils/utils.dart';

// This class is responsible for managing report data related operations
// such as fetching report data, updating report information, etc.
class ReportService extends FirestoreCollectionService<Report> with ListenableServiceMixin, FirebaseStorageService {
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

  final ReactiveValue<List<Report>> _reportList = ReactiveValue([]);
  List<Report> get reportList => _reportList.value;
  Stream<List<Report>> get reportsStream => _reportList.values;

  // StreamSubscription<List<Report>>? _reportsSubscription;

  Future<void> initialize() async {
    log.d('Initializing Report Service');
    listenToReactiveValues([_reportList]);

    // Fetch from Firestore
    // await syncReportList();
  }

  /// Syncs report list for the current user
  /// by fetching reports created within the last month.
  Future<void> syncReportList() async {
    log.i('Syncing report list for the current user...');
    // final now = DateTime.now();
    // final oneMonthAgo = DateTime(now.year, now.month - 1, now.day);

    final query = collectionReference
        // .where('reportData.createdAt', isGreaterThanOrEqualTo: oneMonthAgo)
        // .where('reportData.createdAt', isLessThanOrEqualTo: now)
        .orderBy('reportData.createdAt', descending: true);

    final reportList = await getDocumentsWithQuery(query: query);
    if (reportList.isEmpty) {
      log.w('No report documents found within the specified date range.');
      _reportList.value = [];
    } else {
      log.i('Successfully retrieved ${reportList.length} report document(s).');
      _reportList.value = reportList;
    }
    notifyListeners();
  }

  // @visibleForTesting
  // Future<void> subscribeToReports() async {
  //   log.i('Subscribing to reports...');
  //   await _reportsSubscription?.cancel();

  //   final now = DateTime.now();
  //   final oneMonthAgo = DateTime(now.year, now.month - 1, now.day);
  //   final query = collectionReference
  //       .where('createdAt', isGreaterThanOrEqualTo: oneMonthAgo)
  //       .where('createdAt', isLessThanOrEqualTo: now)
  //       .orderBy('createdAt', descending: true);

  //   _reportsSubscription = subscribeListWithQuery(query: query).listen((List<Report> reports) {
  //     log.d('Update in report stream');

  //     if (reports.isEmpty) {
  //       log.w('No report founds in the subscription stream.');
  //       return;
  //     }
  //     _reportList.value = reports;
  //     log.i('Subscribed to ${reports.length} reports');
  //     notifyListeners();
  //   });
  // }

  /// Add a new report with the provided data
  /// [report] - The report data to create.
  Future<void> addReport(Report report) async {
    log.i('Creating a new report...');
    try {
      final reportId = generateNewDocId();
      final currentTimestamp = DateTime.now().toUtc();
      final newReportData = report.reportData.copyWith(reportId: reportId, createdAt: currentTimestamp);
      final newReport = report.copyWith(reportData: newReportData);
      log.i('Creating new report with Report ID: $reportId');

      // Add the report to the local state
      // _reportList.value.add(newReport);
      _reportList.value = [newReport, ..._reportList.value];
      notifyListeners();

      await create(documentId: newReportData.reportId, payload: newReport);

      log.i('New report with ID: ${newReportData.reportId} created successfully');
    } catch (e) {
      log.e('Error creating report: $e');
      _alertService.showErrorAlert(
        title: 'Report Creation Failed',
        message: 'Failed to create a new report. Please try again later.',
      );
    }
  }

  /// Update an existing report with the provided data
  /// [report] - The report data to update.
  Future<void> updateReport(Report report) async {
    log.d('Updating report...');
    try {
      await update(documentId: report.reportData.reportId, payload: report);
      _reportList.value = _reportList.value.map((r) {
        if (r.reportData.reportId == report.reportData.reportId) {
          return report;
        }
        return r;
      }).toList();
      notifyListeners();
      log.i('Report with ID: ${report.reportData.reportId} updated successfully');
    } catch (e) {
      log.e('Failed to update report', error: e);
      _alertService.showErrorAlert(title: 'Report Update Failed', message: 'Failed to update the report.');
      return;
    }
  }

  /// Fetches reports created within the last month
  /// for all users.
  Future<List<Report>> fetchReports() async {
    try {
      log.d('Fetching reports for all users');
      // final now = DateTime.now();
      // final oneMonthAgo = DateTime(now.year, now.month - 1, now.day);
      final query = collectionReference
          // .where('createdAt', isGreaterThanOrEqualTo: oneMonthAgo)
          // .where('createdAt', isLessThanOrEqualTo: now)
          .orderBy('createdAt', descending: true);

      final reports = await getDocumentsWithQuery(query: query);

      log.i('Successfully fetched ${reports.length} reports for all users');
      return reports;
    } catch (e) {
      log.e('Failed to fetch reports for all users', error: e);
      _alertService.showErrorAlert(title: 'Report Fetch Failed', message: 'Failed to fetch reports for all users.');
      return [];
    }
  }

  @visibleForTesting
  Future<void> fetchReportByIds(List<String> reportIds) async {
    log.i('Fetching reports by IDs...');
    try {
      final query = collectionReference.where(FieldPath.documentId, whereIn: reportIds);
      final reports = await getDocumentsWithQuery(query: query);
      _reportList.value = reports;
      log.i('Fetched ${reports.length} reports by IDs');
    } catch (e) {
      log.e('Error fetching reports by IDs: $e');
      _alertService.showErrorAlert(
        title: 'Error fetching reports',
        message: 'An error occurred while fetching reports. Please try again later.',
      );
    }
  }

  // @visibleForTesting
  // Future<void> subscribeToReportsByIds(List<String> reportIds) async {
  //   log.i('Subscribing to reports by IDs...');
  //   await _reportsSubscription?.cancel();

  //   try {
  //     final query = collectionReference.where(FieldPath.documentId, whereIn: reportIds);
  //     _reportsSubscription = subscribeListWithQuery(query: query).listen((List<Report> reports) {
  //       log.d('Update in report stream by IDs');
  //       if (reports.isEmpty) {
  //         log.w('No reports found for IDs: $reportIds');
  //         return;
  //       }
  //       _reportList.value = reports;
  //       log.i('Subscribed to ${reports.length} reports by IDs');
  //       notifyListeners();
  //     });
  //   } catch (e) {
  //     log.e('Error subscribing to reports by IDs: $e');
  //   }
  // }

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
    // _reportsSubscription?.cancel();
    _reportList.value = [];
  }
}
