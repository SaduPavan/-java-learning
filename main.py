import sys
import os
from utils.docx_processor import process_docx, load_docx
from utils.grammar_corrector import correct_docx_paragraphs
from utils.confluence_uploader import upload_docx_to_confluence


def main(input_path):
    if not os.path.exists(input_path):
        print(f"File not found: {input_path}")
        return
    print("Loading document...")
    doc = load_docx(input_path)
    print("Correcting grammar and spelling...")
    correct_docx_paragraphs(doc)
    output_path = input_path.replace('.docx', '_professional.docx')
    print("Enhancing formatting...")
    doc.save(output_path)
    process_docx(output_path, output_path)  # Apply formatting
    print(f"Document processed and saved as {output_path}")
    print("Uploading to Confluence...")
    upload_docx_to_confluence(output_path)


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python main.py <input_docx_path>")
    else:
        main(sys.argv[1]) 