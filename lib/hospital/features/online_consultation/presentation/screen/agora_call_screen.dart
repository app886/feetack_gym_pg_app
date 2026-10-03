import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/constants/agora_config.dart';
import '../../../../core/constants/colors.dart';

class AgoraCallScreen extends StatefulWidget {
  final String channelName;
  final String token;
  final String doctorName;
  final bool isAudioOnly;

  const AgoraCallScreen({
    super.key,
    this.channelName = AgoraConfig.defaultChannel,
    this.token = AgoraConfig.tempToken,
    this.doctorName = 'Dr. Mohamed Saeed',
    this.isAudioOnly = false,
  });

  @override
  State<AgoraCallScreen> createState() => _AgoraCallScreenState();
}

class _AgoraCallScreenState extends State<AgoraCallScreen> {
  int? _remoteUid;
  bool _localUserJoined = false;
  bool _isMuted = false;
  bool _isVideoDisabled = false;
  bool _isSpeakerphone = true;
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    _initAgora();
  }

  Future<void> _initAgora() async {
    // Request Microphone and Camera permissions
    await [
      Permission.microphone,
      if (!widget.isAudioOnly) Permission.camera,
    ].request();

    // Create Agora RTC Engine instance
    _engine = createAgoraRtcEngine();
    await _engine.initialize(
      const RtcEngineContext(
        appId: AgoraConfig.appId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );

    // Register Event Handlers
    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint('Joined channel: ${connection.channelId}, uid: ${connection.localUid}');
          if (mounted) {
            setState(() {
              _localUserJoined = true;
            });
          }
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint('Remote user joined: $remoteUid');
          if (mounted) {
            setState(() {
              _remoteUid = remoteUid;
            });
          }
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          debugPrint('Remote user offline: $remoteUid');
          if (mounted) {
            setState(() {
              _remoteUid = null;
            });
          }
        },
        onError: (ErrorCodeType err, String msg) {
          debugPrint('Agora Error [$err]: $msg');
        },
      ),
    );

    if (widget.isAudioOnly) {
      await _engine.enableAudio();
      await _engine.disableVideo();
    } else {
      await _engine.enableVideo();
      await _engine.startPreview();
    }

    // Join Channel
    await _engine.joinChannel(
      token: widget.token,
      channelId: widget.channelName,
      uid: 0,
      options: ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        channelProfile: ChannelProfileType.channelProfileCommunication,
        publishCameraTrack: !widget.isAudioOnly,
        publishMicrophoneTrack: true,
      ),
    );
  }

  @override
  void dispose() {
    _leaveChannel();
    super.dispose();
  }

  Future<void> _leaveChannel() async {
    try {
      await _engine.leaveChannel();
      await _engine.release();
    } catch (e) {
      debugPrint('Error leaving channel: $e');
    }
  }

  void _onToggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
    _engine.muteLocalAudioStream(_isMuted);
  }

  void _onToggleVideo() {
    if (widget.isAudioOnly) return;
    setState(() {
      _isVideoDisabled = !_isVideoDisabled;
    });
    _engine.muteLocalVideoStream(_isVideoDisabled);
  }

  void _onSwitchCamera() {
    if (widget.isAudioOnly) return;
    _engine.switchCamera();
  }

  void _onToggleSpeakerphone() {
    setState(() {
      _isSpeakerphone = !_isSpeakerphone;
    });
    _engine.setEnableSpeakerphone(_isSpeakerphone);
  }

  void _onEndCall() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121824),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A2232),
        elevation: 0,
        title: Text(
          widget.doctorName,
          style: const TextStyle(color: colorWhite, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: colorWhite, size: 20),
          onPressed: _onEndCall,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Remote View / Audio Call UI
            widget.isAudioOnly
                ? _buildAudioCallUI()
                : _buildRemoteVideoView(),

            // Local Video Floating Preview (For Video Call)
            if (!widget.isAudioOnly && _localUserJoined && !_isVideoDisabled)
              Positioned(
                top: 20,
                right: 20,
                width: 110,
                height: 150,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white30, width: 2),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(color: Colors.black45, blurRadius: 6),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AgoraVideoView(
                      controller: VideoViewController(
                        rtcEngine: _engine,
                        canvas: const VideoCanvas(uid: 0),
                      ),
                    ),
                  ),
                ),
              ),

            // Call Action Bar (Bottom Controls)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                margin: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A2232).withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(color: Colors.black38, blurRadius: 10),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Mute / Unmute Mic
                    _buildControlButton(
                      icon: _isMuted ? Icons.mic_off : Icons.mic,
                      color: _isMuted ? Colors.redAccent : Colors.white24,
                      onPressed: _onToggleMute,
                    ),

                    // Mute / Unmute Video (Only for Video Calls)
                    if (!widget.isAudioOnly)
                      _buildControlButton(
                        icon: _isVideoDisabled ? Icons.videocam_off : Icons.videocam,
                        color: _isVideoDisabled ? Colors.redAccent : Colors.white24,
                        onPressed: _onToggleVideo,
                      ),

                    // Switch Camera (Only for Video Calls)
                    if (!widget.isAudioOnly)
                      _buildControlButton(
                        icon: Icons.switch_camera,
                        color: Colors.white24,
                        onPressed: _onSwitchCamera,
                      ),

                    // Speakerphone Toggle
                    _buildControlButton(
                      icon: _isSpeakerphone ? Icons.volume_up : Icons.volume_off,
                      color: _isSpeakerphone ? Colors.blueAccent : Colors.white24,
                      onPressed: _onToggleSpeakerphone,
                    ),

                    // End Call Button
                    _buildControlButton(
                      icon: Icons.call_end,
                      color: Colors.red,
                      iconColor: Colors.white,
                      onPressed: _onEndCall,
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

  Widget _buildRemoteVideoView() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(channelId: widget.channelName),
        ),
      );
    }
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.blueAccent),
          SizedBox(height: 16),
          Text(
            'Waiting for doctor to connect...',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioCallUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blueAccent.withValues(alpha: 0.2),
            child: const Icon(Icons.person, size: 60, color: Colors.blueAccent),
          ),
          const SizedBox(height: 20),
          Text(
            widget.doctorName,
            style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            _remoteUid != null ? 'In Audio Consultation' : 'Connecting...',
            style: const TextStyle(color: Colors.greenAccent, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required Color color,
    Color iconColor = Colors.white,
    required VoidCallback onPressed,
  }) {
    return RawMaterialButton(
      onPressed: onPressed,
      shape: const CircleBorder(),
      fillColor: color,
      padding: const EdgeInsets.all(12.0),
      child: Icon(icon, color: iconColor, size: 24),
    );
  }
}
