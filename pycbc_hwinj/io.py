from glue import segments

class DataEntry(object):

    def __init__(self, channel_name, seg, description="", bitmask=""):
        self.channel_name = channel_name
        self.seg = seg
        self.description = description
        self.bitmask = bitmask

    def write(self):
        vals = [self.channel_name, self.seg[0], self.seg[1],
                self.description, self.bitmask]
        return ",".join(map(str, vals))

def read_entry(line, delimiter=","):
    data = line.split(delimiter)
    i = 0
    channel_name = data[i]; i += 1
    seg = segments.segment(float(data[i]), float(data[i+1])); i += 2
    description = data[i]; i += 1
    bitmask = data[i]; i += 1
    return DataEntry(channel_name, seg, description=description,
                           bitmask=bitmask)


