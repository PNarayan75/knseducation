import 'package:flutter/material.dart';
import 'package:flutter_website/components/components.dart';
RichText slide1Text = RichText(
  text: const TextSpan(
    children: <TextSpan>[
      TextSpan(text: 'Prepare for ', style: carouselBlueTextStyle),
      TextSpan(text: 'IIT-JEE & NEET ', style: carouselWhiteTextStyle),
      TextSpan(text: 'with experts', style: carouselBlueTextStyle)
    ],
  ),
  textAlign: TextAlign.center,
);

RichText slide2Text = RichText(
  text: const TextSpan(
    children: <TextSpan>[
      TextSpan(text: 'Master ', style: carouselWhiteTextStyle),
      TextSpan(text: 'Science & Math', style: carouselBlueTextStyle),
    ],
  ),
  textAlign: TextAlign.center,
);

RichText slide3Text = RichText(
  text: const TextSpan(
    children: <TextSpan>[
      TextSpan(text: 'Live & Recorded ', style: carouselBlueTextStyle),
      TextSpan(text: 'Classes ', style: carouselWhiteTextStyle),
      TextSpan(text: 'by Top Faculty', style: carouselBlueTextStyle)
    ],
  ),
  textAlign: TextAlign.center,
);

RichText slide4Text = RichText(
  text: const TextSpan(
    children: <TextSpan>[
      TextSpan(text: 'Join ', style: carouselBlueTextStyle),
      TextSpan(text: 'Class 9–12 Coaching ', style: carouselWhiteTextStyle),
      TextSpan(text: 'Now!', style: carouselBlueTextStyle)
    ],
    style: TextStyle(height: 1.1),
  ),
  textAlign: TextAlign.center,
);
