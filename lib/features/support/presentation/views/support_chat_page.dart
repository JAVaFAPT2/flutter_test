import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:vietnamese_fish_sauce_app/core/constants/app_colors.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/figma_assets.dart';
import 'package:vietnamese_fish_sauce_app/features/home/presentation/widgets/bottom_navigation.dart';
import 'package:vietnamese_fish_sauce_app/shared/widgets/custom_support_header.dart';

/// Support chat page for displaying different support topics in chat format
/// Matches Figma designs (nodes 1-1092, 1-1124, 1-1024, 1-1058)
class SupportChatPage extends StatefulWidget {
  const SupportChatPage({
    super.key,
    required this.topic,
  });

  final String topic;

  static const String routeName = '/support-chat';

  @override
  State<SupportChatPage> createState() => _SupportChatPageState();
}

class _SupportChatPageState extends State<SupportChatPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Map<String, Map<String, String>> get _chatData => {
        'Trò chuyện với nhân viên tư vấn': {
          'title': 'Trò chuyện với nhân viên tư vấn!',
          'response':
              'Cảm ơn bạn đã liên hệ với MGF. Chúng tôi có thể giúp gì được cho bạn?',
        },
        'Thông tin về MGF': {
          'title': 'Thông tin MGF',
          'response':
              'Cảm ơn bạn đã liên hệ với MGF. Chúng tôi gửi bạn thông tin về MGF, vui lòng truy cập Website của chúng tôi để biết thêm chi tiết chính xác và đầy đủ nhất:\nWebsite MGF: mgfvn.com',
        },
        'Chính sách giao hàng': {
          'title': 'Chính sách giao hàng',
          'response':
              'Cảm ơn bạn đã liên hệ với MGF. Chúng tôi gửi bạn thông tin về Chính sách giao hàng của MGF như sau:',
        },
        'Thông tin nước mắm MGF': {
          'title': 'Thông tin nước mắm MGF',
          'response':
              'Cảm ơn bạn đã liên hệ với MGF. Chúng tôi gửi bạn thông tin chuẩn xác nhất về nước mắm của MGF như sau:\nNước mắm nhĩ cá cơm được sản xuất ở qui mô nhỏ, chỉ từ cá cơm tươi, không qua ướp lạnh.\nXem thêm...',
        },
      };

  @override
  Widget build(BuildContext context) {
    final chatInfo = _chatData[widget.topic] ?? _chatData.values.first;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              FigmaAssets.background,
              fit: BoxFit.cover,
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Header
                const CustomSupportHeader(
                  title: 'Hỗ trợ tư vấn MGF',
                ),

                // Chat content
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 12),

                      // Title
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 41),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Bạn cần hỗ trợ vấn đề gì?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.cProfileTitleRed,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 17),

                      // Divider line
                      Container(
                        height: 1,
                        color: AppColors.cProfileBorderGray,
                      ),

                      const SizedBox(height: 24),

                      // Chat messages
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // User's topic selection (right aligned, green)
                              Align(
                                alignment: Alignment.centerRight,
                                child: _buildUserMessage(chatInfo['title']!),
                              ),

                              const SizedBox(height: 8),

                              // Greeting message (left aligned, green)
                              Align(
                                alignment: Alignment.centerLeft,
                                child: _buildGreetingMessage(),
                              ),

                              const SizedBox(height: 8),

                              // Response message (left aligned, white)
                              Align(
                                alignment: Alignment.centerLeft,
                                child: _buildResponseMessage(
                                    chatInfo['response']!),
                              ),

                              const SizedBox(height: 120),
                            ],
                          ),
                        ),
                      ),

                      // Input field
                      _buildInputField(),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom navigation
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: HomeBottomNavigation(),
          ),
        ],
      ),
    );
  }

  Widget _buildUserMessage(String text) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 200),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF004917),
        border: Border.all(color: AppColors.cProfileBorderGray),
        borderRadius: BorderRadius.circular(44),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 10,
          color: Colors.white,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  Widget _buildGreetingMessage() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 200),
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF004917),
        border: Border.all(color: AppColors.cProfileBorderGray),
        borderRadius: BorderRadius.circular(44),
      ),
      child: const Text(
        'Xin chào, Nguyen Van A',
        style: TextStyle(
          fontSize: 10,
          color: Colors.white,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  Widget _buildResponseMessage(String text) {
    // Check if text contains website link
    final hasLink = text.contains('mgfvn.com');
    final hasSeeMore = text.contains('Xem thêm...');

    return Container(
      constraints: const BoxConstraints(maxWidth: 195),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.cProfileBorderGray),
        borderRadius: BorderRadius.circular(10),
      ),
      child: hasLink
          ? _buildLinkText(text)
          : hasSeeMore
              ? _buildSeeMoreText(text)
              : Text(
                  text,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    height: 1.5,
                  ),
                ),
    );
  }

  Widget _buildLinkText(String text) {
    final parts = text.split('Website MGF:');
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 10,
          color: Colors.black,
          fontFamily: 'Poppins',
          height: 1.5,
        ),
        children: [
          TextSpan(text: parts[0]),
          const TextSpan(
            text: 'Website MGF:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: ' ${parts[1].trim()}',
            style: const TextStyle(
              color: Color(0xFF1161F5),
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeeMoreText(String text) {
    final parts = text.split('Xem thêm...');
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 10,
          color: Colors.black,
          fontFamily: 'Poppins',
          height: 1.5,
        ),
        children: [
          TextSpan(text: parts[0]),
          const TextSpan(
            text: 'Xem thêm...',
            style: TextStyle(
              color: AppColors.cProfileTextGray,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          // Input field
          Expanded(
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.cProfileTextGray),
                borderRadius: BorderRadius.circular(44),
              ),
              child: TextField(
                controller: _messageController,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ),
                decoration: const InputDecoration(
                  hintText: 'Nhập tin nhắn',
                  hintStyle: TextStyle(
                    fontSize: 10,
                    color: AppColors.cProfilePlaceholder,
                    fontFamily: 'Poppins',
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 19, vertical: 10),
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Send button
          GestureDetector(
            onTap: () {
              // Handle send message
            },
            child: SvgPicture.asset(
              'assets/figma_exports/92f898c6afa4e605739c3f99284189c2ca21d489.svg',
              width: 45,
              height: 45,
            ),
          ),
        ],
      ),
    );
  }
}
