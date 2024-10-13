import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

const TextStyle descriptionStyle = TextStyle(fontWeight: FontWeight.w500);

const TextStyle titleStyle = TextStyle(fontWeight: FontWeight.bold);
void showSuccessToast(String title, String body, {int? duration}) {
  toastification.show(
    type: ToastificationType.success,
    style: ToastificationStyle.minimal,
    title: Text(
      title,
      style: titleStyle,
    ),
    description: Text(
      body,
      style: descriptionStyle,
    ),
    alignment: Alignment.topCenter,
    autoCloseDuration: Duration(seconds: duration ?? 3),
    borderRadius: BorderRadius.circular(12.0),
    boxShadow: lowModeShadow,
    closeButtonShowType: CloseButtonShowType.none,
    dragToClose: true,
    showProgressBar: false,
  );
}

void showInfoToast(String title, String body, {int? duration}) {
  toastification.show(
    type: ToastificationType.info,
    style: ToastificationStyle.fillColored,
    title: Text(
      title,
      style: titleStyle,
    ),
    description: Text(
      body,
      style: descriptionStyle,
    ),
    alignment: Alignment.topCenter,
    autoCloseDuration: Duration(seconds: duration ?? 3),
    borderRadius: BorderRadius.circular(12.0),
    boxShadow: lowModeShadow,
    closeButtonShowType: CloseButtonShowType.none,
    dragToClose: true,
    showProgressBar: false,
  );
}

void showWarningToast(String title, String body, {int? duration}) {
  toastification.show(
    type: ToastificationType.warning,
    style: ToastificationStyle.fillColored,
    title: Text(
      title,
      style: titleStyle,
    ),
    description: Text(
      body,
      style: descriptionStyle,
    ),
    alignment: Alignment.topCenter,
    autoCloseDuration: Duration(seconds: duration ?? 3),
    borderRadius: BorderRadius.circular(12.0),
    boxShadow: lowModeShadow,
    closeButtonShowType: CloseButtonShowType.none,
    dragToClose: true,
    showProgressBar: false,
  );
}

void showErrorToast(String title, String body, {int? duration}) {
  toastification.show(
    type: ToastificationType.error,
    style: ToastificationStyle.flatColored,
    title: Text(
      title,
      style: titleStyle,
    ),
    description: Text(
      body,
      style: descriptionStyle,
    ),
    alignment: Alignment.topCenter,
    autoCloseDuration: Duration(seconds: duration ?? 3),
    borderRadius: BorderRadius.circular(12.0),
    boxShadow: lowModeShadow,
    closeButtonShowType: CloseButtonShowType.none,
    dragToClose: true,
    showProgressBar: false,
  );
}
