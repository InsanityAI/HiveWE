#!/usr/bin/env python3
import os

# Path to vcpkg include folder
VCPKG_INCLUDE = "build/debug-linux/vcpkg_installed/x64-linux/include"
OUTPUT_MODULEMAP = os.path.join(VCPKG_INCLUDE, "vcpkg.modulemap")

# Optional patterns to exclude (internal/test headers)
EXCLUDE_PATTERNS = [
    "*/internal/*_test.h",
    "*/internal/*_testing.h",
    "*/internal/*_mock.h",
    "*/gtest/*",
]

def is_excluded(path):
    for pat in EXCLUDE_PATTERNS:
        if os.path.fnmatch.fnmatch(path, pat):
            return True
    return False

def collect_modules(root):
    modules = []
    for entry in os.listdir(root):
        path = os.path.join(root, entry)
        if os.path.isdir(path):
            # skip directories that are likely tests or internal
            if entry.lower() in ("tests", "internal", "doc", "cmake", "example"):
                continue
            # Check if directory contains headers
            has_headers = any(f.endswith(".h") or f.endswith(".hpp") or f.endswith(".hxx") for f in os.listdir(path))
            if has_headers:
                # sanitize module name
                sanitized_name = entry.replace("-", "_")
                # prepend '_' if name starts with a digit
                if sanitized_name[0].isdigit():
                    sanitized_name = "_" + sanitized_name
                modules.append((sanitized_name, entry))
    return modules

def write_modulemap(modules):
    with open(OUTPUT_MODULEMAP, "w") as f:
        f.write("// Auto-generated modulemap for vcpkg\n\n")
        for mod_name, folder in modules:
            f.write(f'module {mod_name} {{\n')
            f.write(f'  umbrella "{folder}"\n')
            f.write(f'  export *\n')
            f.write("}\n\n")
    print(f"Modulemap written to {OUTPUT_MODULEMAP}")

modules = collect_modules(VCPKG_INCLUDE)
write_modulemap(modules)