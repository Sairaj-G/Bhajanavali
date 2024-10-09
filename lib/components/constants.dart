const urlPDF = "https://bhajanavali.github.io/book_compressed.pdf";
const urlBhajan = "https://bhajanavali.github.io/bhajan.mp3";
const urlRampath = "https://bhajanavali.github.io/rampath.mp3";

List<Map<String, dynamic>> files = [
  {"url": urlPDF, "name": "pdf", "size": "8123131"},
  {"url": urlBhajan, "name": "bhajan", "size": "48239266"},
  {"url": urlRampath, "name": "rampath", "size": "18605999"},
];


List<String> bhajanTitles = [
  "रामपाठ",
  "पूर्ण पंचपदी",
  "श्री हालसिद्धनाथ अष्टक",
  "भज सदगुरु राजं",
  "जय गुरु जय गुरु",
  "प्रार्थना ऐका माझी",
  "नामस्मरण",
  "आरती",
  "जय जय श्री हालसिद्धा",
  "येई येई बा",
  "भूमी आप तेज वायू",
  "माझी प्रार्थना ऐका प्रभुजी",
  "धाव धाव बा",
  "पायी तुझ्या मस्तक हे असावे"
];

List<Duration> bhajanStartDurations = [
  Duration.zero,
  Duration.zero,
  Duration.zero,
  Duration(minutes: 4, seconds: 45),
  Duration(minutes: 9, seconds: 18),
  Duration(minutes: 16, seconds: 34),
  Duration(minutes: 20, seconds: 32),
  Duration(minutes: 28, seconds: 00),
  Duration(minutes: 39, seconds: 10),
  Duration(minutes: 44, seconds: 00),
  Duration(minutes: 47, seconds: 10),
  Duration(minutes: 49, seconds: 44),
  Duration(minutes: 52, seconds: 16),
  Duration(minutes: 53, seconds: 1)
];

List<Duration> bhajanEndDurations = [
  Duration(minutes: 19, seconds: 20),
  Duration(minutes: 59, seconds: 56),
  Duration(minutes: 2, seconds: 0),
  Duration(minutes: 9, seconds: 18),
  Duration(minutes: 16, seconds: 34),
  Duration(minutes: 20, seconds: 32),
  Duration(minutes: 26, seconds: 14),
  Duration(minutes: 39, seconds: 09),
  Duration(minutes: 42, seconds: 57),
  Duration(minutes: 47, seconds: 10),
  Duration(minutes: 49, seconds: 44),
  Duration(minutes: 53, seconds: 01),
  Duration(minutes: 53, seconds: 01),
  Duration(minutes: 57, seconds: 13)
];

List<String> audioFilePath = [
  "/data/user/0/com.example.bhajanavali/app_flutter/rampath",
  "/data/user/0/com.example.bhajanavali/app_flutter/bhajan",
  "/data/user/0/com.example.bhajanavali/app_flutter/bhajan",
  "/data/user/0/com.example.bhajanavali/app_flutter/bhajan",
  "/data/user/0/com.example.bhajanavali/app_flutter/bhajan",
  "/data/user/0/com.example.bhajanavali/app_flutter/bhajan",
  "/data/user/0/com.example.bhajanavali/app_flutter/bhajan",
  "/data/user/0/com.example.bhajanavali/app_flutter/bhajan",
  "/data/user/0/com.example.bhajanavali/app_flutter/bhajan",
  "/data/user/0/com.example.bhajanavali/app_flutter/bhajan",
  "/data/user/0/com.example.bhajanavali/app_flutter/bhajan",
  "/data/user/0/com.example.bhajanavali/app_flutter/bhajan",
  "/data/user/0/com.example.bhajanavali/app_flutter/bhajan",
  "/data/user/0/com.example.bhajanavali/app_flutter/bhajan"
];

String pdfFilePath = "/data/user/0/com.example.bhajanavali/app_flutter/pdf";