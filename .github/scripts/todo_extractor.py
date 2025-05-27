#!/usr/bin/env python3
"""
TODO Extractor Script
Scans code files for TODO comments and generates a markdown report.
"""

import os
import re
from datetime import datetime
from pathlib import Path

# Common code file extensions
CODE_EXTENSIONS = {
    ".py",
    ".js",
    ".ts",
    ".jsx",
    ".tsx",
    ".java",
    ".cpp",
    ".cc",
    ".cxx",
    ".c",
    ".h",
    ".hpp",
    ".cs",
    ".php",
    ".rb",
    ".go",
    ".rs",
    ".swift",
    ".kt",
    ".scala",
    ".sh",
    ".bash",
    ".zsh",
    ".ps1",
    ".r",
    ".R",
    ".m",
    ".pl",
    ".lua",
    ".dart",
    ".vue",
    ".svelte",
    ".html",
    ".css",
    ".scss",
    ".sass",
    ".less",
    ".sql",
    ".nix",
}


def find_todos(directory=".", output_file="TODO.md"):
    """
    Scan directory for TODO comments and generate markdown report.

    Args:
        directory (str): Directory to scan (default: current directory)
        output_file (str): Output markdown file name
    """
    todos = []

    # Walk through all files in directory
    for root, dirs, files in os.walk(directory):
        # Skip common non-code directories
        dirs[:] = [
            d
            for d in dirs
            if not d.startswith(".")
            and d
            not in {
                "node_modules",
                "__pycache__",
                "build",
                "dist",
                "target",
                "bin",
                "obj",
            }
        ]

        for file in files:
            file_path = Path(root) / file

            # Only process code files
            if file_path.suffix.lower() not in CODE_EXTENSIONS:
                continue

            try:
                with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
                    lines = f.readlines()

                for line_num, line in enumerate(lines, 1):
                    # Look for TODO comments (case insensitive)
                    if re.search(r"#\s*TODO:", line, re.IGNORECASE):
                        # Get context: current line + 2 lines before and after
                        start_line = max(0, line_num - 3)
                        end_line = min(len(lines), line_num + 2)
                        context_lines = lines[start_line:end_line]

                        todos.append(
                            {
                                "file": str(file_path),
                                "line_number": line_num,
                                "todo_line": line.strip(),
                                "context": context_lines,
                                "context_start": start_line + 1,
                            }
                        )

            except Exception as e:
                print(f"Warning: Could not read {file_path}: {e}")

    # Generate markdown report
    generate_markdown_report(todos, output_file)
    return len(todos)


def generate_markdown_report(todos, output_file):
    """Generate markdown report from TODO items."""

    with open(output_file, "w", encoding="utf-8") as f:
        f.write(f"# TODO Report\n\n")
        f.write(f"Generated on: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")
        f.write(f"Total TODOs found: {len(todos)}\n\n")

        if not todos:
            f.write("No TODO comments found!\n")
            return

        # Group by file
        files_with_todos = {}
        for todo in todos:
            file_path = todo["file"]
            if file_path not in files_with_todos:
                files_with_todos[file_path] = []
            files_with_todos[file_path].append(todo)

        # Write TODOs organized by file
        for file_path, file_todos in sorted(files_with_todos.items()):
            f.write(f"## {file_path}\n\n")

            for todo in file_todos:
                f.write(f"### Line {todo['line_number']}\n\n")
                f.write(f"**TODO:** `{todo['todo_line']}`\n\n")
                f.write("**Context:**\n\n")
                f.write(
                    "```python\n"
                )  # You can change this to match your primary language

                for i, context_line in enumerate(todo["context"]):
                    line_num = todo["context_start"] + i
                    marker = ">>>" if line_num == todo["line_number"] else "   "
                    f.write(f"{marker} {line_num:3d}: {context_line.rstrip()}\n")

                f.write("```\n\n")
                f.write("---\n\n")


def main():
    """Main function with command line argument support."""
    import argparse

    parser = argparse.ArgumentParser(
        description="Extract TODO comments from code files"
    )
    parser.add_argument(
        "directory",
        nargs="?",
        default=".",
        help="Directory to scan (default: current directory)",
    )
    parser.add_argument(
        "-o",
        "--output",
        default="TODO.md",
        help="Output markdown file (default: TODO.md)",
    )
    parser.add_argument(
        "--extensions",
        nargs="*",
        help="Additional file extensions to include (e.g., .txt .cfg)",
    )

    args = parser.parse_args()

    # Add custom extensions if provided
    if args.extensions:
        global CODE_EXTENSIONS
        CODE_EXTENSIONS.update(args.extensions)

    print(f"Scanning {args.directory} for TODO comments...")
    todo_count = find_todos(args.directory, args.output)
    print(f"Found {todo_count} TODO items")
    print(f"Report saved to: {args.output}")


if __name__ == "__main__":
    main()
