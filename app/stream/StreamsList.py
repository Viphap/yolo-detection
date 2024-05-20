from app.stream.Stream import Stream


class StreamsList:

    def __init__(self):
        self.dict = {}


    def get_length(self):
        return len(self.dict)


    def create_stream(self, ke, id, fps):
        stream_exists = True if id in self.dict else False

        if stream_exists:
            stream = self.get_stream(id)
            if not stream.fps == fps:
                stream.update_fps(fps)
        else:
            stream = Stream(ke, id, fps)
            self.dict[id] = stream


    def get_stream(self, id) -> Stream:
        return self.dict.get(id)
