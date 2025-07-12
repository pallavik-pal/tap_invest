import 'package:flutter/material.dart';

class BondSearchCard extends StatelessWidget {
  final String logo;
  final String isin;
  final String rating;
  final String company;
  final String searchTerm;
  final VoidCallback onTap;

  const BondSearchCard({
    super.key,
    required this.logo,
    required this.isin,
    required this.rating,
    required this.company,
    required this.searchTerm,
    required this.onTap,
  });

  /// Highlighting logic with optional style for last 4 characters
  List<TextSpan> _highlightMatchWithLast4(
      String text, String query, int last4StartIndex) {
    final searchWords = query
        .toLowerCase()
        .split(RegExp(r'\s+'))
        .where((word) => word.trim().isNotEmpty)
        .toList();

    if (searchWords.isEmpty) {
      return [
        TextSpan(
          text: text.substring(0, last4StartIndex),
          style: TextStyle(color: Colors.grey.shade800),
        ),
        TextSpan(
          text: text.substring(last4StartIndex),
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        )
      ];
    }

    final spans = <TextSpan>[];
    String lowerText = text.toLowerCase();
    int start = 0;

    while (start < text.length) {
      int closestMatchIndex = text.length;
      String? matchWord;

      for (var word in searchWords) {
        final index = lowerText.indexOf(word, start);
        if (index != -1 && index < closestMatchIndex) {
          closestMatchIndex = index;
          matchWord = word;
        }
      }

      if (matchWord == null) {
        spans.add(TextSpan(
          text: text.substring(start),
          style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: start >= last4StartIndex ? 17 : null,
            fontWeight: start >= last4StartIndex ? FontWeight.bold : null,
          ),
        ));
        break;
      }

      if (closestMatchIndex > start) {
        spans.add(TextSpan(
          text: text.substring(start, closestMatchIndex),
          style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: start >= last4StartIndex ? 17 : null,
            fontWeight: start >= last4StartIndex ? FontWeight.bold : null,
          ),
        ));
      }

      final isInLast4 = closestMatchIndex >= last4StartIndex;
      spans.add(TextSpan(
        text: text.substring(
            closestMatchIndex, closestMatchIndex + matchWord.length),
        style: TextStyle(
          backgroundColor: const Color(0xFFFFF1D0),
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: isInLast4 ? 17 : null,
        ),
      ));

      start = closestMatchIndex + matchWord.length;
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    final last4Start = isin.length - 4;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Logo with grey border
              Container(
                width: 44,
                height: 44,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade600, width: 1.2),
                ),
                child: logo.isNotEmpty
                    ? CircleAvatar(
                  backgroundImage: NetworkImage(logo),
                  backgroundColor: Colors.grey[200],
                  onBackgroundImageError: (_, __) =>
                  const Icon(Icons.broken_image),
                )
                    : const CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Text(
                    "INFRA",
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Bond info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ISIN with last 4 digits bold and searchable
                    RichText(
                      text: TextSpan(
                        children:
                        _highlightMatchWithLast4(isin, searchTerm, last4Start),
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Rating • Company (same line)
                    Row(
                      children: [
                        Text(
                          rating,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "•",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: _highlightMatchWithLast4(
                                  company, searchTerm, company.length),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Icon(Icons.chevron_right, color: Colors.grey.shade600),
            ],
          ),
        ),
      ),
    );
  }
}

