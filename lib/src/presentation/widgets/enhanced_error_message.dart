import 'package:flutter/material.dart';

import '../../core/errors/app_error.dart';

/// Enhanced error message widget with retry functionality
class EnhancedErrorMessage extends StatelessWidget {
  const EnhancedErrorMessage({
    super.key,
    required this.error,
    this.onRetry,
    this.showRetryButton = true,
    this.textAlign = TextAlign.start,
  });

  final AppError error;
  final VoidCallback? onRetry;
  final bool showRetryButton;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _getErrorBackgroundColor(error.type),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getErrorBorderColor(error.type),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getErrorIcon(error.type),
                color: _getErrorIconColor(error.type),
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  error.localizedMessage,
                  style: TextStyle(
                    color: _getErrorTextColor(error.type),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: textAlign,
                ),
              ),
            ],
          ),

          if (showRetryButton && onRetry != null) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onRetry,
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.refresh, size: 16),
                      SizedBox(width: 4),
                      Text('Thử lại'),
                    ],
                  ),
                ),
              ],
            ),
          ],

          // Show suggested action if available
          if (error is! ValidationError) ...[
            const SizedBox(height: 8),
            Text(
              ErrorHandler.getSuggestedAction(error),
              style: TextStyle(
                color: _getErrorTextColor(error.type).withValues(alpha: 0.8),
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getErrorBackgroundColor(ErrorType type) {
    switch (type) {
      case ErrorType.network:
        return Colors.orange.shade50;
      case ErrorType.authentication:
        return Colors.red.shade50;
      case ErrorType.validation:
        return Colors.amber.shade50;
      case ErrorType.server:
        return Colors.red.shade50;
      case ErrorType.unknown:
        return Colors.grey.shade50;
    }
  }

  Color _getErrorBorderColor(ErrorType type) {
    switch (type) {
      case ErrorType.network:
        return Colors.orange.shade200;
      case ErrorType.authentication:
        return Colors.red.shade200;
      case ErrorType.validation:
        return Colors.amber.shade200;
      case ErrorType.server:
        return Colors.red.shade200;
      case ErrorType.unknown:
        return Colors.grey.shade200;
    }
  }

  Color _getErrorTextColor(ErrorType type) {
    switch (type) {
      case ErrorType.network:
        return Colors.orange.shade800;
      case ErrorType.authentication:
        return Colors.red.shade800;
      case ErrorType.validation:
        return Colors.amber.shade800;
      case ErrorType.server:
        return Colors.red.shade800;
      case ErrorType.unknown:
        return Colors.grey.shade800;
    }
  }

  Color _getErrorIconColor(ErrorType type) {
    switch (type) {
      case ErrorType.network:
        return Colors.orange.shade600;
      case ErrorType.authentication:
        return Colors.red.shade600;
      case ErrorType.validation:
        return Colors.amber.shade600;
      case ErrorType.server:
        return Colors.red.shade600;
      case ErrorType.unknown:
        return Colors.grey.shade600;
    }
  }

  IconData _getErrorIcon(ErrorType type) {
    switch (type) {
      case ErrorType.network:
        return Icons.wifi_off;
      case ErrorType.authentication:
        return Icons.lock;
      case ErrorType.validation:
        return Icons.warning;
      case ErrorType.server:
        return Icons.cloud_off;
      case ErrorType.unknown:
        return Icons.error;
    }
  }
}
