import unittest
import main

class mainTest(unittest.TestCase):
    def test_setup(self):
        self.assertEqual(main.setup(),0,'Code ok.\n')