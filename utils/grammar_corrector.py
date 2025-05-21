import language_tool_python


def correct_text(text):
    tool = language_tool_python.LanguageTool('en-US')
    matches = tool.check(text)
    return language_tool_python.utils.correct(text, matches)


def correct_docx_paragraphs(doc):
    for paragraph in doc.paragraphs:
        if paragraph.text.strip():
            corrected = correct_text(paragraph.text)
            if corrected != paragraph.text:
                paragraph.text = corrected
    # Also correct text in tables
    for table in doc.tables:
        for row in table.rows:
            for cell in row.cells:
                for paragraph in cell.paragraphs:
                    if paragraph.text.strip():
                        corrected = correct_text(paragraph.text)
                        if corrected != paragraph.text:
                            paragraph.text = corrected 