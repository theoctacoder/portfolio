import 'package:flutter/material.dart';
import 'package:portfolio/res/app_colors.dart';

class Links {
  static const email = 'audichyabhavesh33@gmail.com';
  static const linkedIn = 'https://linkedin.com/in/audibhavesh';
  static const github = 'https://github.com/audibhavesh';
  static const stackOverflow =
      'https://stackoverflow.com/users/8818996/bhavesh-audichya';
  static const resumeAsset = 'assets/resume/bhavesh_auodichya_resume.pdf';
}

class Stat {
  final String value;
  final String label;
  const Stat(this.value, this.label);
}

const heroStats = [
  Stat('6+', 'years shipping to production'),
  Stat('15+', 'banks running my CRM engine'),
  Stat('20L+', 'bank customers onboarded'),
  Stat('9', 'device types driven from Android'),
];

// ───────────────────────── DBU ─────────────────────────

class DbuBadge {
  final String label;
  final String detail;
  final Color color;
  final String? url;
  const DbuBadge(this.label, this.detail, this.color, {this.url});
}

const gff2026Url =
    'https://www.linkedin.com/posts/hitachi-gff2026-teamwork-ugcPost-7505590307963502592-v9Xn/';

const dbuBadges = [
  DbuBadge('LIVE', 'Axis Bank · 10+ sites', AppColors.primary),
  DbuBadge('LIVE', 'slice · 5+ sites', AppColors.primary),
  DbuBadge('GFF 2025', 'DBU 1.0 showcased', AppColors.amber),
  DbuBadge('GFF 2026', 'DBU 2.0 showcased', AppColors.amber, url: gff2026Url),
];

class ArchNode {
  final String title;
  final String subtitle;
  const ArchNode(this.title, this.subtitle);
}

class ArchLayer {
  final String tag;
  final String name;
  final Color color;
  final List<ArchNode> nodes;
  const ArchLayer(this.tag, this.name, this.color, this.nodes);
}

const dbuArchitecture = [
  ArchLayer('L4', 'interaction', AppColors.pink, [
    ArchNode('Touch UI', 'assisted + self-service'),
    ArchNode('Whisper', 'on-device speech · EN / HI'),
    ArchNode('Gemma 2B Agent', 'on-device LLM, no cloud'),
  ]),
  ArchLayer('L3', 'application', AppColors.cyan, [
    ArchNode('DBU App', 'Kotlin + Java · multi-module MVVM'),
    ArchNode('Accessibility Navigator', 'agent drives the UI end to end'),
    ArchNode('CRM Vault', 'cashier-less cash flows'),
  ]),
  ArchLayer('L2', 'device services · AIDL', AppColors.violet, [
    ArchNode('9 bound services', 'one per device class over Android IPC'),
    ArchNode('Custom SDKs', 'USB · Serial/RS-232 · Bluetooth · JNI/NDK'),
  ]),
];

const dbuDevices = [
  'Document printer',
  'Cheque printer',
  'Passbook printer',
  'Receipt printer',
  'Evolis card printer',
  'Cheque deposit · Reiner',
  'Document scanner',
  'Fingerprint scanner',
  'POS terminal',
];

const dbuAgentJourneys = [
  'Savings Account',
  'Credit Card',
  'Cheque Deposit',
  'Passbook Printing',
];

enum MediaKind { video, post, web }

class MediaItem {
  final String source;
  final String title;
  final String caption;
  final String url;
  final MediaKind kind;
  final Color color;
  const MediaItem({
    required this.source,
    required this.title,
    required this.caption,
    required this.url,
    required this.kind,
    required this.color,
  });
}

const dbuMedia = [
  MediaItem(
    source: 'Axis Bank',
    title: 'Express Banking — India\'s first Digital Banking Point',
    caption:
        '24×7 lobby: account opening, instant cards, cheque deposit, '
        'passbook printing.',
    url: 'https://www.linkedin.com/posts/axis-bank_axisbank-hitachipaymentservices-expressbanking-activity-7390377910366363648-zIs0',
    kind: MediaKind.video,
    color: Color(0xFFE11D74),
  ),
  MediaItem(
    source: 'Hitachi Payment Services',
    title: 'slice one — AI-powered self-service banking kiosk',
    caption:
        'Card printer, cheque depositor, passbook printer and NFC in one '
        'modular unit.',
    url: 'https://www.linkedin.com/posts/hitachi-payment-services-pvt-ltd_sliceone-digitalbanking-fintech-activity-7465659797715972096-xzEm',
    kind: MediaKind.video,
    color: AppColors.cyan,
  ),
  MediaItem(
    source: 'slice',
    title: 'A new way to bank — slice\'s first AI-powered branch',
    caption: 'Launched in Guwahati with the Chief Minister of Assam.',
    url: 'https://www.linkedin.com/posts/a-new-way-to-bank-begins-today-we-launched-ugcPost-7462426911584043008-woQq/',
    kind: MediaKind.post,
    color: AppColors.violet,
  ),
  MediaItem(
    source: 'hitachi-payments.com',
    title: 'Digital Banking Point 2.0',
    caption: 'The official product page for the platform.',
    url: 'https://www.hitachi-payments.com/cash-solutions/digital-banking-point/',
    kind: MediaKind.web,
    color: AppColors.amber,
  ),
  MediaItem(
    source: 'Hitachi Payment Services',
    title: 'Hitachi at Global Fintech Fest 2026',
    caption: 'Where DBU 2.0 and the SideCar kiosk were showcased.',
    url: gff2026Url,
    kind: MediaKind.post,
    color: AppColors.primary,
  ),
  MediaItem(
    source: 'Hitachi Payment Services',
    title: 'NCMC Card Dispenser Kiosk 2.0',
    caption:
        'Self-service card issuance, personalisation and recharge for '
        'transit commuters.',
    url: 'https://www.linkedin.com/posts/ncmc-hitachipaymentservices-ncmccard-share-7510226084404170752-EJ-z/',
    kind: MediaKind.post,
    color: AppColors.pink,
  ),
];

// ─────────────────────── Experience ───────────────────────

class Highlight {
  final String lead;
  final String text;
  const Highlight(this.lead, this.text);
}

class Job {
  final String hash;
  final String branch;
  final String company;
  final String role;
  final String period;
  final String location;
  final List<Highlight> highlights;
  const Job({
    required this.hash,
    required this.branch,
    required this.company,
    required this.role,
    required this.period,
    required this.location,
    required this.highlights,
  });
}

const jobs = [
  Job(
    hash: 'a7f3e21',
    branch: 'HEAD -> abstract-layers',
    company: 'Abstract Layers',
    role: 'Mobile Frontend Lead',
    period: 'Jun 2025 — Present',
    location: 'Navi Mumbai',
    highlights: [
      Highlight(
        'Team leadership',
        'Lead a 5-member team at Abstract Layers and led a 4-member team onsite at Hitachi Payments to deliver the DBU platform.',
      ),
      Highlight(
        'Hitachi Digital Banking Unit',
        'Architected and hands-on built every module of India\'s pioneering Android-based DBU, live at Axis Bank (10+ sites) and slice (5+ sites).',
      ),
      Highlight(
        'On-device conversational AI',
        'Gemma 2B + local Whisper (English & Hindi) + an Accessibility Service that completes banking journeys by voice or text.',
      ),
      Highlight(
        'Hardware R&D & Android SDKs',
        'Built SDKs over USB, serial, Bluetooth and JNI/NDK where no vendor support existed — including the first Android SDK for Reiner cheque scanners.',
      ),
      Highlight(
        'SideCar kiosk',
        'Self-service instant card issuance kiosk across 7 banks; wrote the ESP32 firmware for motors, LEDs and peripherals.',
      ),
      Highlight(
        'Multi-bank CRM & Vault',
        'Re-architected the Android CRM into a configurable engine across 15+ banks; the DBU Vault lets slice move INR 30+ lakh/month without a cashier.',
      ),
      Highlight(
        'Rust telemetry SDK',
        'Embeddable cross-platform SDK for device ops, remote push and health monitoring — in pilot with Abner and others.',
      ),
      Highlight(
        'Abner partner platform',
        'Flutter Web B2B platform that moved Abner\'s entire sales and partner operations online.',
      ),
    ],
  ),
  Job(
    hash: '4c19b8d',
    branch: 'fermion-infotech',
    company: 'Fermion Infotech',
    role: 'Sr. Mobile Application Developer / AI Developer',
    period: 'Jul 2022 — May 2025',
    location: 'Navi Mumbai',
    highlights: [
      Highlight(
        'Liveness detection SDK',
        'Image processing + TensorFlow models for sub-minute identity verification at 95% accuracy.',
      ),
      Highlight(
        'Sony · Shark Tank India',
        'LLM chatbot over episodes, contestants and deals, plus an LLM-based ATS that automated 90% of screening.',
      ),
      Highlight(
        'DGV Connect',
        'Marketplace app for dairy farmers — 70% lift in digital adoption across 80,000+ farmers.',
      ),
      Highlight(
        'DGV Money',
        'Loan-processing SaaS with e-KYC, e-Sign, e-NACH for HDFC, Federal, Kotak & Karnataka Bank; shown at G20 and GFF.',
      ),
      Highlight(
        'DGV Pay',
        'Payments on 5,000+ POS devices — Card, AEPS, IMPS and Micro ATM.',
      ),
      Highlight(
        'Utkarsh SFB',
        'U-Instant and DigiOnBoarding apps in Flutter, onboarding 20 lakh+ customers.',
      ),
      Highlight(
        'Mentorship',
        'Mentored 5 junior Android developers through weekly reviews and knowledge sessions.',
      ),
    ],
  ),
  Job(
    hash: '9e0d2a4',
    branch: 'freelance',
    company: 'Freelancer',
    role: 'Full Stack Developer',
    period: 'Jan 2021 — Jul 2022',
    location: 'Thane',
    highlights: [
      Highlight(
        'Heaven',
        'Mental-health social platform on Flutter, Spring Boot and AWS with Docker + Jenkins CI/CD.',
      ),
      Highlight(
        'Payroll system',
        'Custom payroll and staff management for a local business.',
      ),
    ],
  ),
  Job(
    hash: '1b5c7f0',
    branch: 'herten',
    company: 'Herten Technologies',
    role: 'Junior Software Developer',
    period: 'Aug 2020 — Jan 2021',
    location: 'Navi Mumbai',
    highlights: [
      Highlight(
        'Bada Business CMS',
        'Kept a CodeIgniter CMS stable for 50,000+ users.',
      ),
      Highlight(
        'School SaaS',
        'Laravel SaaS on AWS Elasticsearch, RDS and S3.',
      ),
    ],
  ),
];

// ──────────────────────── Builds ────────────────────────

enum BuildTag { hardware, ai, android, flutter, platform }

extension BuildTagLabel on BuildTag {
  String get label => switch (this) {
    BuildTag.hardware => 'hardware',
    BuildTag.ai => 'ai',
    BuildTag.android => 'android',
    BuildTag.flutter => 'flutter',
    BuildTag.platform => 'platform',
  };
}

class BuildItem {
  final String title;
  final String org;
  final String summary;
  final String metric;
  final List<String> stack;
  final Set<BuildTag> tags;
  final String? image;
  final String? url;
  const BuildItem({
    required this.title,
    required this.org,
    required this.summary,
    required this.metric,
    required this.stack,
    required this.tags,
    this.image,
    this.url,
  });
}

const builds = [
  BuildItem(
    title: 'SideCar Kiosk',
    org: 'Abstract Layers',
    summary: 'Self-service kiosk for instant credit and debit card issuance. Android front end plus ESP32 firmware driving motorised card dispensing, LEDs and peripherals.',
    metric: '7 banks in production',
    stack: ['Kotlin', 'ESP32', 'C++', 'Serial'],
    tags: {BuildTag.hardware, BuildTag.android},
  ),
  BuildItem(
    title: 'Rust Telemetry SDK',
    org: 'Abstract Layers',
    summary: 'Embeddable SDK for Windows, Linux, macOS, iOS and Android giving vendors centralised device operations, remote push and real-time health monitoring.',
    metric: '5 platforms · 1 core',
    stack: ['Rust', 'FFI', 'Android', 'iOS'],
    tags: {BuildTag.platform},
  ),
  BuildItem(
    title: 'Multi-Bank CRM + Vault',
    org: 'Abstract Layers',
    summary: 'Configurable Android CRM engine for UPI, card, cash, account opening and government schemes, plus a secure Vault bridge to the DBU that removes cashier dependency.',
    metric: '15+ banks · ₹30L+/month',
    stack: ['Kotlin', 'MVVM', 'AIDL'],
    tags: {BuildTag.android},
  ),
  BuildItem(
    title: 'Abner Partner Platform',
    org: 'Abstract Layers',
    summary: 'Flutter Web B2B platform with Channel Partner, Key Account Manager, Lead Management and Order Tracking modules.',
    metric: '100% of ops moved online',
    stack: ['Flutter Web', 'Dart'],
    tags: {BuildTag.flutter},
    url: 'https://abnerlighting.com/',
  ),
  BuildItem(
    title: 'Liveness Detection SDK',
    org: 'Fermion Infotech',
    summary: 'Anti-spoofing identity verification using image processing and TensorFlow models, embedded into onboarding flows.',
    metric: '95% accuracy · <1 min',
    stack: ['TensorFlow', 'Kotlin', 'CV'],
    tags: {BuildTag.ai, BuildTag.android},
  ),
  BuildItem(
    title: 'Shark Tank India LLM',
    org: 'Sony · Fermion',
    summary: 'LLM chatbot covering episodes, contestants and deals, plus a custom LLM-based ATS for contestant screening.',
    metric: '90% screening automated',
    stack: ['LLM', 'Python', 'RAG'],
    tags: {BuildTag.ai},
  ),
  BuildItem(
    title: 'DGV Money',
    org: 'DGV',
    summary: 'Loan-processing SaaS with Aadhaar e-KYC, e-Sign, e-NACH and offline support for HDFC, Federal, Kotak and Karnataka Bank. Shown at G20 and GFF.',
    metric: '5,000+ loans / month',
    stack: ['Android', 'e-KYC', 'Offline-first'],
    tags: {BuildTag.android},
    image: 'assets/images/dgv_money.png',
    url: 'https://www.dgv.in/index.html#/money',
  ),
  BuildItem(
    title: 'DGV Connect',
    org: 'DGV',
    summary: 'Play Store marketplace for dairy farmers combining livestock management, breed discovery and embedded bovine loans.',
    metric: '80,000+ farmers',
    stack: ['Android', 'Marketplace', 'Lending'],
    tags: {BuildTag.android},
    image: 'assets/images/dgv_connect.png',
    url:
        'https://play.google.com/store/apps/details?id=com.dgvconnect&hl=en_IN',
  ),
  BuildItem(
    title: 'DGV Pay',
    org: 'DGV',
    summary: 'Payments app for field POS devices across multiple states — Card, AEPS, IMPS and Micro ATM.',
    metric: '5,000+ POS devices',
    stack: ['Android', 'POS', 'AEPS'],
    tags: {BuildTag.android, BuildTag.hardware},
    image: 'assets/images/dgv_pay.png',
    url: 'https://www.dgv.in/index.html#/pay',
  ),
  BuildItem(
    title: 'Digital Bovine Insurance',
    org: 'DGV',
    summary: 'TensorFlow models for cattle identification and body measurement that power insurance claims.',
    metric: '80% faster claims',
    stack: ['TensorFlow', 'CV', 'Android'],
    tags: {BuildTag.ai, BuildTag.android},
    image: 'assets/images/dgv_dbi.png',
    url: 'https://www.dgv.in/index.html#/insurance',
  ),
  BuildItem(
    title: 'U-Instant · Utkarsh SFB',
    org: 'Fermion Infotech',
    summary: 'Customer onboarding app and agent-facing DigiOnBoarding app for Utkarsh Small Finance Bank.',
    metric: '20 lakh+ customers',
    stack: ['Flutter', 'e-KYC'],
    tags: {BuildTag.flutter},
    image: 'assets/images/utkarsh_uinstant.webp',
    url: 'https://www.utkarsh.bank/',
  ),
  BuildItem(
    title: 'Heaven',
    org: 'Freelance',
    summary: 'Mental-health focused social platform with automated testing and deployment pipelines.',
    metric: 'Full stack · solo',
    stack: ['Flutter', 'Spring Boot', 'AWS', 'Jenkins'],
    tags: {BuildTag.flutter, BuildTag.platform},
  ),
];

// ────────────────────── Open source ──────────────────────

class OpenSourceItem {
  final String name;
  final String registry;
  final String description;
  final String url;
  final String? sourceUrl;
  final String language;
  final Color color;
  const OpenSourceItem({
    required this.name,
    required this.registry,
    required this.description,
    required this.url,
    this.sourceUrl,
    required this.language,
    required this.color,
  });
}

const openSource = [
  OpenSourceItem(
    name: 'flutter_env_manager',
    registry: 'pub.dev',
    description: 'YAML-driven environment configs that generate typed Dart classes, with multi-env and pubspec version support.',
    url: 'https://pub.dev/packages/flutter_env_manager',
    sourceUrl: 'https://github.com/audibhavesh/flutter_env_manager',
    language: 'Dart',
    color: AppColors.cyan,
  ),
  OpenSourceItem(
    name: 'android-architecture-cli',
    registry: 'npm',
    description: 'Project templates for Hilt, Dagger, Flutter-Bloc and Flutter-Provider. Cuts project setup time by 80%.',
    url: 'https://www.npmjs.com/package/android-architecture-cli',
    sourceUrl: 'https://github.com/audibhavesh/android-architecture-cli',
    language: 'JavaScript',
    color: AppColors.amber,
  ),
  OpenSourceItem(
    name: 'Puzzle Paws',
    registry: 'App Store',
    description: 'A pet-themed puzzle game for iOS built with SwiftUI.',
    url: 'https://apps.apple.com/in/app/puzzle-paws/id6587583492',
    language: 'Swift',
    color: AppColors.pink,
  ),
  OpenSourceItem(
    name: 'Mem Match',
    registry: 'Google Play',
    description:
        'Cross-platform memory training game with multiple difficulty levels.',
    url: 'https://play.google.com/store/apps/details?id=com.theoctacoder.memmatch',
    language: 'Flutter',
    color: AppColors.primary,
  ),
];

// ──────────────────────── Skills ────────────────────────

class SkillGroup {
  final String key;
  final Color color;
  final List<String> items;
  const SkillGroup(this.key, this.color, this.items);
}

const skillGroups = [
  SkillGroup('android', AppColors.primary, [
    'Kotlin',
    'Java',
    'Jetpack Compose',
    'XML Views',
    'MVVM',
    'Multi-module',
    'Hilt / Dagger',
    'Coroutines / Flow',
    'Room',
    'Retrofit',
    'WorkManager',
  ]),
  SkillGroup('platform_hardware', AppColors.violet, [
    'AIDL / IPC',
    'Accessibility Services',
    'USB Host API',
    'Serial / RS-232',
    'Bluetooth',
    'JNI / NDK',
    'ESP32 firmware',
  ]),
  SkillGroup('on_device_ai', AppColors.pink, [
    'Gemma 2B',
    'Whisper',
    'LLM Agents',
    'TensorFlow',
    'Computer Vision',
  ]),
  SkillGroup('cross_platform', AppColors.cyan, [
    'Flutter / Dart',
    'Rust',
    'Swift / iOS',
    'Python',
    'Spring Boot',
    'Firebase',
    'AWS',
    'Docker',
    'Jenkins',
  ]),
  SkillGroup('domain', AppColors.amber, [
    'Banking kiosks',
    'UPI',
    'Card & cash',
    'AEPS',
    'IMPS',
    'Micro ATM',
    'e-KYC',
    'e-Sign',
    'e-NACH',
  ]),
];
