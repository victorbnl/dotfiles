import os
import re
from jinja2 import Environment, FileSystemLoader, select_autoescape

with open('home/.config/i3/config.d/keybindings', 'r') as file_:

    sections = []
    bindings = []

    current_section = ''

    for line in file_:

        if line.startswith('##'):
            sections.append((current_section, bindings))
            current_section = line[3:].strip()
            bindings = []

        elif line.startswith('#'):
            comment = line[2:].lower().strip()

        elif line.startswith('bindsym'):
            binding = line.split()[1].strip()
            bindings.append((binding, comment))

    sections.append((current_section, bindings))

env = Environment(
    loader=FileSystemLoader('/'),
    autoescape=select_autoescape,
    trim_blocks=True,
    lstrip_blocks=True
)
template = env.get_template(os.path.join(os.path.dirname(os.path.realpath(__file__)), 'template.jinja2'))
output = template.render(sections=sections)

with open('KEYBINDINGS.md', 'w') as file_:
    file_.write(output)
