unit wordaddons;

interface

  {=== Стили линий таблицы ===}
  const wdLineStyleDashDot=5; //A dash followed by a dot.
  const wdLineStyleDashDotDot=6; //A dash followed by two dots.
  const wdLineStyleDashDotStroked= 20; //A dash followed by a dot stroke, thus rendering a border similar to a barber pole.
  const wdLineStyleDashLargeGap= 4; //A dash followed by a large gap.
  const wdLineStyleDashSmallGap= 3; //A dash followed by a small gap.
  const wdLineStyleDot= 2; //Dots.
  const wdLineStyleDouble= 7; //Double solid lines.
  const wdLineStyleDoubleWavy= 19; //Double wavy solid lines.
  const wdLineStyleEmboss3D= 21; //The border appears to have a 3-D embossed look.
  const wdLineStyleEngrave3D= 22; //The border appears to have a 3-D engraved look.
  const wdLineStyleInset= 24; //The border appears to be inset.
  const wdLineStyleNone= 0; //No border.
  const wdLineStyleOutset= 23; //The border appears to be outset.
  const wdLineStyleSingle= 1; //A single solid line.
  const wdLineStyleSingleWavy= 18; //A single wavy solid line.
  const wdLineStyleThickThinLargeGap= 16; //An internal single thick solid line surrounded by a single thin solid line with a large gap between them.
  const wdLineStyleThickThinMedGap= 13; //An internal single thick solid line surrounded by a single thin solid line with a medium gap between them.
  const wdLineStyleThickThinSmallGap= 10; //An internal single thick solid line surrounded by a single thin solid line with a small gap between them.
  const wdLineStyleThinThickLargeGap= 15; //An internal single thin solid line surrounded by a single thick solid line with a large gap between them.
  const wdLineStyleThinThickMedGap= 12; //An internal single thin solid line surrounded by a single thick solid line with a medium gap between them.
  const wdLineStyleThinThickSmallGap= 9; //An internal single thin solid line surrounded by a single thick solid line with a small gap between them.
  const wdLineStyleThinThickThinLargeGap= 17; //An internal single thin solid line surrounded by a single thick solid line surrounded by a single thin solid line with a large gap between all lines.
  const wdLineStyleThinThickThinMedGap= 14; //An internal single thin solid line surrounded by a single thick solid line surrounded by a single thin solid line with a medium gap between all lines.
  const wdLineStyleThinThickThinSmallGap= 11; //An internal single thin solid line surrounded by a single thick solid line surrounded by a single thin solid line with a small gap between all lines.
  const wdLineStyleTriple= 8; //Three solid thin lines.

  {=== Толщина линий ===}
  const wdLineWidth025pt=2; // 0.25 point.
  const wdLineWidth050pt=4; // 0.50 point.
  const wdLineWidth075pt=6; // 0.75 point.
  const wdLineWidth100pt=8; // 1.00 point. default.
  const wdLineWidth150pt=12; // 1.50 points.
  const wdLineWidth225pt=18; // 2.25 points.
  const wdLineWidth300pt=24; // 3.00 points.
  const wdLineWidth450pt=36; // 4.50 points.
  const wdLineWidth600pt=48; // 6.00 points.


  {=== Встроенные стили ===}
  const wdStyleBlockQuotation= -85; // Block Text.
  const wdStyleBodyText= -67; // Body Text.
  const wdStyleBodyText2= -81; // Body Text 2.
  const wdStyleBodyText3= -82; // Body Text 3.
  const wdStyleBodyTextFirstIndent= -78; // Body Text First Indent.
  const wdStyleBodyTextFirstIndent2= -79; // Body Text First Indent 2.
  const wdStyleBodyTextIndent= -68; // Body Text Indent.
  const wdStyleBodyTextIndent2= -83; // Body Text Indent 2.
  const wdStyleBodyTextIndent3= -84; // Body Text Indent 3.
  const wdStyleBookTitle= -265; // Book Title.
  const wdStyleCaption= -35; // Caption.
  const wdStyleClosing= -64; // Closing.
  const wdStyleCommentReference= -40; //Comment Reference.
  const wdStyleCommentText= -31; // Comment Text.
  const wdStyleDate= -77; // Date.
  const wdStyleDefaultParagraphFont= -66; // Default Paragraph Font.
  const wdStyleEmphasis= -89; // Emphasis.
  const wdStyleEndnoteReference= -43; // Endnote Reference.
  const wdStyleEndnoteText= -44; // Endnote Text.
  const wdStyleEnvelopeAddress= -37; // Envelope Address.
  const wdStyleEnvelopeReturn= -38; // Envelope Return.
  const wdStyleFooter= -33; // Footer.
  const wdStyleFootnoteReference= -39; // Footnote Reference.
  const wdStyleFootnoteText= -30; // Footnote Text.
  const wdStyleHeader= -32; // Header.
  const wdStyleHeading1= -2; // Heading 1.
  const wdStyleHeading2= -3; // Heading 2.
  const wdStyleHeading3= -4; // Heading 3.
  const wdStyleHeading4= -5; // Heading 4.
  const wdStyleHeading5= -6; // Heading 5.
  const wdStyleHeading6= -7; // Heading 6.
  const wdStyleHeading7= -8; // Heading 7.
  const wdStyleHeading8= -9; // Heading 8.
  const wdStyleHeading9= -10; //Heading 9.
  const wdStyleHtmlAcronym= -96; // HTML Acronym.
  const wdStyleHtmlAddress= -97; // HTML Address.
  const wdStyleHtmlCite= -98; // HTML Cite.
  const wdStyleHtmlCode= -99; // HTML Code.
  const wdStyleHtmlDfn= -100; // HTML Definition.
  const wdStyleHtmlKbd= -101; // HTML Keyboard.
  const wdStyleHtmlNormal= -95; // Normal (Web).
  const wdStyleHtmlPre= -102; // HTML Preformatted.
  const wdStyleHtmlSamp= -103; // HTML Sample.
  const wdStyleHtmlTt= -104; // HTML Typewriter.
  const wdStyleHtmlVar= -105; // HTML Variable.
  const wdStyleHyperlink= -86; // Hyperlink.
  const wdStyleHyperlinkFollowed= -87; // Followed Hyperlink.
  const wdStyleIndex1= -11; // Index 1.
  const wdStyleIndex2= -12; // Index 2.
  const wdStyleIndex3= -13; // Index 3.
  const wdStyleIndex4= -14; // Index 4.
  const wdStyleIndex5= -15; // Index 5.
  const wdStyleIndex6= -16; // Index 6.
  const wdStyleIndex7= -17; // Index 7.
  const wdStyleIndex8= -18; // Index 8.
  const wdStyleIndex9= -19; // Index 9.
  const wdStyleIndexHeading= -34; // Index Heading
  const wdStyleIntenseEmphasis= -262; // Intense Emphasis.
  const wdStyleIntenseQuote= -182; // Intense Quote.
  const wdStyleIntenseReference= -264; // Intense Reference.
  const wdStyleLineNumber= -41; // Line Number.
  const wdStyleList= -48; // List.
  const wdStyleList2= -51; // List 2.
  const wdStyleList3= -52; // List 3.
  const wdStyleList4= -53; // List 4.
  const wdStyleList5= -54; // List 5.
  const wdStyleListBullet= -49; // List Bullet.
  const wdStyleListBullet2= -55; // List Bullet 2.
  const wdStyleListBullet3= -56; // List Bullet 3.
  const wdStyleListBullet4= -57; // List Bullet 4.
  const wdStyleListBullet5= -58; // List Bullet 5.
  const wdStyleListContinue= -69; // List Continue.
  const wdStyleListContinue2= -70; // List Continue 2.
  const wdStyleListContinue3= -71; // List Continue 3.
  const wdStyleListContinue4= -72; // List Continue 4.
  const wdStyleListContinue5= -73; // List Continue 5.
  const wdStyleListNumber= -50; // List Number.
  const wdStyleListNumber2= -59; // List Number 2.
  const wdStyleListNumber3= -60; // List Number 3.
  const wdStyleListNumber4= -61; // List Number 4.
  const wdStyleListNumber5= -62; // List Number 5.
  const wdStyleListParagraph= -180; // List Paragraph.
  const wdStyleMacroText= -46; // Macro Text.
  const wdStyleMessageHeader= -74; // Message Header.
  const wdStyleNavPane= -90; // Document Map.
  const wdStyleNormal= -1; // Normal.
  const wdStyleNormalIndent= -29; // Normal Indent.
  const wdStyleNormalObject= -158; // Normal (applied to an object).
  const wdStyleNormalTable= -106; // Normal (applied within a table).
  const wdStyleNoteHeading= -80; // Note Heading.
  const wdStylePageNumber= -42; // Page Number.
  const wdStylePlainText= -91; // Plain Text.
  const wdStyleQuote= -181; // Quote.
  const wdStyleSalutation= -76; // Salutation.
  const wdStyleSignature= -65; // Signature.
  const wdStyleStrong= -88; // Strong.
  const wdStyleSubtitle= -75; // Subtitle.
  const wdStyleSubtleEmphasis= -261; // Subtle Emphasis.
  const wdStyleSubtleReference= -263; // Subtle Reference.
  const wdStyleTableColorfulGrid= -172; // Colorful Grid.
  const wdStyleTableColorfulList= -171; // Colorful List.
  const wdStyleTableColorfulShading= -170; // Colorful Shading.
  const wdStyleTableDarkList= -169; // Dark List.
  const wdStyleTableLightGrid= -161; // Light Grid.
  const wdStyleTableLightGridAccent1= -175; // Light Grid Accent 1.
  const wdStyleTableLightList= -160; // Light List.
  const wdStyleTableLightListAccent1= -174; // Light List Accent 1.
  const wdStyleTableLightShading= -159; // Light Shading.
  const wdStyleTableLightShadingAccent1= -173; // Light Shading Accent 1.
  const wdStyleTableMediumGrid1= -166; // Medium Grid 1.
  const wdStyleTableMediumGrid2= -167; // Medium Grid 2.
  const wdStyleTableMediumGrid3= -168; // Medium Grid 3.
  const wdStyleTableMediumList1= -164; // Medium List 1.
  const wdStyleTableMediumList1Accent1= -178; // Medium List 1 Accent 1.
  const wdStyleTableMediumList2= -165; // Medium List 2.
  const wdStyleTableMediumShading1= -162; // Medium Shading 1.
  const wdStyleTableMediumShading1Accent1= -176; // Medium Shading 1 Accent 1.
  const wdStyleTableMediumShading2= -163; // Medium Shading 2.
  const wdStyleTableMediumShading2Accent1= -177; // Medium Shading 2 Accent 1.
  const wdStyleTableOfAuthorities= -45; // Table of Authorities.
  const wdStyleTableOfFigures= -36; // Table of Figures.
  const wdStyleTitle= -63; // Title.
  const wdStyleTOAHeading= -47; // TOA Heading.
  const wdStyleTOC1= -20; // TOC 1.
  const wdStyleTOC2= -21; // TOC 2.
  const wdStyleTOC3= -22; // TOC 3.
  const wdStyleTOC4= -23; // TOC 4.
  const wdStyleTOC5= -24; // TOC 5.
  const wdStyleTOC6= -25; // TOC 6.
  const wdStyleTOC7= -26; // TOC 7.
  const wdStyleTOC8= -27; // TOC 8.
  const wdStyleTOC9= -28; // TOC 9.

  {=== Ширина символов ===}
  const wdWidthFullWidth=7;// Characters are displayed in full character width.
  const wdWidthHalfWidth=6;// Characters are displayed in half the character width.

  {=== Выравнивание ===}
  const wdAlignRowCenter=1;// Centered.
  const wdAlignRowLeft=0;// Left-aligned. Default.
  const wdAlignRowRight=2;// Right-aligned.


implementation

end.
 