from glue import segments

class ExcitationEntry(object):

    def __init__(self, channel_name, seg):
        self.channel_name = channel_name
        self.seg = seg

    def write(self):
        vals = [self.channel_name, self.seg[0], self.seg[1]]
        return ",".join(map(str, vals))

def read_exc_entry(line, delimiter=","):
    data = line.split(delimiter)
    i = 0
    channel_name = data[i]; i += 1
    seg = segments.segment(float(data[i]), float(data[i+1])); i += 2
    return ExcitationEntry(channel_name, seg)


