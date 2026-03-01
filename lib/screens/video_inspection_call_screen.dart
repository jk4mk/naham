import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoInspectionCallScreen extends StatefulWidget {
  final String cookName;

  const VideoInspectionCallScreen({
    super.key,
    required this.cookName,
  });

  @override
  State<VideoInspectionCallScreen> createState() =>
      _VideoInspectionCallScreenState();
}

class _VideoInspectionCallScreenState extends State<VideoInspectionCallScreen> {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  bool _isPermissionDenied = false;
  String? _cameraErrorMessage;

  Timer? _timer;
  int _elapsedSeconds = 0;
  bool _noAnswer = false;
  bool _isEnding = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _initializeCamera();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      if (!mounted) return;
      setState(() {
        _isPermissionDenied = true;
        _cameraErrorMessage = 'Camera permission denied';
      });
      return;
    }

    try {
      final cameras = await availableCameras();
      if (!mounted) return;

      if (cameras.isEmpty) {
        setState(() {
          _cameraErrorMessage = 'No cameras available';
        });
        return;
      }

      final frontCamera = cameras.firstWhere(
        (cam) => cam.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      final controller = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await controller.initialize();
      if (!mounted) {
        await controller.dispose();
        return;
      }

      setState(() {
        _cameraController = controller;
        _isCameraInitialized = true;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _cameraErrorMessage = 'Failed to start camera';
      });
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        _elapsedSeconds++;
        if (_elapsedSeconds >= 30 && !_noAnswer) {
          _noAnswer = true;
        }
      });
    });
  }

  String get _formattedTime {
    final minutes = _elapsedSeconds ~/ 60;
    final seconds = _elapsedSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  String get _statusText => _noAnswer ? 'No answer' : 'Calling...';

  Future<void> _endCall(String result) async {
    if (_isEnding) return;
    _isEnding = true;

    _timer?.cancel();
    try {
      await _cameraController?.dispose();
    } catch (_) {}

    if (!mounted) return;
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(child: _buildCameraPreview()),
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.25),
              ),
            ),
            Positioned(
              top: 16,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.cookName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _statusText,
                    style: TextStyle(
                      color: _noAnswer
                          ? Colors.redAccent
                          : Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formattedTime,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 24,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDC2626),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () => _endCall('ended'),
                        child: const Text(
                          'End',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF16A34A),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: _noAnswer ? null : () => _endCall('clean'),
                        child: const Text(
                          'Mark Clean',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFDC2626),
                          side: BorderSide(
                            color: _noAnswer
                                ? Colors.red.withOpacity(0.4)
                                : const Color(0xFFDC2626),
                            width: 1.4,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed:
                            _noAnswer ? null : () => _endCall('not_clean'),
                        child: const Text(
                          'Mark Not Clean',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraPreview() {
    if (_isPermissionDenied) {
      return Center(
        child: Text(
          _cameraErrorMessage ?? 'Camera permission denied',
          style: const TextStyle(color: Colors.white70),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (_cameraErrorMessage != null) {
      return Center(
        child: Text(
          _cameraErrorMessage!,
          style: const TextStyle(color: Colors.white70),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (!_isCameraInitialized || _cameraController == null) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    final size = MediaQuery.of(context).size;
    final previewSize = _cameraController!.value.previewSize;
    if (previewSize == null) {
      return const SizedBox.shrink();
    }

    final previewAspectRatio = previewSize.height / previewSize.width;

    return Center(
      child: AspectRatio(
        aspectRatio: previewAspectRatio,
        child: CameraPreview(_cameraController!),
      ),
    );
  }
}

/*
Platform permissions (add manually):

Android (android/app/src/main/AndroidManifest.xml):
---------------------------------------------------
<uses-permission android:name="android.permission.CAMERA" />
<!-- If you later add audio: -->
<!-- <uses-permission android:name="android.permission.RECORD_AUDIO" /> -->

iOS (ios/Runner/Info.plist):
----------------------------
<key>NSCameraUsageDescription</key>
<string>This app needs camera access for hygiene inspections.</string>
<!-- If you later add audio: -->
<!--
<key>NSMicrophoneUsageDescription</key>
<string>This app needs microphone access for calls.</string>
-->
*/

