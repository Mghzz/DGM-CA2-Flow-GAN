// From the project root: typst compile --root . --font-path DGM_Report_Template/Fonts DGM_Report_Template/main.typ DGM_Report_Template/main-typst.pdf
#import "dgm-homework.typ": homework-report, references

#show: homework-report.with(
  course: "مدل‌های مولد عمیق",
  homework: "۲",
  instructor: "دکتر مصطفی توسلی‌پور",
  student: "[نام و نام خانوادگی]",
  student-id: "۸۱۰۱۰۰۰۰۰",
  submission-date: "[تاریخ ارسال]",
  semester: "نیم‌سال اول ۱۴۰۵",
)

#include "problems/question1/question1.typ"
#include "problems/question2/question2.typ"
#references("references.bib")
