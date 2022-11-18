import 'package:flutter/material.dart';

class AlertManager {
  errorMessage() {
    return const Center(child: Text("Something went wrong :( "));
  }

  displaySnackbarError(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.error_outline_outlined,
            ),
            Text(
              message,
              style: const TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const Icon(
              Icons.error_outline_outlined,
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(242, 87, 35, 1)));
  }

  displaySnackbarSuccess(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.star,
              color: Colors.white,
            ),
            Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const Icon(
              Icons.star,
              color: Colors.white,
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(242, 87, 35, 1)));
  }

  displaySnackRegisterTrue(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.done_all,
              color: Colors.white,
            ),
            Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const Icon(
              Icons.done_all,
              color: Colors.white,
            ),
          ],
        ),
        backgroundColor: Colors.blue));
  }

  displaySnackRegisterFalse(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.close,
              color: Colors.red,
            ),
            Text(
              message,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const Icon(
              Icons.close,
              color: Colors.red,
            ),
          ],
        ),
        backgroundColor: Colors.white));
  }
}
