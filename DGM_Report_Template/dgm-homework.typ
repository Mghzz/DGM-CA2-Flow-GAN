#let accent = rgb("#4B5563")
#let muted = rgb("#6B7280")
#let rule = rgb("#9CA3AF")
#let light = rgb("#F3F4F6")

#let persian-number(n) = str(n).codepoints().map(digit =>
  "۰۱۲۳۴۵۶۷۸۹".codepoints().at(int(digit))
).join()
#let section-number(..numbers) = numbers.pos().map(persian-number).join(".")
#let lr(body) = text(font: "Liberation Serif", size: 0.857em, lang: "en", dir: ltr)[\u{2066}#body\u{2069}]

#let cover(course, homework, instructor, student, student-id, submission-date, semester) = {
  let line(y, size, body, fill: black, weight: "bold") = place(
    top + center, dy: y, text(size: size, weight: weight, fill: fill, body),
  )

  place(top + left, dx: 4pt, dy: 12pt, image(
    "images/eng-logo.png", width: 30mm, alt: "نشان پردیس دانشکدگان فنی",
  ))
  place(top + right, dx: -8.2pt, dy: 12pt, image(
    "images/ut-logo.png", width: 27mm, alt: "نشان دانشگاه تهران",
  ))
  line(5pt, 16.7pt, [به نام خدا])
  line(50pt, 16.7pt, [دانشگاه تهران])
  line(81pt, 16.7pt, [پردیس دانشکدگان فنی])
  line(116pt, 16.7pt, [دانشکده مهندسی برق و کامپیوتر])
  line(229pt, 30.2pt, [درس #course], fill: accent)
  line(292pt, 20.1pt, [گزارش تمرین شماره #homework])
  line(371pt, 16.7pt, [استاد درس: #instructor])
  place(top + center, dy: 441pt, table(
    columns: (142pt, 262pt),
    rows: 32.7pt,
    inset: (x: 10pt, top: 5pt, bottom: 0pt),
    align: center + horizon,
    stroke: 0.4pt + rule,
    fill: (x, _) => if x == 0 { light },
    [*نام و نام خانوادگی*], student,
    [*شماره دانشجویی*], student-id,
    [*تاریخ ارسال گزارش*], submission-date,
  ))
  line(664pt, 13.95pt, semester, fill: muted, weight: "regular")
}

#let question(body) = {
  pagebreak(weak: true)
  heading(level: 1, body)
}

#let comparison-table(columns: auto, headers, ..cells) = {
  table(
    columns: if columns == auto { headers.len() } else { columns },
    inset: (x: 10pt, y: 5.5pt),
    align: center + horizon,
    stroke: none,
    fill: (_, y) => if y == 0 { accent } else if calc.odd(y) { light },
    table.hline(stroke: 0.65pt + rule),
    table.header(..headers.map(header => text(fill: white, weight: "bold", header))),
    table.hline(stroke: 0.5pt + rule),
    ..cells.pos(),
    table.hline(stroke: 1pt + rule),
  )
}

#let listing-theme = bytes(```xml
<?xml version="1.0" encoding="UTF-8"?>
<plist version="1.0">
  <dict>
    <key>name</key><string>DGM report</string>
    <key>settings</key>
    <array>
      <dict>
        <key>scope</key><string>keyword, storage</string>
        <key>settings</key>
        <dict>
          <key>foreground</key><string>#4B5563</string>
          <key>fontStyle</key><string>bold</string>
        </dict>
      </dict>
      <dict>
        <key>scope</key><string>string</string>
        <key>settings</key><dict><key>foreground</key><string>#4B5563</string></dict>
      </dict>
      <dict>
        <key>scope</key><string>comment</string>
        <key>settings</key><dict><key>foreground</key><string>#6B7280</string></dict>
      </dict>
    </array>
  </dict>
</plist>
```.text)

#let listing(source, lang: "python") = {
  set text(dir: ltr)
  set align(left)
  set par(leading: 5pt, justify: false)
  show raw: set text(font: "Liberation Mono", size: 10pt)
  block(
    width: 100%, fill: light, stroke: 0.4pt + rule, inset: 3pt,
    above: 6pt, below: 8pt,
    raw(source, lang: lang, block: true, tab-size: 4, theme: listing-theme),
  )
}

#let references(sources) = {
  pagebreak(weak: true)
  heading(numbering: none)[مراجع]
  v(9pt)
  set text(font: "Liberation Serif", size: 12pt, lang: "en", dir: ltr)
  set par(justify: false)
  bibliography(sources, title: none, style: "ieee", full: true)
}

#let homework-report(
  course: "مدل‌های مولد عمیق",
  homework: "۲",
  instructor: "دکتر مصطفی توسلی‌پور",
  student: "[نام و نام خانوادگی]",
  student-id: "۸۱۰۱۰۰۰۰۰",
  submission-date: "[تاریخ ارسال]",
  semester: "نیم‌سال اول ۱۴۰۵",
  body,
) = {
  set document(title: "گزارش تمرین — " + course, author: student)
  set text(font: "B Nazanin", size: 13.95pt, lang: "fa", dir: rtl)
  set par(justify: true, leading: 0.84em, spacing: 5pt)
  set page(
    paper: "a4",
    margin: (left: 23mm, right: 23mm, top: 23mm, bottom: 22mm),
    background: align(center + horizon, rect(
      width: 193mm, height: 280mm, stroke: 0.4pt + accent,
    )),
    numbering: (current, ..) => persian-number(current),
    number-align: center + bottom,
    footer-descent: 24%,
  )

  set heading(numbering: section-number)
  show heading: it => context {
    let size = (20.1pt, 16.7pt, 13.95pt).at(calc.min(it.level, 3) - 1)
    let above = (18pt, 15pt, 10pt).at(calc.min(it.level, 3) - 1)
    let title = text(
      size: size, weight: "bold", fill: accent,
      if it.numbering == none { it.body } else {
        let number = numbering(it.numbering, ..counter(heading).at(it.location()))
        let prefix = if it.level == 1 { [سوال #number] } else { number }
        [#prefix#h(1em)#it.body]
      },
    )
    block(above: above, below: 10pt, sticky: true, move(
      dy: if it.level == 1 { -7pt } else { -3pt },
      title,
    ))
  }

  show outline.entry: it => {
    set par(justify: false)
    let entry = if it.level == 1 {
      let title = if it.prefix() == none { it.body() } else {
        [#box(it.prefix())#h(1em)#it.body()]
      }
      strong(grid(columns: (1fr, auto), column-gutter: 1em, title, it.page()))
    } else {
      // Keep the page number in its own column so that Latin titles cannot
      // reorder it or the leaders in the right-to-left outline.
      pad(right: (21pt, 52pt).at(it.level - 2), grid(
        columns: (26pt, auto, 1fr, auto),
        column-gutter: 5pt,
        it.prefix(),
        it.body(),
        box(width: 100%, it.fill),
        it.page(),
      ))
    }
    block(
      above: if it.level == 1 { 14pt } else { 9pt },
      below: 4pt,
      link(it.element.location(), entry),
    )
  }
  set outline.entry(fill: repeat([.], gap: 0.45em))
  set enum(numbering: n => persian-number(n) + ".")
  set figure(numbering: persian-number, gap: 8pt)
  show figure.where(kind: image): set figure(supplement: [شکل])
  show figure.where(kind: table): set figure(supplement: [جدول])
  show figure.where(kind: table): set figure.caption(position: top)
  set figure.caption(separator: [: ])
  set math.equation(
    numbering: n => [\(#persian-number(n)\)],
    number-align: right + horizon,
    supplement: [رابطه],
  )
  show math.equation: set text(size: 12pt)

  page(numbering: none, cover(
    course, homework, instructor, student, student-id, submission-date, semester,
  ))
  counter(page).update(1)
  outline(title: [فهرست مطالب], depth: 3)
  body
}
