from math import sin, cos, atan as arctan, pi

R = 11
r = 1
d = 0.5

def x(t):
    return (R + r) * cos(t) - d * cos( t * (R + r) / r )
def y(t):
    return (R + r) * sin(t) - d * sin( t * (R + r) / r )

points = []
for t in range(0, 359):
    t *= 0.0174533
    points.append([x(t), y(t)])

# print(points)

try:
    # import Part
    # points = [App.Vector(x, y, 0) for x, y in points]
    # print(points)
    # poly = Part.makePolygon(points)

    import FreeCAD as App
    import Part
    import Sketcher

    doc = App.newDocument()  

    sketch = doc.addObject("Sketcher::SketchObject", "Sketch")
    for i in range(0, len(points) - 1):
        start = points[i]
        end = points[i + 1]
        print(start, end)
        sketch.addGeometry(Part.LineSegment(App.Vector(start[0], start[1], 0),
                                            App.Vector(end[0], end[1], 0)), False)

    doc.recompute()
except ModuleNotFoundError as e:
    print(e)
