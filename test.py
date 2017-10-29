import unittest
import main

class mainTest(unittest.TestCase):
    def test_setup(self):
        self.assertEqual(main.weather_station(),0,'Code ok.\n')