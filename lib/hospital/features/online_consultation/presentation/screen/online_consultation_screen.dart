import 'dart:async';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/animated_widgets.dart';
// import 'package:hospital_management_system/core/constants/colors.dart';
// import 'package:hospital_management_system/core/widgets/animated_widgets.dart';

class OnlineConsultationScreen extends StatefulWidget {
  final String doctorName;
  final String specialty;

  const OnlineConsultationScreen({
    Key? key,
    this.doctorName = 'Dr. Mohamed Saeed',
    this.specialty = 'Neurology & Tele-health',
  }) : super(key: key);

  @override
  State<OnlineConsultationScreen> createState() => _OnlineConsultationScreenState();
}

class _OnlineConsultationScreenState extends State<OnlineConsultationScreen> {
  bool _isMicMuted = false;
  bool _isCameraOff = false;
  bool _isInCall = true;
  int _callSeconds = 142; // Simulated active call
  Timer? _timer;
  final List<Map<String, String>> _messages = [
    {'sender': 'doctor', 'text': 'Hello! How have your symptoms been since the last prescription?'},
    {'sender': 'patient', 'text': 'Hi Doctor, the headache is much better, but mild dizziness persists in the morning.'},
  ];
  final TextEditingController _msgController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isInCall && mounted) {
        setState(() => _callSeconds++);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _msgController.dispose();
    super.dispose();
  }

  String _formatDuration(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121824),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.doctorName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: colorWhite)),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle),
                ),
                const SizedBox(width: 6),
                Text('HD Tele-Consultation • ${_formatDuration(_callSeconds)}', style: const TextStyle(fontSize: 11, color: Colors.white70)),
              ],
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: colorWhite, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline, color: colorWhite),
            onPressed: () => _openChatBottomSheet(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Video Stage
            Expanded(
              child: Stack(
                children: [
                  // Main Doctor Video View
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 20),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF1E3A8A), Color(0xFF0F172A)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: primaryColor.withOpacity(0.4),
                                child: const Icon(Icons.person, size: 60, color: colorWhite),
                              ),
                              const SizedBox(height: 12),
                              Text(widget.doctorName, style: const TextStyle(color: colorWhite, fontSize: 18, fontWeight: FontWeight.bold)),
                              Text(widget.specialty, style: const TextStyle(color: primaryLight, fontSize: 13)),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(Icons.mic, color: Colors.greenAccent, size: 14),
                                    SizedBox(width: 4),
                                    Text('Speaking...', style: TextStyle(color: colorWhite, fontSize: 11)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Patient Self-Preview Picture-in-Picture
                  Positioned(
                    top: 30,
                    right: 30,
                    child: Container(
                      width: 100,
                      height: 140,
                      decoration: BoxDecoration(
                        color: const Color(0xFF334155),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: primaryColor, width: 2),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 10),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: _isCameraOff
                            ? const Center(child: Icon(Icons.videocam_off, color: Colors.white70))
                            : Container(
                                color: Colors.blueGrey.shade900,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.person_pin, color: colorWhite, size: 36),
                                    SizedBox(height: 4),
                                    Text('You', style: TextStyle(color: colorWhite, fontSize: 10)),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Telemedicine Bottom Call Controls
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              decoration: const BoxDecoration(
                color: Color(0xFF1E293B),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCallBtn(
                    icon: _isMicMuted ? Icons.mic_off : Icons.mic,
                    color: _isMicMuted ? errorColor : Colors.white24,
                    iconColor: colorWhite,
                    onTap: () => setState(() => _isMicMuted = !_isMicMuted),
                  ),
                  _buildCallBtn(
                    icon: _isCameraOff ? Icons.videocam_off : Icons.videocam,
                    color: _isCameraOff ? errorColor : Colors.white24,
                    iconColor: colorWhite,
                    onTap: () => setState(() => _isCameraOff = !_isCameraOff),
                  ),
                  _buildCallBtn(
                    icon: Icons.chat,
                    color: Colors.white24,
                    iconColor: colorWhite,
                    onTap: () => _openChatBottomSheet(context),
                  ),
                  _buildCallBtn(
                    icon: Icons.call_end,
                    color: errorColor,
                    iconColor: colorWhite,
                    size: 32,
                    padding: 16,
                    onTap: () {
                      _timer?.cancel();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: primaryColor,
                          content: Text('Consultation completed. Prescription will be generated.'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallBtn({
    required IconData icon,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
    double size = 24,
    double padding = 12,
  }) {
    return AnimatedPressable(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(icon, color: iconColor, size: size),
      ),
    );
  }

  void _openChatBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colorWhite,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: 400,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('In-Call Chat with ${widget.doctorName}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final msg = _messages[index];
                      final isDoc = msg['sender'] == 'doctor';
                      return Align(
                        alignment: isDoc ? Alignment.centerLeft : Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: isDoc ? fillColor : primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            msg['text']!,
                            style: TextStyle(color: isDoc ? textDark : colorWhite, fontSize: 13),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _msgController,
                        decoration: InputDecoration(
                          hintText: 'Type a message or symptom...',
                          filled: true,
                          fillColor: backgroundColor,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.send, color: primaryColor),
                      onPressed: () {
                        if (_msgController.text.trim().isNotEmpty) {
                          setState(() {
                            _messages.add({'sender': 'patient', 'text': _msgController.text.trim()});
                          });
                          setModalState(() {});
                          _msgController.clear();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
