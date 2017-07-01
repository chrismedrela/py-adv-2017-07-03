
class Counter:
    def __init__(self):
        self.count = 0
        
    def increment_counter(self):
        self.count += 1
        
    def counter_should_display(self, expected):
        if str(self.count) != expected:
            raise AssertionError("Expected output to be '{}' but was '{}'".format(expected, self.result))