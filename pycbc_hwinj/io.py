""" Module that contains classes and functions for handling the I/O for
the output of the workflow executables that check frame data.
"""

from glue import segments

class DataEntry(object):

    def __init__(self, channel_name, seglist=None, description="", bitmask=""):
        seglist = segments.segmentlist([]) if seglist is None else seglist
        self.channel_name = channel_name
        self.segmentlist = seglist
        self.description = description
        self.bitmask = bitmask

    def write(self, delimiter=","):

        # find all point excitations since segments module cannot handle
        # these well with coalesce
        point_excitations = segments.segmentlist([])
        for seg in self.segmentlist:
            if abs(seg) == 0:
                point_excitations.append(seg)

        # coalesce segmentlist
        self.segmentlist.coalesce()

        # check if point_excitation already covered
        # if not add back to segment list
        for seg in point_excitations:
            if seg not in self.segmentlist:
                self.segmentlist.append(seg)

        # concatenate data to str in
        # format: "channel_name,seg_start,seg_end,description,bitmask"
        lines = []
        for seg in self.segmentlist:
            vals = [self.channel_name, seg[0], seg[1],
                    self.description, self.bitmask]
            lines.append( delimiter.join(map(str, vals)) )

        return "\n".join(lines)

    @classmethod
    def read_entry(cls, line, delimiter=","):
        data = line.split(delimiter)
        i = 0
        channel_name = data[i]; i += 1
        seg = segments.segment(float(data[i]), float(data[i+1])); i += 2
        seglist = segments.segmentlist([])
        seglist.append(seg)
        description = data[i]; i += 1
        bitmask = data[i]; i += 1
        return cls(channel_name, seglist, description=description,
                           bitmask=bitmask)


