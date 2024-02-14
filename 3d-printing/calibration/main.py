import FreeCAD as App
import pathlib
import os
import subprocess
import shlex

cwd = pathlib.Path(os.getcwd())
doc = pathlib.Path("/home/johntron/Development/johntron/3d-printing/nova's play doh toys/shrinkwrap.FCStd")
if not doc.exists():
    print("Document does not exist")
    exit()

def save_doc_scene(doc, filename=cwd / 'doc.png'):
    temp_dot = filename.parent / (filename.stem + '.dot')
    viz = doc.exportGraphviz()
    help(doc.exportGraphviz)
    temp_dot.write_text(viz)
    result = subprocess.run(shlex.split(f'dot -Tpng {temp_dot} -o{filename}'))
    result.check_returncode()
    temp_dot.unlink()

doc = App.openDocument(str(doc))
# save_doc_scene(doc)

d = App.ActiveDocument.getObjectsByLabel('diameter')
print(d)
print(type(d))

import debugpy
debugpy.listen(5678)
debugpy.wait_for_client()