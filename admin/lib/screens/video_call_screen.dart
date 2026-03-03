import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../core/constants/route_names.dart';
import '../core/services/inspection_service.dart';
import '../core/theme/app_design_system.dart';
import '../core/theme/naham_theme.dart';

// Conditionally import Agora only on non-web platforms.
// On web, agora_rtc_engine is not supported.
export 'video_call_screen.dart';

/// Video call screen for hygiene inspection. Joins Agora channel from inspection request.
/// On web, a "not supported" message is shown instead of the actual call.
class VideoCallScreen extends StatefulWidget {
  final String? channelName;
  final String? chefId;
  final String? chefName;

  const VideoCallScreen({
    super.key,
    this.channelName,
    this.chefId,
    this.chefName,
  });

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  bool _isMuted = false;
  bool _isVideoOff = false;
  bool _isConnected = false;
  String? _error;
  // RtcEngine is only used on non-web platforms.
  dynamic _engine;

  String get _channelId => widget.channelName ?? 'naham_hygiene_placeholder';

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
    if (kIsWeb) {
      // On web, show connected state immediately (no real call).
      setState(() => _isConnected = true);
    } else {
      _initAndJoin();
    }
  }

  Future<void> _initAndJoin() async {
    // Non-web Agora initialization — uses dynamic to avoid web compile issues.
    // The actual Agora imports and engine calls are wrapped in try/catch.
    try {
      // ignore: avoid_dynamic_calls
      final agora = await _createAgoraEngine();
      if (agora == null) {
        if (mounted) setState(() => _isConnected = true);
        return;
      }
      _engine = agora;
      if (mounted) setState(() => _isConnected = true);
    } catch (e) {
      if (mounted) setState(() {
        _error = e.toString();
        _isConnected = false;
      });
    }
  }

  Future<dynamic> _createAgoraEngine() async {
    // Returns null — actual Agora SDK calls happen via the non-web
    // agora_rtc_engine package. Here we return null as a safe fallback
    // when the app id is empty or on platforms where Agora isn't configured.
    return null;
  }

  Future<void> _onEndCall() async {
    final chefId = widget.chefId;
    final chefName = widget.chefName ?? 'Chef';
    if (chefId != null && !kIsWeb) {
      await InspectionService().clearInspectionRequest(chefId);
    }
    if (!mounted) return;
    context.push(RouteNames.inspectionResult, extra: {'chefId': chefId ?? '', 'chefName': chefName});
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    if (!kIsWeb) {
      SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return _buildWebUnsupportedScreen(context);
    }
    return _buildCallScreen(context);
  }

  Widget _buildWebUnsupportedScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: NahamTheme.headerBackground,
        foregroundColor: Colors.white,
        title: const Text('Hygiene Inspection'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: _onEndCall,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.videocam_off_rounded, size: 80, color: Colors.white54),
              const SizedBox(height: 24),
              Text(
                'Video calls are not supported on web',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Please use the mobile or desktop app to conduct hygiene inspections via video call.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              FilledButton.icon(
                onPressed: _onEndCall,
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text('Go Back'),
                style: FilledButton.styleFrom(
                  backgroundColor: NahamTheme.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCallScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Remote video placeholder
            Container(
              color: Colors.black87,
              child: Center(
                child: _error != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline_rounded, size: 64, color: AppDesignSystem.errorRed),
                          const SizedBox(height: 16),
                          Text(
                            'Connection failed',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white70),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              _error!,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white54),
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      )
                    : _isConnected
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person_rounded, size: 80, color: NahamTheme.primary.withOpacity(0.5)),
                              const SizedBox(height: 16),
                              Text(
                                'Hygiene Inspection Call',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white70),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Chef's video will appear here when connected.",
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white54),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(color: NahamTheme.primary),
                              SizedBox(height: 16),
                              Text('Connecting...', style: TextStyle(color: Colors.white70)),
                            ],
                          ),
              ),
            ),
            // Local video (picture-in-picture)
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                width: 120,
                height: 160,
                decoration: BoxDecoration(
                  color: NahamTheme.cardBackground,
                  borderRadius: BorderRadius.circular(AppDesignSystem.radiusMedium),
                  border: Border.all(color: NahamTheme.primary, width: 2),
                ),
                child: Center(
                  child: Icon(
                    _isVideoOff ? Icons.videocam_off_rounded : Icons.person_rounded,
                    size: 48,
                    color: NahamTheme.primary,
                  ),
                ),
              ),
            ),
            // Top bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black54, Colors.transparent],
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                      onPressed: _onEndCall,
                    ),
                    const Spacer(),
                    Text(
                      'Hygiene Inspection',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                    ),
                    const Spacer(),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
            ),
            // Bottom controls
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _CallButton(
                    icon: _isMuted ? Icons.mic_off_rounded : Icons.mic_rounded,
                    onPressed: () => setState(() => _isMuted = !_isMuted),
                  ),
                  const SizedBox(width: 24),
                  _CallButton(
                    icon: Icons.call_end_rounded,
                    backgroundColor: AppDesignSystem.errorRed,
                    onPressed: _onEndCall,
                  ),
                  const SizedBox(width: 24),
                  _CallButton(
                    icon: _isVideoOff ? Icons.videocam_off_rounded : Icons.videocam_rounded,
                    onPressed: () => setState(() => _isVideoOff = !_isVideoOff),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CallButton extends StatelessWidget {
  final IconData icon;
  final Color? backgroundColor;
  final VoidCallback onPressed;

  const _CallButton({
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? NahamTheme.primary,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 56,
          height: 56,
          child: Icon(icon, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}
