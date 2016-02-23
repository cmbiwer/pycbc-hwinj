from glue import segments

class DataEntry(object):

    def __init__(self, channel_name, seglist, description="", bitmask=""):
        self.channel_name = channel_name
        self.segmentlist = seglist
        self.description = description
        self.bitmask = bitmask

    def write(self):
        lines = []

        self.segmentlist.coalesce()

        for seg in self.segmentlist:
            vals = [self.channel_name, seg[0], seg[1],
                    self.description, self.bitmask]
            lines.append( ",".join(map(str, vals)) )

        return "\n".join(lines)

def read_entry(line, delimiter=","):
    data = line.split(delimiter)
    i = 0
    channel_name = data[i]; i += 1
    seg = segments.segment(float(data[i]), float(data[i+1])); i += 2
    seglist = segments.segmentlist([])
    seglist.append(seg)
    description = data[i]; i += 1
    bitmask = data[i]; i += 1
    return DataEntry(channel_name, seglist, description=description,
                           bitmask=bitmask)


