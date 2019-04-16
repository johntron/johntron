import xml.etree.ElementTree as ET
from gnuradio import gr
from gnuradio.grc.core.utils import odict
from gnuradio.grc.core.Platform import Platform

def xml_to_flowgraph(xml):
    '''Generates flowgraph from XML with grc.core.Platform.Platform#parse_flow_graph'''
    tree = ET.fromstring(xml)
    data = to_plain_object(tree)
    platform = Platform(
        prefs_file=gr.prefs(),
        version=gr.version(),
        version_parts=(gr.major_version(), gr.api_version(), gr.minor_version())
    )
    flow_graph = platform.get_new_flow_graph()
    flow_graph.import_data(data)
    flow_graph.rewrite()
    flow_graph.validate()
    return flow_graph

def to_plain_object(xml):
    """
    Recursively parse the xml tree into nested data format.

    Args:
        xml: the xml tree

    Returns:
        the nested data
    """
    tag = xml.tag
    if not len(xml):
        return odict({tag: xml.text or ''})  # store empty tags (text is None) as empty string
    nested_data = odict()
    for elem in xml:
        key, value = to_plain_object(elem).items()[0]
        if key in nested_data:
            nested_data[key].append(value)
        else:
            nested_data[key] = [value]
    # Delistify if the length of values is 1
    for key, values in nested_data.iteritems():
        if len(values) == 1:
            nested_data[key] = values[0]

    return odict({tag: nested_data})